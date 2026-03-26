#include <thread>
#include <vector>
#include <cassert>
#include <iostream>
#include <random>
#include "../common/i_hash_set.h"
#include "../std/hash_set.h"

void test16Threads() {
    StdHashSet set;
    set.init();

    const int THREAD_COUNT = 16;
    const int OPS_PER_THREAD = 10000;

    std::vector<std::thread> threads;

    for (int t = 0; t < THREAD_COUNT; ++t) {
        threads.emplace_back([&set, t]() {
            if (t < 8) {
                // 8个写线程：插入不同范围的数据
                int base = t * OPS_PER_THREAD;
                for (int i = 0; i < OPS_PER_THREAD; ++i) {
                    set.insert(base + i);
                }
            } else {
                // 8个读线程：随机读取已存在的数据
                for (int i = 0; i < OPS_PER_THREAD; ++i) {
                    set.contains((i * 7) % (8 * OPS_PER_THREAD));
                }
            }
        });
    }

    for (auto& t : threads) {
        t.join();
    }

    // 验证：8写线程 × 10000 = 80000条数据
    std::cout << "test16Threads: size=" << set.size() << " (expected 80000)" << std::endl;
    assert(set.size() == 80000);
}

void testMultiReadWrite() {
    StdHashSet set;
    set.init();

    // 先插入基础数据
    for (int i = 0; i < 1000; ++i) {
        set.insert(i);
    }

    const int THREAD_COUNT = 16;
    const int OPS_PER_THREAD = 5000;
    std::vector<std::thread> threads;

    for (int t = 0; t < THREAD_COUNT; ++t) {
        threads.emplace_back([&set, t]() {
            if (t < 4) {
                // 4个写线程：插入新数据
                int base = 10000 + t * OPS_PER_THREAD;
                for (int i = 0; i < OPS_PER_THREAD; ++i) {
                    set.insert(base + i);
                }
            } else if (t < 8) {
                // 4个删除线程
                for (int i = 0; i < 250; ++i) {
                    set.remove(i);
                }
            } else {
                // 8个读线程
                for (int i = 0; i < OPS_PER_THREAD; ++i) {
                    set.contains(i * 13 % 10000);
                }
            }
        });
    }

    for (auto& t : threads) {
        t.join();
    }

    std::cout << "testMultiReadWrite: size=" << set.size() << std::endl;
}

int main() {
    std::cout << "Running thread safety stress test..." << std::endl;

    test16Threads();
    testMultiReadWrite();

    std::cout << "All thread safety tests passed!" << std::endl;
    return 0;
}
