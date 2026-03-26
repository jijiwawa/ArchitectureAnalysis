#include "hash_set.h"

BaseHashSet::BaseHashSet() : capacity_(10), size_(0) {
    buckets_ = new Node*[capacity_]();
}

BaseHashSet::~BaseHashSet() {
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

int BaseHashSet::hash(int64_t value) const {
    int h = value % capacity_;
    if (h < 0) h += capacity_;
    return h;
}

void BaseHashSet::rehash() {
    int oldCap = capacity_;
    Node** oldBucks = buckets_;

    capacity_ *= 2;
    buckets_ = new Node*[capacity_]();
    size_ = 0;

    for (int i = 0; i < oldCap; ++i) {
        Node* cur = oldBucks[i];
        while (cur) {
            int h = hash(cur->value);
            Node* newN = new Node(cur->value);
            newN->next = buckets_[h];
            buckets_[h] = newN;
            ++size_;
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    delete[] oldBucks;
}

void BaseHashSet::init() {
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
    size_ = 0;
}

void BaseHashSet::insert(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);

    if (containsLocked(value)) {
        return;
    }

    int h = hash(value);
    Node* newNode = new Node(value);
    newNode->next = buckets_[h];
    buckets_[h] = newNode;
    ++size_;

    if (static_cast<double>(size_) / capacity_ > 0.9) {
        int oldCap = capacity_;
        Node** oldBucks = buckets_;

        capacity_ *= 2;
        buckets_ = new Node*[capacity_]();
        size_ = 0;

        for (int i = 0; i < oldCap; ++i) {
            Node* cur = oldBucks[i];
            while (cur) {
                int h2 = hash(cur->value);
                Node* newN = new Node(cur->value);
                newN->next = buckets_[h2];
                buckets_[h2] = newN;
                ++size_;
                Node* next = cur->next;
                delete cur;
                cur = next;
            }
        }
        delete[] oldBucks;
    }
}

bool BaseHashSet::containsLocked(int64_t value) const {
    int h = hash(value);
    Node* cur = buckets_[h];
    while (cur) {
        if (cur->value == value) {
            return true;
        }
        cur = cur->next;
    }
    return false;
}

bool BaseHashSet::contains(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);
    return containsLocked(value);
}

int BaseHashSet::size() {
    std::lock_guard<std::mutex> lock(mutex_);
    return size_;
}

void BaseHashSet::remove(int64_t value) {
    std::lock_guard<std::mutex> lock(mutex_);

    int h = hash(value);
    Node* cur = buckets_[h];
    Node* prev = nullptr;

    while (cur) {
        if (cur->value == value) {
            if (prev) {
                prev->next = cur->next;
            } else {
                buckets_[h] = cur->next;
            }
            delete cur;
            --size_;
            return;
        }
        prev = cur;
        cur = cur->next;
    }
}

void BaseHashSet::resize(int newCapacity) {
    std::lock_guard<std::mutex> lock(mutex_);

    int oldCap = capacity_;
    Node** oldBucks = buckets_;

    capacity_ = newCapacity;
    buckets_ = new Node*[capacity_]();
    size_ = 0;

    for (int i = 0; i < oldCap; ++i) {
        Node* cur = oldBucks[i];
        while (cur) {
            int h = hash(cur->value);
            Node* newN = new Node(cur->value);
            newN->next = buckets_[h];
            buckets_[h] = newN;
            ++size_;
            Node* next = cur->next;
            delete cur;
            cur = next;
        }
    }
    delete[] oldBucks;
}
