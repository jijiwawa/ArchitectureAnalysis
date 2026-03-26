#include <iostream>
#include <chrono>
#include <thread>
#include <vector>
#include <random>
#include "../optimize/hash_set.h"
#include "../optimize/hash_set_rwlock.h"
#include "../optimize/hash_set_striped.h"

template<typename HashSetType>
double benchmark_contains(HashSetType& set, int threads, int ops_per_thread) {
    std::vector<std::thread> workers;
    std::atomic<int> total_ops{0};
    
    auto start = std::chrono::high_resolution_clock::now();
    
    for (int t = 0; t < threads; t++) {
        workers.emplace_back([&set, &total_ops, ops_per_thread, t]() {
            std::mt19937 gen(t);
            std::uniform_int_distribution<int64_t> dist(0, 1000000);
            
            for (int i = 0; i < ops_per_thread; i++) {
                int64_t key = dist(gen);
                set.contains(key);
                total_ops.fetch_add(1);
            }
        });
    }
    
    for (auto& worker : workers) {
        worker.join();
    }
    
    auto end = std::chrono::high_resolution_clock::now();
    double ms = std::chrono::duration<double, std::milli>(end - start).count();
    
    return total_ops.load() / (ms / 1000.0);  // ops/sec
}

int main() {
    const int THREADS = 8;
    const int OPS_PER_THREAD = 100000;
    const int DATA_SIZE = 50000;
    
    std::cout << "========================================\n";
    std::cout << "  Contains 性能对比测试\n";
    std::cout << "========================================\n";
    std::cout << "线程数: " << THREADS << "\n";
    std::cout << "每线程操作数: " << OPS_PER_THREAD << "\n";
    std::cout << "预插入数据: " << DATA_SIZE << "\n\n";
    
    // 测试原始版本（单锁）
    {
        OptimizeHashSet set;
        set.init();
        
        // 预插入数据
        for (int i = 0; i < DATA_SIZE; i++) {
            set.insert(i);
        }
        
        std::cout << "【原始版本（单锁）】\n";
        double ops = benchmark_contains(set, THREADS, OPS_PER_THREAD);
        std::cout << "吞吐量: " << (ops / 1000000.0) << " M ops/sec\n\n";
    }
    
    // 测试读写锁版本
    {
        OptimizeHashSet set;  // 使用 rwlock 版本
        set.init();
        
        for (int i = 0; i < DATA_SIZE; i++) {
            set.insert(i);
        }
        
        std::cout << "【读写锁版本】\n";
        double ops = benchmark_contains(set, THREADS, OPS_PER_THREAD);
        std::cout << "吞吐量: " << (ops / 1000000.0) << " M ops/sec\n\n";
    }
    
    // 测试分段锁版本
    {
        OptimizeHashSet set;  // 使用 striped 版本
        set.init();
        
        for (int i = 0; i < DATA_SIZE; i++) {
            set.insert(i);
        }
        
        std::cout << "【分段锁版本】\n";
        double ops = benchmark_contains(set, THREADS, OPS_PER_THREAD);
        std::cout << "吞吐量: " << (ops / 1000000.0) << " M ops/sec\n\n";
    }
    
    return 0;
}
