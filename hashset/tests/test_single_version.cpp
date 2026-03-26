#include <thread>
#include <vector>
#include <iostream>
#include <random>
#include <cstdlib>
#include "../common/i_hash_set.h"

#if defined(USE_STD)
#include "../std/hash_set.h"
#define HASH_SET_TYPE StdHashSet
#elif defined(USE_BASE)
#include "../base/hash_set.h"
#define HASH_SET_TYPE BaseHashSet
#elif defined(USE_OPTIMIZE)
#include "../optimize/hash_set.h"
#define HASH_SET_TYPE OptimizeHashSet
#else
#error "Must define USE_STD, USE_BASE, or USE_OPTIMIZE"
#endif

template<typename HashSetType>
void runTest(const std::string& name, int threadCount, int opsPerThread) {
    std::cout << "\n=== Testing " << name << " ===" << std::endl;

    HashSetType set;
    set.init();

    std::vector<std::thread> threads;

    for (int t = 0; t < threadCount; ++t) {
        threads.emplace_back([&, t]() {
            std::mt19937 rng(t * 12345);
            std::uniform_int_distribution<int> dist(0, opsPerThread * 2);

            for (int i = 0; i < opsPerThread; ++i) {
                int val = dist(rng);
                set.insert(val);
                set.contains(val);
                set.remove(val);
                set.size();
            }
        });
    }

    for (auto& t : threads) {
        t.join();
    }

    std::cout << name << " completed without crash, final size=" << set.size() << std::endl;
}

int main(int argc, char* argv[]) {
    int threadCount = 32;
    int opsPerThread = 10000;

    if (argc >= 3) {
        threadCount = atoi(argv[1]);
        opsPerThread = atoi(argv[2]);
    }

    std::cout << "========================================" << std::endl;
    std::cout << "  Thread Safety Test" << std::endl;
    std::cout << "  Threads: " << threadCount << ", Ops/Thread: " << opsPerThread << std::endl;
    std::cout << "========================================" << std::endl;

#if defined(USE_STD)
    runTest<StdHashSet>("StdHashSet", threadCount, opsPerThread);
#elif defined(USE_BASE)
    runTest<BaseHashSet>("BaseHashSet", threadCount, opsPerThread);
#elif defined(USE_OPTIMIZE)
    runTest<OptimizeHashSet>("OptimizeHashSet", threadCount, opsPerThread);
#endif

    return 0;
}
