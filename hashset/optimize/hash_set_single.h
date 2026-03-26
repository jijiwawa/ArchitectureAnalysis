#ifndef OPTIMIZE_HASH_SET_SINGLE_H
#define OPTIMIZE_HASH_SET_SINGLE_H

#include "../common/i_hash_set.h"
#include "../common/node.h"
#include <mutex>
#include <atomic>

// 单线程优化版本：链表 + 无锁 size
class OptimizeHashSetSingle : public IHashSet {
private:
    Node** buckets_;
    int capacity_;
    std::atomic<int> size_;
    std::mutex mutex_;
    
    int hash(int64_t value) const {
        int h = value % capacity_;
        return h < 0 ? h + capacity_ : h;
    }
    
    void rehash();

public:
    OptimizeHashSetSingle();
    ~OptimizeHashSetSingle();

    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;
    int size() override;
    void remove(int64_t value) override;
    void resize(int newCapacity) override;
};

#endif
