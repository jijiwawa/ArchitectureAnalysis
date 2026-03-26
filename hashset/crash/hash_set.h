#ifndef CRASH_HASH_SET_H
#define CRASH_HASH_SET_H

#include "../common/i_hash_set.h"
#include <unordered_set>

class CrashHashSet : public IHashSet {
private:
    std::unordered_set<int> data_;

public:
    void init() override;
    void insert(int value) override;
    bool contains(int value) override;
    int size() override;
    void remove(int value) override;
    void resize(int newCapacity) override;
};

#endif // CRASH_HASH_SET_H
