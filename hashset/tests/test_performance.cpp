#include <iostream>
#include <thread>
#include <vector>
#include <chrono>
#include <random>
#include <atomic>
#include <cstring>
#include <algorithm>
#include <cmath>
#include "../common/i_hash_set.h"
#include "../std/hash_set.h"
#include "../base/hash_set.h"
#include "../optimize/hash_set.h"

struct Config {
    std::string impl = "optimize";
    int threads = 32;
    int scale = 1000000;
    int seed = 42;
    int runs = 1;
    std::string distribution = "uniform";
};

void printUsage(const char* prog) {
    std::cout << "Usage: " << prog << " [options]\n"
              << "Options:\n"
              << "  --impl=<name>        Implementation: std, base, optimize (default: optimize)\n"
              << "  --threads=<n>        Number of threads (default: 32)\n"
              << "  --scale=<n>          Data scale - insert/query count (default: 1000000)\n"
              << "  --distribution=<t>    Distribution: uniform, gaussian, localized (default: uniform)\n"
              << "  --runs=<n>           Number of runs for averaging (default: 1)\n"
              << "  --help               Show this help message\n";
}

bool parseArgs(int argc, char* argv[], Config& cfg) {
    for (int i = 1; i < argc; ++i) {
        if (strcmp(argv[i], "--help") == 0) {
            printUsage(argv[0]);
            return false;
        }
        if (strncmp(argv[i], "--impl=", 7) == 0) {
            cfg.impl = argv[i] + 7;
        } else if (strncmp(argv[i], "--threads=", 10) == 0) {
            cfg.threads = std::atoi(argv[i] + 10);
        } else if (strncmp(argv[i], "--scale=", 8) == 0) {
            cfg.scale = std::atoi(argv[i] + 8);
        } else if (strncmp(argv[i], "--runs=", 7) == 0) {
            cfg.runs = std::atoi(argv[i] + 7);
        } else if (strncmp(argv[i], "--distribution=", 15) == 0) {
            cfg.distribution = argv[i] + 15;
        }
    }
    if (cfg.impl != "std" && cfg.impl != "base" && cfg.impl != "optimize") {
        std::cerr << "Error: impl must be std, base, or optimize\n";
        return false;
    }
    if (cfg.distribution != "uniform" && cfg.distribution != "gaussian" && cfg.distribution != "localized") {
        std::cerr << "Error: distribution must be uniform, gaussian or localized\n";
        return false;
    }
    if (cfg.threads <= 0 || cfg.scale <= 0) {
        std::cerr << "Error: threads and scale must be positive\n";
        return false;
    }
    return true;
}

IHashSet* createHashSet(const std::string& impl) {
    if (impl == "std") return new StdHashSet();
    if (impl == "base") return new BaseHashSet();
    return new OptimizeHashSet();
}

template<typename Func>
double measureTimeMs(Func f, int iterations = 1) {
    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iterations; ++i) {
        f();
    }
    auto end = std::chrono::high_resolution_clock::now();
    return std::chrono::duration<double, std::milli>(end - start).count() / iterations;
}

std::vector<int> generatePool(const std::string& distribution, int scale, int seed) {
    std::mt19937 rng(seed);
    std::vector<int> values(2 * scale);

    if (distribution == "gaussian") {
        std::normal_distribution<double> dist(static_cast<double>(scale),
                                               static_cast<double>(scale) / 4.0);
        for (int i = 0; i < 2 * scale; ++i) {
            double v = dist(rng);
            if (v < 0) v = 0;
            if (v >= 2.0 * scale) v = 2.0 * scale - 1;
            values[i] = static_cast<int>(v);
        }
    } else if (distribution == "localized") {
        // 90% 数据集中在均值附近（窄高斯），stddev=scale/20 即 3sigma 覆盖约 30% 范围
        std::normal_distribution<double> hotDist(static_cast<double>(scale),
                                                  static_cast<double>(scale) / 20.0);
        std::uniform_int_distribution<int> coldDist(0, 2 * scale - 1);
        std::bernoulli_distribution hotSelector(0.9);
        for (int i = 0; i < 2 * scale; ++i) {
            double v;
            if (hotSelector(rng)) {
                v = hotDist(rng);
            } else {
                v = coldDist(rng);
            }
            if (v < 0) v = 0;
            if (v >= 2.0 * scale) v = 2.0 * scale - 1;
            values[i] = static_cast<int>(v);
        }
    } else {
        std::uniform_int_distribution<int> dist(0, 2 * scale - 1);
        for (int i = 0; i < 2 * scale; ++i) {
            values[i] = dist(rng);
        }
    }
    return values;
}

void runBenchmark(const Config& cfg) {
    int numThreads = cfg.threads;
    int runs = cfg.runs;

    std::cout << "=================================================\n";
    std::cout << "  Performance Benchmark\n";
    std::cout << "=================================================\n";
    std::cout << "Implementation: " << cfg.impl << "\n";
    std::cout << "Threads:        " << numThreads << "\n";
    std::cout << "Scale:          " << cfg.scale << "\n";
    std::cout << "Distribution:   " << cfg.distribution << "\n";
    std::cout << "Runs:           " << runs << " (average)\n";
    std::cout << "-------------------------------------------------\n";

    // === WARMUP: 1 round, not timed ===
    {
        IHashSet* warmupSet = createHashSet(cfg.impl);
        std::vector<int> warmupData = generatePool(cfg.distribution, cfg.scale, 0);
        std::mt19937 warmupRng(0);
        std::shuffle(warmupData.begin(), warmupData.begin() + cfg.scale, warmupRng);
        warmupSet->init();

        // warmup insert
        {
            std::vector<std::thread> threads;
            int opsPerThread = cfg.scale / numThreads;
            for (int t = 0; t < numThreads; ++t) {
                threads.emplace_back([warmupSet, t, opsPerThread, &warmupData]() {
                    int start = t * opsPerThread;
                    int end = start + opsPerThread;
                    for (int i = start; i < end; ++i) {
                        warmupSet->insert(warmupData[i]);
                    }
                });
            }
            for (auto& t : threads) t.join();
        }

        // warmup contains
        std::shuffle(warmupData.begin(), warmupData.end(), warmupRng);
        {
            std::vector<std::thread> threads;
            int opsPerThread = cfg.scale / numThreads;
            for (int t = 0; t < numThreads; ++t) {
                threads.emplace_back([warmupSet, t, opsPerThread, &warmupData]() {
                    int start = t * opsPerThread;
                    int end = start + opsPerThread;
                    for (int i = start; i < end; ++i) {
                        warmupSet->contains(warmupData[i]);
                    }
                });
            }
            for (auto& t : threads) t.join();
        }
        delete warmupSet;
    }
    // === END WARMUP ===

    std::vector<double> insertTimes, containsTimes;
    std::vector<double> insertThroughputs, containsThroughputs;

    for (int r = 0; r < runs; ++r) {
        IHashSet* set = createHashSet(cfg.impl);

        // 生成数据池（2*scale 条），两次 shuffle 实现 ~50% 命中率
        std::vector<int> data = generatePool(cfg.distribution, cfg.scale, cfg.seed + r);
        std::mt19937 rng(cfg.seed + r);

        // 第一次 shuffle：打乱前 scale 条用于插入
        std::shuffle(data.begin(), data.begin() + cfg.scale, rng);

        set->init();

        double insertTime = measureTimeMs([&]() {
            std::vector<std::thread> threads;
            int opsPerThread = cfg.scale / numThreads;

            for (int t = 0; t < numThreads; ++t) {
                threads.emplace_back([set, t, opsPerThread, &data]() {
                    int start = t * opsPerThread;
                    int end = start + opsPerThread;
                    for (int i = start; i < end; ++i) {
                        set->insert(data[i]);
                    }
                });
            }
            for (auto& t : threads) {
                t.join();
            }
        });

        long long insertOps = (long long)cfg.scale;
        double insertThroughput = insertOps / (insertTime / 1000.0);
        insertTimes.push_back(insertTime);
        insertThroughputs.push_back(insertThroughput);

        // 第二次 shuffle：打乱全部用于查询，取前 scale 条
        // 与插入数据的交集期望为 scale/2 → ~50% 命中率
        std::shuffle(data.begin(), data.end(), rng);

        double containsTime = measureTimeMs([&]() {
            std::vector<std::thread> threads;
            int opsPerThread = cfg.scale / numThreads;

            for (int t = 0; t < numThreads; ++t) {
                threads.emplace_back([set, t, opsPerThread, &data]() {
                    int start = t * opsPerThread;
                    int end = start + opsPerThread;
                    for (int i = start; i < end; ++i) {
                        set->contains(data[i]);
                    }
                });
            }
            for (auto& t : threads) {
                t.join();
            }
        });
        long long containsOps = (long long)cfg.scale;
        double containsThroughput = containsOps / (containsTime / 1000.0);
        containsTimes.push_back(containsTime);
        containsThroughputs.push_back(containsThroughput);

        delete set;
    }

    // 计算平均值和标准差
    double avgInsertTime = 0, avgContainsTime = 0;
    double avgInsertThroughput = 0, avgContainsThroughput = 0;
    for (int i = 0; i < runs; ++i) {
        avgInsertTime += insertTimes[i];
        avgContainsTime += containsTimes[i];
        avgInsertThroughput += insertThroughputs[i];
        avgContainsThroughput += containsThroughputs[i];
    }
    avgInsertTime /= runs;
    avgContainsTime /= runs;
    avgInsertThroughput /= runs;
    avgContainsThroughput /= runs;

    double stdInsertTime = 0, stdContainsTime = 0;
    for (int i = 0; i < runs; ++i) {
        stdInsertTime += (insertTimes[i] - avgInsertTime) * (insertTimes[i] - avgInsertTime);
        stdContainsTime += (containsTimes[i] - avgContainsTime) * (containsTimes[i] - avgContainsTime);
    }
    stdInsertTime = sqrt(stdInsertTime / runs);
    stdContainsTime = sqrt(stdContainsTime / runs);

    std::cout << "INSERT:         " << avgInsertTime << " ms (+/- " << stdInsertTime << ")"
              << " (" << avgInsertThroughput/1000000 << " M ops/sec)\n";
    std::cout << "CONTAINS:       " << avgContainsTime << " ms (+/- " << stdContainsTime << ")"
              << " (" << avgContainsThroughput/1000000 << " M ops/sec)\n";
    std::cout << "-------------------------------------------------\n";
    std::cout << "=================================================\n";

    std::cout << "\n{"
              << "\"impl\":\"" << cfg.impl << "\","
              << "\"threads\":" << numThreads << ","
              << "\"scale\":" << cfg.scale << ","
              << "\"distribution\":\"" << cfg.distribution << "\","
              << "\"runs\":" << runs << ","
              << "\"insert_ms\":" << avgInsertTime << ","
              << "\"insert_std\":" << stdInsertTime << ","
              << "\"insert_ops_sec\":" << (long long)avgInsertThroughput << ","
              << "\"contains_ms\":" << avgContainsTime << ","
              << "\"contains_std\":" << stdContainsTime << ","
              << "\"contains_ops_sec\":" << (long long)avgContainsThroughput
              << "}\n";
}

int main(int argc, char* argv[]) {
    Config cfg;
    if (!parseArgs(argc, argv, cfg)) {
        return 1;
    }
    runBenchmark(cfg);
    return 0;
}
