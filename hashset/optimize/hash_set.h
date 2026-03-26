#ifndef OPTIMIZE_HASH_SET_H
#define OPTIMIZE_HASH_SET_H

#include "../common/i_hash_set.h"
#include "../common/node.h"
#include <mutex>

class OptimizeHashSet : public IHashSet {
private:
    Node** buckets_;
    int capacity_;
    int size_;
    std::mutex mutex_;

    int hash(int64_t value) const;
    void rehash();
    bool containsLocked(int64_t value) const;

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
