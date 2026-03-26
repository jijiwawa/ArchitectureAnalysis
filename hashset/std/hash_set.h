#ifndef STD_HASH_SET_H
#define STD_HASH_SET_H

#include "../common/i_hash_set.h"
#include <unordered_set>
#include <mutex>

class StdHashSet : public IHashSet {
private:
    std::unordered_set<int64_t> data_;
    std::mutex mutex_;

public:
    void init() override;
    void insert(int64_t value) override;
    bool contains(int64_t value) override;
    int size() override;
    void remove(int64_t value) override;
    void resize(int newCapacity) override;
};

#endif // STD_HASH_SET_H
