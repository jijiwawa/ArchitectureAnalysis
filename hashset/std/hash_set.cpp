#include "hash_set.h"

void StdHashSet::init() {
    std::lock_guard<std::mutex> lock(mutex_);
    data_.clear();
    data_.max_load_factor(0.9);
}

void StdHashSet::insert(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);
    data_.insert(value);
}

bool StdHashSet::contains(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);
    return data_.find(value) != data_.end();
}

int StdHashSet::size() {
    std::lock_guard<std::mutex> lock(mutex_);
    return static_cast<int>(data_.size());
}

void StdHashSet::remove(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);
    data_.erase(value);
}

void StdHashSet::resize(int newCapacity) {
    std::lock_guard<std::mutex> lock(mutex_);
    data_.rehash(newCapacity);
}
