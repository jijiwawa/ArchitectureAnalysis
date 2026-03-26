#ifndef OPTIMIZE_HASH_SET_RWLOCK_H
#define OPTIMIZE_HASH_SET_RWLOCK_H

#include "../common/i_hash_set.h"
#include "../common/node.h"
#include <shared_mutex>
#include <mutex>
#include <atomic>

// 读写锁版本
class OptimizeHashSetRwLock : public IHashSet {
private:
    Node** buckets_;
    int capacity_;
    std::atomic<int> size_;
    mutable std::shared_mutex rwlock_;  // 读写锁
    
    int hash(int64_t value) const {
        int h = value % capacity_;
        return h < 0 ? h + capacity_ : h;
    }
    
    void rehash();
    bool containsLocked(int64_t value) const;

public:
    OptimizeHashSetRwLock();
    ~OptimizeHashSetRwLock();

    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;  // 读锁
    int size() override;
    void remove(int64_t value) override;
    void resize(int newCapacity) override;
};

#endif
