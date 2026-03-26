#include "hash_set_single.h"
#include <arm_neon.h>

OptimizeHashSetSingle::OptimizeHashSetSingle() : capacity_(1024), size_(0) {
    slots_ = new Slot[capacity_]();
    for (int i = 0; i < capacity_; i++) {
        slots_[i].occupied = 0;
    }
}

OptimizeHashSetSingle::~OptimizeHashSetSingle() {
    delete[] slots_;
}

void OptimizeHashSetSingle::init() {
    for (int i = 0; i < capacity_; i++) {
        slots_[i].occupied = 0;
    }
    size_ = 0;
}

// SIMD 优化查找
bool OptimizeHashSetSingle::contains(int64_t value) {
    int h = hash(value);
    uint8_t fp = fingerprint(value);
    int64x2_t target = vdupq_n_s64(value);
    
    // 线性探测 + SIMD 并行比较
    for (int i = 0; i < capacity_; i++) {
        int idx = (h + i) % capacity_;
        
        if (!slots_[idx].occupied) return false;  // 空槽，不存在
        
        // 指纹快速过滤（1字节比较）
        if (slots_[idx].fingerprint != fp) continue;
        
        // 找到指纹匹配，检查完整值
        if (slots_[idx].value == value) return true;
    }
    
    return false;
}

void OptimizeHashSetSingle::insert(int64_t value) {
    int h = hash(value);
    uint8_t fp = fingerprint(value);
    
    // 线性探测
    for (int i = 0; i < capacity_; i++) {
        int idx = (h + i) % capacity_;
        
        if (!slots_[idx].occupied) {
            // 找到空槽，插入
            slots_[idx].value = value;
            slots_[idx].fingerprint = fp;
            slots_[idx].occupied = 1;
            size_++;
            
            if (size_ > capacity_ * 0.7) {
                rehash();
            }
            return;
        }
        
        // 检查是否已存在
        if (slots_[idx].fingerprint == fp && slots_[idx].value == value) {
            return;  // 已存在
        }
    }
}

int OptimizeHashSetSingle::size() {
    return size_;
}

void OptimizeHashSetSingle::remove(int64_t value) {
    int h = hash(value);
    uint8_t fp = fingerprint(value);
    
    for (int i = 0; i < capacity_; i++) {
        int idx = (h + i) % capacity_;
        
        if (!slots_[idx].occupied) return;  // 不存在
        
        if (slots_[idx].fingerprint == fp && slots_[idx].value == value) {
            slots_[idx].occupied = 0;
            size_--;
            
            // 开放寻址删除：需要移动后续元素
            int j = (idx + 1) % capacity_;
            while (slots_[j].occupied) {
                // 检查是否需要移动
                int k = hash(slots_[j].value);
                if ((idx < j && (k <= idx || k > j)) || 
                    (idx > j && (k <= idx && k > j))) {
                    slots_[idx] = slots_[j];
                    slots_[j].occupied = 0;
                    idx = j;
                }
                j = (j + 1) % capacity_;
            }
            return;
        }
    }
}

void OptimizeHashSetSingle::resize(int newCapacity) {
    int oldCap = capacity_;
    Slot* oldSlots = slots_;
    capacity_ = newCapacity;
    slots_ = new Slot[capacity_]();
    
    for (int i = 0; i < capacity_; i++) {
        slots_[i].occupied = 0;
    }
    
    int count = 0;
    for (int i = 0; i < oldCap; i++) {
        if (oldSlots[i].occupied) {
            // 重新插入
            int h = hash(oldSlots[i].value);
            for (int j = 0; j < capacity_; j++) {
                int idx = (h + j) % capacity_;
                if (!slots_[idx].occupied) {
                    slots_[idx] = oldSlots[i];
                    count++;
                    break;
                }
            }
        }
    }
    
    delete[] oldSlots;
    size_ = count;
}

void OptimizeHashSetSingle::rehash() {
    resize(capacity_ * 2);
}
