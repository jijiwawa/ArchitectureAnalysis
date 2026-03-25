// benchmark.cpp - 性能基准测试
#include <chrono>
#include <iostream>
#include <vector>
#include <random>
#include <iomanip>
#include "../include/half_types.h"
#include "../include/half_distance.h"
#include "../include/bit_distance.h"
#include "../include/vector_distance.h"

template<typename Func, typename... Args>
double benchmark(Func func, int iterations, Args... args) {
    // 预热
    for (int i = 0; i < 10; i++) {
        func(args...);
    }
    
    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        func(args...);
    }
    auto end = std::chrono::high_resolution_clock::now();
    
    return std::chrono::duration<double, std::milli>(end - start).count() / iterations;
}

void benchmark_half_distance() {
    std::cout << "\n=== Half Precision Distance (float16) ===\n";
    std::cout << "| Dim  | Native (ms) | NEON (ms) | Speedup |\n";
    std::cout << "|------|-------------|-----------|----------|\n";
    
    std::mt19937 gen(42);
    std::uniform_real_distribution<float> dist(-10.0f, 10.0f);
    
    for (int dim : {64, 128, 256, 512, 1024, 2048}) {
        std::vector<half> a(dim), b(dim);
        for (int i = 0; i < dim; i++) {
            a[i] = float_to_half(dist(gen));
            b[i] = float_to_half(dist(gen));
        }
        
        double native_time = benchmark(halfvec_l2_squared_distance_native, 1000, dim, a.data(), b.data());
        
#ifdef __ARM_NEON
        double neon_time = benchmark(halfvec_l2_squared_distance_neon, 1000, dim, a.data(), b.data());
        double speedup = native_time / neon_time;
        std::cout << "| " << std::setw(4) << dim 
                  << " | " << std::setw(11) << std::fixed << std::setprecision(4) << native_time
                  << " | " << std::setw(9) << neon_time
                  << " | " << std::setw(7) << std::setprecision(2) << speedup << "x |\n";
#else
        std::cout << "| " << std::setw(4) << dim 
                  << " | " << std::setw(11) << std::fixed << std::setprecision(4) << native_time
                  << " | " << std::setw(9) << "N/A"
                  << " | " << std::setw(7) << "N/A |\n";
#endif
    }
}

void benchmark_bit_distance() {
    std::cout << "\n=== Bit Vector Distance ===\n";
    std::cout << "| Bytes | Native (ms) | NEON (ms) | Speedup |\n";
    std::cout << "|-------|-------------|-----------|----------|\n";
    
    std::mt19937 gen(42);
    std::uniform_int_distribution<int> dist(0, 255);
    
    for (uint32_t bytes : {64, 128, 256, 512, 1024, 2048}) {
        std::vector<uint8_t> a(bytes), b(bytes);
        for (uint32_t i = 0; i < bytes; i++) {
            a[i] = dist(gen);
            b[i] = dist(gen);
        }
        
        double native_time = benchmark(bit_hamming_distance_native, 1000, bytes, a.data(), b.data());
        
#ifdef __ARM_NEON
        double neon_time = benchmark(bit_hamming_distance_neon, 1000, bytes, a.data(), b.data());
        double speedup = native_time / neon_time;
        std::cout << "| " << std::setw(5) << bytes 
                  << " | " << std::setw(11) << std::fixed << std::setprecision(4) << native_time
                  << " | " << std::setw(9) << neon_time
                  << " | " << std::setw(7) << std::setprecision(2) << speedup << "x |\n";
#else
        std::cout << "| " << std::setw(5) << bytes 
                  << " | " << std::setw(11) << std::fixed << std::setprecision(4) << native_time
                  << " | " << std::setw(9) << "N/A"
                  << " | " << std::setw(7) << "N/A |\n";
#endif
    }
}

void benchmark_vector_distance() {
    std::cout << "\n=== Float32 Vector Distance ===\n";
    std::cout << "| Dim  | Native (ms) | NEON (ms) | Speedup |\n";
    std::cout << "|------|-------------|-----------|----------|\n";
    
    std::mt19937 gen(42);
    std::uniform_real_distribution<float> dist(-100.0f, 100.0f);
    
    for (int dim : {64, 128, 256, 512, 1024, 2048}) {
        std::vector<float> a(dim), b(dim);
        for (int i = 0; i < dim; i++) {
            a[i] = dist(gen);
            b[i] = dist(gen);
        }
        
        double native_time = benchmark(vector_l2_squared_distance_native, 1000, dim, a.data(), b.data());
        
#ifdef __ARM_NEON
        double neon_time = benchmark(vector_l2_squared_distance_neon, 1000, dim, a.data(), b.data());
        double speedup = native_time / neon_time;
        std::cout << "| " << std::setw(4) << dim 
                  << " | " << std::setw(11) << std::fixed << std::setprecision(4) << native_time
                  << " | " << std::setw(9) << neon_time
                  << " | " << std::setw(7) << std::setprecision(2) << speedup << "x |\n";
#else
        std::cout << "| " << std::setw(4) << dim 
                  << " | " << std::setw(11) << std::fixed << std::setprecision(4) << native_time
                  << " | " << std::setw(9) << "N/A"
                  << " | " << std::setw(7) << "N/A |\n";
#endif
    }
}

int main() {
    std::cout << "pgvector NEON Optimization Benchmark\n";
    std::cout << "====================================\n";
    
#ifdef __ARM_NEON
    std::cout << "Platform: ARM with NEON support\n";
#else
    std::cout << "Platform: x86 (NEON not available)\n";
#endif
    
    benchmark_half_distance();
    benchmark_bit_distance();
    benchmark_vector_distance();
    
    return 0;
}
