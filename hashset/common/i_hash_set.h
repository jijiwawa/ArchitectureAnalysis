#ifndef COMMON_I_HASH_SET_H
#define COMMON_I_HASH_SET_H

#include <cstdint>

class IHashSet {
public:
    virtual ~IHashSet() {}
    virtual void init() = 0;
    virtual void insert(int64_t value) = 0;
    virtual bool contains(int64_t value) = 0;
    virtual int size() = 0;
    virtual void remove(int64_t value) = 0;
    virtual void resize(int newCapacity) = 0;
};

#endif // COMMON_I_HASH_SET_H
