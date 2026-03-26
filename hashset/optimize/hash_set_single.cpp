#include "hash_set_single.h"

OptimizeHashSetSingle::OptimizeHashSetSingle() : capacity_(1024), size_(0) {
    buckets_ = new Node*[capacity_]();
}

OptimizeHashSetSingle::~OptimizeHashSetSingle() {
    std::lock_guard<std::mutex> lock(mutex_);
    for (int i = 0; i < capacity_; ++i) {
        Node* cur = buckets_[i];
        while (cur) {
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    delete[] buckets_;
}

void OptimizeHashSetSingle::init() {
    std::lock_guard<std::mutex> lock(mutex_);
    for (int i = 0; i < capacity_; ++i) {
        Node* cur = buckets_[i];
        while (cur) {
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
        buckets_[i] = nullptr;
    }
    size_.store(0);
}

void OptimizeHashSetSingle::insert(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);
    
    int h = hash(value);
    
    // 检查是否存在
    Node* cur = buckets_[h];
    while (cur) {
        if (cur->value == value) return;
        cur = cur->next;
    }
    
    // 头插法
    Node* newNode = new Node(value);
    newNode->next = buckets_[h];
    buckets_[h] = newNode;
    size_.fetch_add(1, std::memory_order_relaxed);
    
    if (size_.load(std::memory_order_relaxed) > capacity_ * 0.8) {
        rehash();
    }
}

// 优化：无锁读取（单线程场景）
bool OptimizeHashSetSingle::contains(int64_t value) {
    int h = hash(value);
    Node* cur = buckets_[h];
    while (cur) {
        if (cur->value == value) return true;
        cur = cur->next;
    }
    return false;
}

int OptimizeHashSetSingle::size() {
    return size_.load(std::memory_order_relaxed);
}

void OptimizeHashSetSingle::remove(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);
    int h = hash(value);
    Node* cur = buckets_[h];
    Node* prev = nullptr;
    
    while (cur) {
        if (cur->value == value) {
            if (prev) prev->next = cur->next;
            else buckets_[h] = cur->next;
            delete cur;
            size_.fetch_sub(1, std::memory_order_relaxed);
            return;
        }
        prev = cur;
        cur = cur->next;
    }
}

void OptimizeHashSetSingle::resize(int newCapacity) {
    std::lock_guard<std::mutex> lock(mutex_);
    
    int oldCap = capacity_;
    Node** oldBucks = buckets_;
    capacity_ = newCapacity;
    buckets_ = new Node*[capacity_]();
    int count = 0;
    
    for (int i = 0; i < oldCap; i++) {
        Node* cur = oldBucks[i];
        while (cur) {
            int h = hash(cur->value);
            Node* newN = new Node(cur->value);
            newN->next = buckets_[h];
            buckets_[h] = newN;
            count++;
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    
    delete[] oldBucks;
    size_.store(count, std::memory_order_relaxed);
}

void OptimizeHashSetSingle::rehash() {
    // 已持有锁
    int oldCap = capacity_;
    Node** oldBucks = buckets_;
    capacity_ *= 2;
    buckets_ = new Node*[capacity_]();
    int count = 0;
    
    for (int i = 0; i < oldCap; i++) {
        Node* cur = oldBucks[i];
        while (cur) {
            int h = hash(cur->value);
            Node* newN = new Node(cur->value);
            newN->next = buckets_[h];
            buckets_[h] = newN;
            count++;
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    
    delete[] oldBucks;
    size_.store(count, std::memory_order_relaxed);
}
