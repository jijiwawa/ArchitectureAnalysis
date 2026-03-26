#ifndef OPTIMIZE_HASH_SET_STRIPED_H
#define OPTIMIZE_HASH_SET_STRIPED_H

#include "../common/i_hash_set.h"
#include "../common/node.h"
#include <mutex>
#include <atomic>
#include <vector>

// 分段锁版本
class OptimizeHashSetStriped : public IHashSet {
private:
    struct Bucket {
        Node* head;
        mutable std::mutex mutex;
        
        Bucket() : head(nullptr) {}
    };

    Bucket* buckets_;
    int capacity_;
    std::atomic<int> size_;
    int segment_count_;  // 分段数量
    int segment_size_;   // 每段桶数
    
    int hash(int64_t value) const {
        int h = value % capacity_;
        return h < 0 ? h + capacity_ : h;
    }
    
    // 获取分段锁
    std::mutex& getSegmentLock(int h) const {
        int seg = h / segment_size_;
        return buckets_[seg * segment_size_].mutex;
    }
    
    void rehash();
    bool containsLocked(int64_t value, int h) const;

public:
    OptimizeHashSetStriped();
    ~OptimizeHashSetStriped();

    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;
    int size() override;
    void remove(int64_t value) override;
    void resize(int newCapacity) override;
};

#endif
