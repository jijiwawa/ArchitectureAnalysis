#include "hash_set_striped.h"

OptimizeHashSetStriped::OptimizeHashSetStriped() : capacity_(1024), size_(0), segment_count_(16), segment_size_(64) {
    buckets_ = new Bucket[capacity_]();
}

OptimizeHashSetStriped::~OptimizeHashSetStriped() {
    // 锁定所有分段
    for (int i = 0; i < segment_count_; i++) {
        buckets_[i * segment_size_].mutex.lock();
    }
    
    for (int i = 0; i < capacity_; ++i) {
        Node* cur = buckets_[i].head;
        while (cur) {
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    delete[] buckets_;
    
    // 析构时无需解锁
}

void OptimizeHashSetStriped::init() {
    // 锁定所有分段
    for (int i = 0; i < segment_count_; i++) {
        buckets_[i * segment_size_].mutex.lock();
    }
    
    for (int i = 0; i < capacity_; ++i) {
        Node* cur = buckets_[i].head;
        while (cur) {
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
        buckets_[i].head = nullptr;
    }
    size_.store(0);
    
    // 解锁所有分段
    for (int i = 0; i < segment_count_; i++) {
        buckets_[i * segment_size_].mutex.unlock();
    }
}

bool OptimizeHashSetStriped::containsLocked(int64_t value, int h) const {
    Node* cur = buckets_[h].head;
    while (cur) {
        if (cur->value == value) return true;
        cur = cur->next;
    }
    return false;
}

void OptimizeHashSetStriped::insert(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(getSegmentLock(h));
    
    if (containsLocked(value, h)) return;
    
    Node* newNode = new Node(value);
    newNode->next = buckets_[h].head;
    buckets_[h].head = newNode;
    size_.fetch_add(1, std::memory_order_relaxed);
}

bool OptimizeHashSetStriped::contains(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(getSegmentLock(h));
    return containsLocked(value, h);
}

int OptimizeHashSetStriped::size() {
    return size_.load(std::memory_order_relaxed);
}

void OptimizeHashSetStriped::remove(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(getSegmentLock(h));

    Node* cur = buckets_[h].head;
    Node* prev = nullptr;

    while (cur) {
        if (cur->value == value) {
            if (prev) prev->next = cur->next;
            else buckets_[h].head = cur->next;
            delete cur;
            size_.fetch_sub(1, std::memory_order_relaxed);
            return;
        }
        prev = cur;
        cur = cur->next;
    }
}

void OptimizeHashSetStriped::resize(int newCapacity) {
    // 锁定所有分段（避免死锁：按顺序锁定）
    for (int i = 0; i < segment_count_; i++) {
        buckets_[i * segment_size_].mutex.lock();
    }
    
    int oldCap = capacity_;
    Bucket* oldBucks = buckets_;
    capacity_ = newCapacity;
    segment_size_ = capacity_ / segment_count_;
    buckets_ = new Bucket[capacity_]();
    int count = 0;

    for (int i = 0; i < oldCap; ++i) {
        Node* cur = oldBucks[i].head;
        while (cur) {
            int h = hash(cur->value);
            Node* newN = new Node(cur->value);
            newN->next = buckets_[h].head;
            buckets_[h].head = newN;
            count++;
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    delete[] oldBucks;
    size_.store(count, std::memory_order_relaxed);
    
    // 解锁所有分段
    for (int i = 0; i < segment_count_; i++) {
        buckets_[i * segment_size_].mutex.unlock();
    }
}

void OptimizeHashSetStriped::rehash() {
    // 已持有所有锁
    int oldCap = capacity_;
    Bucket* oldBucks = buckets_;
    capacity_ *= 2;
    segment_size_ = capacity_ / segment_count_;
    buckets_ = new Bucket[capacity_]();
    int count = 0;

    for (int i = 0; i < oldCap; ++i) {
        Node* cur = oldBucks[i].head;
        while (cur) {
            int h = hash(cur->value);
            Node* newN = new Node(cur->value);
            newN->next = buckets_[h].head;
            buckets_[h].head = newN;
            count++;
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    delete[] oldBucks;
    size_.store(count, std::memory_order_relaxed);
}
