#ifndef COMMON_NODE_H
#define COMMON_NODE_H

#include <cstdint>
#include <atomic>

struct Node {
    int64_t value;
    Node* next;
    std::atomic<bool> deleted;
    Node(int64_t v) : value(v), next(nullptr), deleted(false) {}
};

#endif
