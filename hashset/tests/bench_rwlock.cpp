#include <iostream>
#include <chrono>
#include <thread>
#include <vector>
#include <random>
#include "../optimize/hash_set.h"
#include "../optimize/hash_set_rwlock.h"

template<typename HashSetType>
double benchmark_contains(HashSetType& set, int threads, int ops_per_thread) {
    auto start = std::chrono::high_resolution_clock::now();
    
    std::vector<std::thread> workers;
    
    for (int t = 0; t < threads; t++) {
        workers.emplace_back([&set, ops_per_thread, t]() {
            std::mt19937 gen(t);
            std::uniform_int_distribution<int64_t> dist(0, 1000000);
            
            for (int i = 0; i < ops_per_thread; i++) {
                int64_t key = dist(gen);
                set.contains(key);
            }
        });
    }
    
    for (auto& worker : workers) {
        worker.join();
    }
    
    auto end = std::chrono::high_resolution_clock::now();
    double ms = std::chrono::duration<double, std::milli>(end - start).count();
    
    return (threads * ops_per_thread) / (ms / 1000.0);  // ops/sec
}

template<typename HashSetType>
double benchmark_mixed(HashSetType& set, int threads, int ops_per_thread) {
    auto start = std::chrono::high_resolution_clock::now();
    
    std::vector<std::thread> workers;
    
    for (int t = 0; t < threads; t++) {
        workers.emplace_back([&set, ops_per_thread, t]() {
            std::mt19937 gen(t);
            std::uniform_int_distribution<int64_t> dist(0, 1000000);
            std::uniform_int_distribution<int> op_dist(0, 9);  // 80%读20%写
            
            for (int i = 0; i < ops_per_thread; i++) {
                int64_t key = dist(gen);
                int op = op_dist(gen);
                
                if (op < 8) {  // 80% contains
                    set.contains(key);
                } else {  // 20% insert
                    set.insert(key);
                }
            }
        });
    }
    
    for (auto& worker : workers) {
        worker.join();
    }
    
    auto end = std::chrono::high_resolution_clock::now();
    double ms = std::chrono::duration<double, std::milli>(end - start).count();
    
    return (threads * ops_per_thread) / (ms / 1000.0);
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
    std::cout << "【1. 单锁版本 - Contains 性能】\n";
    {
        OptimizeHashSet set;
        set.init();
        for (int i = 0; i < DATA_SIZE; i++) set.insert(i);
        
        double ops = benchmark_contains(set, THREADS, OPS_PER_THREAD);
        std::cout << "吞吐量: " << (ops / 1000000.0) << " M ops/sec\n\n";
    }
    
    // 测试读写锁版本
    std::cout << "【2. 读写锁版本 - Contains 性能】\n";
    {
        OptimizeHashSetRwLock set;
        set.init();
        for (int i = 0; i < DATA_SIZE; i++) set.insert(i);
        
        double ops = benchmark_contains(set, THREADS, OPS_PER_THREAD);
        std::cout << "吞吐量: " << (ops / 1000000.0) << " M ops/sec\n\n";
    }
    
    // 测试混合读写性能
    std::cout << "【3. 单锁版本 - 混合读写（80%读20%写）】\n";
    {
        OptimizeHashSet set;
        set.init();
        for (int i = 0; i < DATA_SIZE; i++) set.insert(i);
        
        double ops = benchmark_mixed(set, THREADS, OPS_PER_THREAD);
        std::cout << "吞吐量: " << (ops / 1000000.0) << " M ops/sec\n\n";
    }
    
    std::cout << "【4. 读写锁版本 - 混合读写（80%读20%写）】\n";
    {
        OptimizeHashSetRwLock set;
        set.init();
        for (int i = 0; i < DATA_SIZE; i++) set.insert(i);
        
        double ops = benchmark_mixed(set, THREADS, OPS_PER_THREAD);
        std::cout << "吞吐量: " << (ops / 1000000.0) << " M ops/sec\n\n";
    }
    
    std::cout << "========================================\n";
    std::cout << "  测试完成! ✅\n";
    std::cout << "========================================\n";
    
    return 0;
}
