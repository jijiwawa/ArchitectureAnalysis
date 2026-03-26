#include "hash_set.h"

OptimizeHashSet::OptimizeHashSet() : capacity_(1024), size_(0) {
    buckets_ = new Bucket[capacity_]();
}

OptimizeHashSet::~OptimizeHashSet() {
    delete[] buckets_;
}

void OptimizeHashSet::init() {
    std::lock_guard<std::mutex> lock(buckets_[0].mutex);
    
    for (int i = 0; i < capacity_; ++i) {
        buckets_[i].values.clear();
        buckets_[i].fingerprints.clear();
    }
    size_.store(0);
}

void OptimizeHashSet::insert(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(buckets_[h].mutex);
    
    auto& values = buckets_[h].values;
    uint8_t fp = fingerprint(value);
    
    // 检查是否存在
    for (size_t i = 0; i < values.size(); i++) {
        if (values[i] == value) return;
    }
    
    // 插入
    buckets_[h].values.push_back(value);
    buckets_[h].fingerprints.push_back(fp);
    size_.fetch_add(1, std::memory_order_relaxed);
}

bool OptimizeHashSet::contains(int64_t value) {
    int h = hash(value);
    std::lock_guard<std::mutex> lock(buckets_[h].mutex);
    
    auto& values = buckets_[h].values;
    auto& fingerprints = buckets_[h].fingerprints;
    uint8_t fp = fingerprint(value);
    
    // 快速比较：先比较指纹，再比较完整值
    for (size_t i = 0; i < values.size(); i++) {
        if (fingerprints[i] == fp && values[i] == value) {
            return true;
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
            // 交换删除
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
    std::lock_guard<std::mutex> lock(buckets_[0].mutex);
    
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
}

void OptimizeHashSet::rehash() {
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
