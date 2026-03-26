#ifndef OPTIMIZE_HASH_SET_CACHE_H
#define OPTIMIZE_HASH_SET_CACHE_H

#include "../common/i_hash_set.h"
#include <mutex>
#include <atomic>
#include <vector>

// 优化版本：缓存友好的连续内存 + 哈希指纹快速比较
class OptimizeHashSet : public IHashSet {
private:
    struct Bucket {
        std::vector<int64_t> values;        // 连续内存存储
        std::vector<uint8_t> fingerprints;  // 哈希指纹（低8位）
        std::mutex mutex;
        
        Bucket() = default;
    };

    Bucket* buckets_;
    int capacity_;
    std::atomic<int> size_;
    
    // 哈希函数
    int hash(int64_t value) const {
        int h = value % capacity_;
        return h < 0 ? h + capacity_ : h;
    }
    
    // 哈希指纹（取高8位用于快速比较）
    uint8_t fingerprint(int64_t value) const {
        return static_cast<uint8_t>(value >> 56);  // 取高8位
    }
    
    void rehash();
    
public:
    OptimizeHashSet();
    ~OptimizeHashSet();

    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;  // 优化：指纹快速比较
    int size() override;
    void remove(int64_t value) override;
    void resize(int newCapacity) override;
};

#endif
