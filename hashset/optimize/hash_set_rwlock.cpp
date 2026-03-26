#include "hash_set_rwlock.h"
#include <mutex>

OptimizeHashSetRwLock::OptimizeHashSetRwLock() : capacity_(1024), size_(0) {
    buckets_ = new Node*[capacity_]();
}

OptimizeHashSetRwLock::~OptimizeHashSetRwLock() {
    std::unique_lock<std::shared_mutex> lock(rwlock_);
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

void OptimizeHashSetRwLock::init() {
    std::unique_lock<std::shared_mutex> lock(rwlock_);
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

bool OptimizeHashSetRwLock::containsLocked(int64_t value) const {
    int h = hash(value);
    Node* cur = buckets_[h];
    while (cur) {
        if (cur->value == value) return true;
        cur = cur->next;
    }
    return false;
}

void OptimizeHashSetRwLock::insert(int64_t value) {
    std::unique_lock<std::shared_mutex> lock(rwlock_);
    
    if (containsLocked(value)) return;
    
    int h = hash(value);
    Node* newNode = new Node(value);
    newNode->next = buckets_[h];
    buckets_[h] = newNode;
    size_.fetch_add(1, std::memory_order_relaxed);
    
    if (size_.load(std::memory_order_relaxed) > capacity_ * 0.8) {
        rehash();
    }
}

// 优化：使用读锁，允许多线程并发读
bool OptimizeHashSetRwLock::contains(int64_t value) {
    std::shared_lock<std::shared_mutex> lock(rwlock_);  // 读锁
    return containsLocked(value);
}

int OptimizeHashSetRwLock::size() {
    return size_.load(std::memory_order_relaxed);
}

void OptimizeHashSetRwLock::remove(int64_t value) {
    std::unique_lock<std::shared_mutex> lock(rwlock_);
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

void OptimizeHashSetRwLock::resize(int newCapacity) {
    std::unique_lock<std::shared_mutex> lock(rwlock_);
    
    int oldCap = capacity_;
    Node** oldBucks = buckets_;
    capacity_ = newCapacity;
    buckets_ = new Node*[capacity_]();
    int count = 0;

    for (int i = 0; i < oldCap; ++i) {
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

void OptimizeHashSetRwLock::rehash() {
    // 已持有写锁
    int oldCap = capacity_;
    Node** oldBucks = buckets_;
    capacity_ *= 2;
    buckets_ = new Node*[capacity_]();
    int count = 0;

    for (int i = 0; i < oldCap; ++i) {
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
