#ifndef OPTIMIZE_HASH_SET_LOCKFREE_H
#define OPTIMIZE_HASH_SET_LOCKFREE_H

#include "../common/i_hash_set.h"
#include <atomic>
#include <cstdint>

// 无锁版本：Lock-Free HashSet
class OptimizeHashSetLockFree : public IHashSet {
private:
    struct Node {
        int64_t value;
        std::atomic<Node*> next;
        
        Node(int64_t v) : value(v), next(nullptr) {}
    };

    std::atomic<Node*>* buckets_;  // 原子指针数组
    int capacity_;
    std::atomic<int> size_;
    
    int hash(int64_t value) const {
        int h = value % capacity_;
        return h < 0 ? h + capacity_ : h;
    }
    
    void rehash();

public:
    OptimizeHashSetLockFree();
    ~OptimizeHashSetLockFree();

    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;  // 完全无锁
    int size() override;
    void remove(int64_t value) override;    // 标记删除
    void resize(int newCapacity) override;
};

#endif
