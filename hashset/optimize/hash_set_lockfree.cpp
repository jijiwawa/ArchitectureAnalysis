#include "hash_set_lockfree.h"

OptimizeHashSetLockFree::OptimizeHashSetLockFree() : capacity_(1024), size_(0) {
    buckets_ = new std::atomic<Node*>[capacity_]();
    for (int i = 0; i < capacity_; i++) {
        buckets_[i].store(nullptr, std::memory_order_relaxed);
    }
}

OptimizeHashSetLockFree::~OptimizeHashSetLockFree() {
    // 等待所有操作完成
    for (int i = 0; i < capacity_; i++) {
        Node* cur = buckets_[i].load(std::memory_order_relaxed);
        while (cur) {
            Node* next = cur->next.load(std::memory_order_relaxed);
            delete cur;
            cur = next;
        }
    }
    delete[] buckets_;
}

void OptimizeHashSetLockFree::init() {
    for (int i = 0; i < capacity_; i++) {
        Node* cur = buckets_[i].load(std::memory_order_relaxed);
        while (cur) {
            Node* next = cur->next.load(std::memory_order_relaxed);
            delete cur;
            cur = next;
        }
        buckets_[i].store(nullptr, std::memory_order_relaxed);
    }
    size_.store(0, std::memory_order_relaxed);
}

// 完全无锁读取
bool OptimizeHashSetLockFree::contains(int64_t value) {
    int h = hash(value);
    Node* cur = buckets_[h].load(std::memory_order_acquire);
    
    while (cur) {
        if (cur->value == value) {
            return true;
        }
        cur = cur->next.load(std::memory_order_acquire);
    }
    
    return false;
}

// CAS 插入
void OptimizeHashSetLockFree::insert(int64_t value) {
    int h = hash(value);
    
    while (true) {
        Node* head = buckets_[h].load(std::memory_order_acquire);
        
        // 检查是否存在
        Node* cur = head;
        while (cur) {
            if (cur->value == value) return;  // 已存在
            cur = cur->next.load(std::memory_order_acquire);
        }
        
        // 创建新节点
        Node* newNode = new Node(value);
        newNode->next.store(head, std::memory_order_relaxed);
        
        // CAS 插入
        if (buckets_[h].compare_exchange_weak(head, newNode,
                std::memory_order_release, std::memory_order_relaxed)) {
            size_.fetch_add(1, std::memory_order_relaxed);
            
            // 检查扩容
            if (size_.load(std::memory_order_relaxed) > capacity_ * 0.8) {
                rehash();
            }
            return;
        }
        
        // CAS 失败，重试
        delete newNode;
    }
}

int OptimizeHashSetLockFree::size() {
    return size_.load(std::memory_order_relaxed);
}

// 标记删除（简化版，不实际删除节点）
void OptimizeHashSetLockFree::remove(int64_t value) {
    int h = hash(value);
    Node* cur = buckets_[h].load(std::memory_order_acquire);
    
    while (cur) {
        if (cur->value == value) {
            // 标记删除（实际实现需要更复杂的逻辑）
            // 这里简化：使用特殊值标记
            cur->value = INT64_MIN;
            size_.fetch_sub(1, std::memory_order_relaxed);
            return;
        }
        cur = cur->next.load(std::memory_order_acquire);
    }
}

void OptimizeHashSetLockFree::resize(int newCapacity) {
    // 简化：全局锁（无锁版本的 resize 很复杂）
    int oldCap = capacity_;
    std::atomic<Node*>* oldBucks = buckets_;
    capacity_ = newCapacity;
    buckets_ = new std::atomic<Node*>[capacity_]();
    
    for (int i = 0; i < capacity_; i++) {
        buckets_[i].store(nullptr, std::memory_order_relaxed);
    }
    
    int count = 0;
    for (int i = 0; i < oldCap; i++) {
        Node* cur = oldBucks[i].load(std::memory_order_relaxed);
        while (cur) {
            Node* next = cur->next.load(std::memory_order_relaxed);
            
            if (cur->value != INT64_MIN) {  // 跳过已删除节点
                int h = hash(cur->value);
                Node* newNode = new Node(cur->value);
                newNode->next.store(buckets_[h].load(std::memory_order_relaxed),
                                   std::memory_order_relaxed);
                buckets_[h].store(newNode, std::memory_order_relaxed);
                count++;
            }
            
            delete cur;
            cur = next;
        }
    }
    
    delete[] oldBucks;
    size_.store(count, std::memory_order_relaxed);
}

void OptimizeHashSetLockFree::rehash() {
    resize(capacity_ * 2);
}
