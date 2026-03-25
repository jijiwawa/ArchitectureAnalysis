// SIMD 性能基准测试模板
#include <chrono>
#include <iostream>
#include <vector>
#include <random>
#include <iomanip>

extern "C" {
    void func_native(const float* a, const float* b, float* c, int n);
    void func_neon(const float* a, const float* b, float* c, int n);
}

class Benchmark {
public:
    std::vector<float> generate_data(int n) {
        std::vector<float> data(n);
        std::mt19937 gen(42);
        std::uniform_real_distribution<float> dist(-100.0f, 100.0f);
        for (int i = 0; i < n; i++) {
            data[i] = dist(gen);
        }
        return data;
    }

    double measure_time(void (*func)(const float*, const float*, float*, int),
                        const float* a, const float* b, float* c, int n,
                        int iterations = 1000) {
        // 预热
        for (int i = 0; i < 10; i++) {
            func(a, b, c, n);
        }
        
        auto start = std::chrono::high_resolution_clock::now();
        for (int i = 0; i < iterations; i++) {
            func(a, b, c, n);
        }
        auto end = std::chrono::high_resolution_clock::now();
        
        return std::chrono::duration<double, std::milli>(end - start).count() / iterations;
    }

    void run(int n, int iterations = 1000) {
        auto a = generate_data(n);
        auto b = generate_data(n);
        std::vector<float> c_native(n), c_neon(n);
        
        double native_time = measure_time(func_native, a.data(), b.data(), c_native.data(), n, iterations);
        double neon_time = measure_time(func_neon, a.data(), b.data(), c_neon.data(), n, iterations);
        
        double speedup = native_time / neon_time;
        double throughput = (n * sizeof(float) * 3.0 / 1024.0 / 1024.0) / (neon_time / 1000.0);  // MB/s
        
        std::cout << "| " << std::setw(8) << n 
                  << " | " << std::setw(10) << std::fixed << std::setprecision(3) << native_time << " ms"
                  << " | " << std::setw(10) << neon_time << " ms"
                  << " | " << std::setw(7) << std::setprecision(2) << speedup << "x"
                  << " | " << std::setw(10) << std::setprecision(2) << throughput << " MB/s"
                  << " |" << std::endl;
    }
};

int main() {
    std::cout << "SIMD Performance Benchmark" << std::endl;
    std::cout << "==========================" << std::endl;
    std::cout << "| Size     | Native     | NEON       | Speedup | Throughput |" << std::endl;
    std::cout << "|----------|------------|------------|---------|------------|" << std::endl;
    
    Benchmark bench;
    for (int n : {64, 128, 256, 512, 1024, 2048, 4096, 8192}) {
        bench.run(n);
    }
    
    return 0;
}
