#include <thread>
#include <vector>
#include <iostream>
#include <atomic>
#include <random>
#include "../common/i_hash_set.h"
#include "../base/hash_set.h"
#include "../std/hash_set.h"

template<typename HashSetType>
void runConcurrentTest(const std::string& name, int threadCount, int opsPerThread) {
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

int main() {
    const int THREAD_COUNT = 32;
    const int OPS_PER_THREAD = 50000;

    std::cout << "========================================" << std::endl;
    std::cout << "  Intensive Lock-Free vs Locked Test" << std::endl;
    std::cout << "  Threads: " << THREAD_COUNT << ", Ops/Thread: " << OPS_PER_THREAD << std::endl;
    std::cout << "========================================" << std::endl;

    std::cout << "\n--- Testing Std (with mutex) ---" << std::endl;
    for (int i = 0; i < 3; ++i) {
        std::cout << "Run " << (i + 1) << ": ";
        runConcurrentTest<StdHashSet>("StdHashSet", THREAD_COUNT, OPS_PER_THREAD);
    }

    std::cout << "\n========================================" << std::endl;
    std::cout << "All tests completed!" << std::endl;
    std::cout << "========================================" << std::endl;

    return 0;
}
