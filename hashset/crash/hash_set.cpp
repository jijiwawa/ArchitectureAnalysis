#include "hash_set.h"

void CrashHashSet::init() {
    data_.clear();
}

void CrashHashSet::insert(int value) {
    data_.insert(value);
}

bool CrashHashSet::contains(int value) {
    return data_.find(value) != data_.end();
}

int CrashHashSet::size() {
    return static_cast<int>(data_.size());
}

void CrashHashSet::remove(int value) {
    data_.erase(value);
}

void CrashHashSet::resize(int newCapacity) {
    data_.rehash(newCapacity);
}
