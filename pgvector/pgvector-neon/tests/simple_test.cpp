// simple_test.cpp - 简单测试（无需 gtest）
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <cstring>
#include <random>
#include <chrono>
#include "half_types.h"
#include "half_distance.h"
#include "bit_distance.h"
#include "vector_distance.h"

#define ASSERT_NEAR(a, b, eps) do { \
    if (fabs((a) - (b)) > (eps)) { \
        printf("FAIL: %s != %s (diff=%g)\n", #a, #b, fabs((a)-(b))); \
        failures++; \
    } else { \
        passes++; \
    } \
} while(0)

#define ASSERT_EQ(a, b) ASSERT_NEAR(a, b, 0)

int passes = 0, failures = 0;

// 生成随机 half 向量
void gen_random_half(int n, half* data) {
    std::mt19937 gen(42);
    std::uniform_real_distribution<float> dist(-10.0f, 10.0f);
    for (int i = 0; i < n; i++) {
        data[i] = float_to_half(dist(gen));
    }
}

// 生成随机 float 向量
void gen_random_float(int n, float* data) {
    std::mt19937 gen(42);
    std::uniform_real_distribution<float> dist(-100.0f, 100.0f);
    for (int i = 0; i < n; i++) {
        data[i] = dist(gen);
    }
}

// 生成随机 bit 向量
void gen_random_bits(uint32_t n, uint8_t* data) {
    std::mt19937 gen(42);
    std::uniform_int_distribution<int> dist(0, 255);
    for (uint32_t i = 0; i < n; i++) {
        data[i] = dist(gen);
    }
}

void test_half_distance() {
    printf("\n=== Half Distance Tests ===\n");
    
    for (int dim : {4, 16, 64, 256, 512}) {
        half* a = new half[dim];
        half* b = new half[dim];
        gen_random_half(dim, a);
        gen_random_half(dim, b);
        
        float native_l2 = halfvec_l2_squared_distance_native(dim, a, b);
        float native_ip = halfvec_inner_product_native(dim, a, b);
        double native_cs = halfvec_cosine_similarity_native(dim, a, b);
        float native_l1 = halfvec_l1_distance_native(dim, a, b);
        
#ifdef __ARM_NEON
        float neon_l2 = halfvec_l2_squared_distance_neon(dim, a, b);
        float neon_ip = halfvec_inner_product_neon(dim, a, b);
        double neon_cs = halfvec_cosine_similarity_neon(dim, a, b);
        float neon_l1 = halfvec_l1_distance_neon(dim, a, b);
        
        ASSERT_NEAR(native_l2, neon_l2, 1e-4f);
        ASSERT_NEAR(native_ip, neon_ip, 1e-4f);
        ASSERT_NEAR(native_cs, neon_cs, 1e-6);
        ASSERT_NEAR(native_l1, neon_l1, 1e-4f);
        printf("dim=%4d: L2=%8.4f IP=%8.4f CS=%6.4f L1=%8.4f ✓\n", 
               dim, native_l2, native_ip, native_cs, native_l1);
#else
        printf("dim=%4d: L2=%8.4f IP=%8.4f CS=%6.4f L1=%8.4f (native only)\n", 
               dim, native_l2, native_ip, native_cs, native_l1);
#endif
        delete[] a;
        delete[] b;
    }
}

void test_bit_distance() {
    printf("\n=== Bit Distance Tests ===\n");
    
    for (uint32_t bytes : {8, 32, 128, 512, 1024}) {
        uint8_t* a = new uint8_t[bytes];
        uint8_t* b = new uint8_t[bytes];
        gen_random_bits(bytes, a);
        gen_random_bits(bytes, b);
        
        uint64_t native_hamming = bit_hamming_distance_native(bytes, a, b);
        double native_jaccard = bit_jaccard_distance_native(bytes, a, b);
        
#ifdef __ARM_NEON
        uint64_t neon_hamming = bit_hamming_distance_neon(bytes, a, b);
        double neon_jaccard = bit_jaccard_distance_neon(bytes, a, b);
        
        ASSERT_EQ(native_hamming, neon_hamming);
        ASSERT_NEAR(native_jaccard, neon_jaccard, 1e-10);
        printf("bytes=%4d: Hamming=%5lu Jaccard=%6.4f ✓\n", 
               bytes, native_hamming, native_jaccard);
#else
        printf("bytes=%4d: Hamming=%5lu Jaccard=%6.4f (native only)\n", 
               bytes, native_hamming, native_jaccard);
#endif
        delete[] a;
        delete[] b;
    }
}

void test_vector_distance() {
    printf("\n=== Vector (float32) Distance Tests ===\n");
    
    for (int dim : {4, 16, 64, 256, 512}) {
        float* a = new float[dim];
        float* b = new float[dim];
        gen_random_float(dim, a);
        gen_random_float(dim, b);
        
        float native_l2 = vector_l2_squared_distance_native(dim, a, b);
        float native_ip = vector_inner_product_native(dim, a, b);
        double native_cs = vector_cosine_similarity_native(dim, a, b);
        float native_l1 = vector_l1_distance_native(dim, a, b);
        
#ifdef __ARM_NEON
        float neon_l2 = vector_l2_squared_distance_neon(dim, a, b);
        float neon_ip = vector_inner_product_neon(dim, a, b);
        double neon_cs = vector_cosine_similarity_neon(dim, a, b);
        float neon_l1 = vector_l1_distance_neon(dim, a, b);
        
        ASSERT_NEAR(native_l2, neon_l2, 1e-4f);
        ASSERT_NEAR(native_ip, neon_ip, 1e-4f);
        ASSERT_NEAR(native_cs, neon_cs, 1e-6);
        ASSERT_NEAR(native_l1, neon_l1, 1e-4f);
        printf("dim=%4d: L2=%8.4f IP=%8.4f CS=%6.4f L1=%8.4f ✓\n", 
               dim, native_l2, native_ip, native_cs, native_l1);
#else
        printf("dim=%4d: L2=%8.4f IP=%8.4f CS=%6.4f L1=%8.4f (native only)\n", 
               dim, native_l2, native_ip, native_cs, native_l1);
#endif
        delete[] a;
        delete[] b;
    }
}

// 性能基准测试
template<typename Func, typename... Args>
double benchmark(Func func, int iterations, Args... args) {
    // 预热
    for (int i = 0; i < 10; i++) func(args...);
    
    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) func(args...);
    auto end = std::chrono::high_resolution_clock::now();
    
    return std::chrono::duration<double, std::micro>(end - start).count() / iterations;
}

void run_benchmark() {
    printf("\n=== Performance Benchmark ===\n");
    printf("| Func    | Dim   | Native (us) | NEON (us) | Speedup |\n");
    printf("|---------|-------|-------------|-----------|---------|\n");
    
    const int iterations = 10000;
    
    // Vector L2
    for (int dim : {128, 512, 1024}) {
        float* a = new float[dim];
        float* b = new float[dim];
        gen_random_float(dim, a);
        gen_random_float(dim, b);
        
        double native_time = benchmark(vector_l2_squared_distance_native, iterations, dim, a, b);
        
#ifdef __ARM_NEON
        double neon_time = benchmark(vector_l2_squared_distance_neon, iterations, dim, a, b);
        printf("| VEC-L2  | %5d | %11.2f | %9.2f | %6.2fx |\n", 
               dim, native_time, neon_time, native_time / neon_time);
#else
        printf("| VEC-L2  | %5d | %11.2f | %9s | %7s |\n", dim, native_time, "N/A", "N/A");
#endif
        delete[] a;
        delete[] b;
    }
    
    // Half L2
    for (int dim : {128, 512, 1024}) {
        half* a = new half[dim];
        half* b = new half[dim];
        gen_random_half(dim, a);
        gen_random_half(dim, b);
        
        double native_time = benchmark(halfvec_l2_squared_distance_native, iterations, dim, a, b);
        
#ifdef __ARM_NEON
        double neon_time = benchmark(halfvec_l2_squared_distance_neon, iterations, dim, a, b);
        printf("| HALF-L2 | %5d | %11.2f | %9.2f | %6.2fx |\n", 
               dim, native_time, neon_time, native_time / neon_time);
#else
        printf("| HALF-L2 | %5d | %11.2f | %9s | %7s |\n", dim, native_time, "N/A", "N/A");
#endif
        delete[] a;
        delete[] b;
    }
    
    // Bit Hamming
    for (uint32_t bytes : {128, 512, 1024}) {
        uint8_t* a = new uint8_t[bytes];
        uint8_t* b = new uint8_t[bytes];
        gen_random_bits(bytes, a);
        gen_random_bits(bytes, b);
        
        double native_time = benchmark(bit_hamming_distance_native, iterations, bytes, a, b);
        
#ifdef __ARM_NEON
        double neon_time = benchmark(bit_hamming_distance_neon, iterations, bytes, a, b);
        printf("| BIT-HAM | %5d | %11.2f | %9.2f | %6.2fx |\n", 
               bytes, native_time, neon_time, native_time / neon_time);
#else
        printf("| BIT-HAM | %5d | %11.2f | %9s | %7s |\n", bytes, native_time, "N/A", "N/A");
#endif
        delete[] a;
        delete[] b;
    }
}

int main() {
    printf("pgvector NEON Optimization Test\n");
    printf("===============================\n");
#ifdef __ARM_NEON
    printf("NEON: Enabled\n");
#else
    printf("NEON: Not available\n");
#endif
    
    test_half_distance();
    test_bit_distance();
    test_vector_distance();
    run_benchmark();
    
    printf("\n===============================\n");
    printf("Results: %d passed, %d failed\n", passes, failures);
    
    return failures > 0 ? 1 : 0;
}
