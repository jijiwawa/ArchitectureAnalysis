#include "hash_set_cache.h"

OptimizeHashSet::OptimizeHashSet() : capacity_(1024), size_(0) {
    buckets_ = new Bucket[capacity_]();
}

OptimizeHashSet::~OptimizeHashSet() {
    delete[] buckets_;
}

void OptimizeHashSet::init() {
    for (int i = 0; i < capacity_; ++i) {
        std::lock_guard<std::mutex> lock(buckets_[i].mutex);
        buckets_[i].values.clear();
        buckets_[i].fingerprints.clear();
    }
    size_.store(0);
}

void OptimizeHashSet::insert(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(buckets_[h].mutex);
    
    auto& values = buckets_[h].values;
    auto& fingerprints = buckets_[h].fingerprints;
    
    // 检查是否已存在
    uint8_t fp = fingerprint(value);
    for (size_t i = 0; i < values.size(); i++) {
        // 先比较指纹（快速过滤）
        if (fingerprints[i] == fp && values[i] == value) {
            return;  // 已存在
        }
    }
    
    // 插入（连续内存）
    values.push_back(value);
    fingerprints.push_back(fp);
    size_.fetch_add(1, std::memory_order_relaxed);
    
    // 扩容检查
    if (size_.load(std::memory_order_relaxed) > capacity_ * 0.8) {
        rehash();
    }
}

// 优化：指纹快速比较 + 缓存友好访问
bool OptimizeHashSet::contains(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(buckets_[h].mutex);
    
    auto& values = buckets_[h].values;
    auto& fingerprints = buckets_[h].fingerprints;
    
    uint8_t fp = fingerprint(value);
    size_t n = values.size();
    
    // 遍历连续内存（缓存友好）
    for (size_t i = 0; i < n; i++) {
        // 先比较指纹（1字节，快速）
        if (fingerprints[i] == fp) {
            // 指纹匹配，再比较完整值
            if (values[i] == value) {
                return true;
            }
        }
    }
    
    return false;
}

int OptimizeHashSet::size() {
    return size_.load(std::memory_order_relaxed);
}

void OptimizeHashSet::remove(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(buckets_[h].mutex);
    
    auto& values = buckets_[h].values;
    auto& fingerprints = buckets_[h].fingerprints;
    
    uint8_t fp = fingerprint(value);
    for (size_t i = 0; i < values.size(); i++) {
        if (fingerprints[i] == fp && values[i] == value) {
            // 交换删除（避免移动元素）
            values[i] = values.back();
            fingerprints[i] = fingerprints.back();
            values.pop_back();
            fingerprints.pop_back();
            size_.fetch_sub(1, std::memory_order_relaxed);
            return;
        }
    }
}

void OptimizeHashSet::resize(int newCapacity) {
    // 全局锁保护 rehash
    for (int i = 0; i < capacity_; i++) {
        buckets_[i].mutex.lock();
    }
    
    int oldCap = capacity_;
    Bucket* oldBucks = buckets_;
    capacity_ = newCapacity;
    buckets_ = new Bucket[capacity_]();
    int count = 0;
    
    for (int i = 0; i < oldCap; i++) {
        auto& values = oldBucks[i].values;
        auto& fingerprints = oldBucks[i].fingerprints;
        
        for (size_t j = 0; j < values.size(); j++) {
            int h = hash(values[j]);
            buckets_[h].values.push_back(values[j]);
            buckets_[h].fingerprints.push_back(fingerprints[j]);
            count++;
        }
    }
    
    delete[] oldBucks;
    size_.store(count, std::memory_order_relaxed);
    
    for (int i = 0; i < capacity_; i++) {
        buckets_[i].mutex.unlock();
    }
}

void OptimizeHashSet::rehash() {
    // 已持有所有锁
    int oldCap = capacity_;
    Bucket* oldBucks = buckets_;
    capacity_ *= 2;
    buckets_ = new Bucket[capacity_]();
    int count = 0;
    
    for (int i = 0; i < oldCap; i++) {
        auto& values = oldBucks[i].values;
        auto& fingerprints = oldBucks[i].fingerprints;
        
        for (size_t j = 0; j < values.size(); j++) {
            int h = hash(values[j]);
            buckets_[h].values.push_back(values[j]);
            buckets_[h].fingerprints.push_back(fingerprints[j]);
            count++;
        }
    }
    
    delete[] oldBucks;
    size_.store(count, std::memory_order_relaxed);
}
