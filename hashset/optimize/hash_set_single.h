#ifndef OPTIMIZE_HASH_SET_SINGLE_H
#define OPTIMIZE_HASH_SET_SINGLE_H

#include "../common/i_hash_set.h"
#include <cstdint>

// 单线程优化版本：开放寻址 + SIMD + 指纹
class OptimizeHashSetSingle : public IHashSet {
private:
    struct Slot {
        int64_t value;
        uint8_t fingerprint;  // 哈希指纹（快速过滤）
        uint8_t occupied;
    };

    Slot* slots_;
    int capacity_;
    int size_;
    
    // 快速哈希：位运算（capacity 必须是 2 的幂）
    int hash(int64_t value) const {
        uint64_t x = static_cast<uint64_t>(value);
        x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9ULL;
        x = (x ^ (x >> 27)) * 0x94d049bb133111ebULL;
        x = x ^ (x >> 31);
        return static_cast<int>(x & (capacity_ - 1));
    }
    
    // 指纹（取高 8 位）
    uint8_t fingerprint(int64_t value) const {
        return static_cast<uint8_t>(value >> 56);
    }
    
    void rehash();

public:
    OptimizeHashSetSingle();
    ~OptimizeHashSetSingle();

    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;  // SIMD 优化
    int size() override;
    void remove(int64_t value) override;
    void resize(int newCapacity) override;
};

#endif
