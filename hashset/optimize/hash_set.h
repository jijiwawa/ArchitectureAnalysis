#ifndef OPTIMIZE_HASH_SET_H
#define OPTIMIZE_HASH_SET_H

#include "../common/i_hash_set.h"
#include "../common/node.h"
#include <mutex>
#include <atomic>

// 优化版本：无锁size + 预分配 + 优化扩容
class OptimizeHashSet : public IHashSet {
private:
    Node** buckets_;
    int capacity_;
    std::atomic<int> size_;  // 原子计数
    std::mutex mutex_;
    
    int hash(int64_t value) const {
        // 简单hash，保持快速
        int h = value % capacity_;
        return h < 0 ? h + capacity_ : h;
    }
    
    void rehash();

public:
    OptimizeHashSet();
    ~OptimizeHashSet();

    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;
    int size() override;
    void remove(int64_t value) override;
    void resize(int newCapacity) override;
};

#endif
