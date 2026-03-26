#include <chrono>
#include <iostream>
#include <iomanip>
#include <vector>
#include <random>

extern "C" {
void vec_add_scalar(const float* a, const float* b, float* c, size_t n);
void vec_mul_scalar(const float* a, const float* b, float* c, size_t n);
float dot_scalar(const float* a, const float* b, size_t n);
float l2_distance_scalar(const float* a, const float* b, size_t n);
void vec_add_neon(const float* a, const float* b, float* c, size_t n);
void vec_mul_neon(const float* a, const float* b, float* c, size_t n);
float dot_neon(const float* a, const float* b, size_t n);
float l2_distance_neon(const float* a, const float* b, size_t n);
}

std::vector<float> gen(size_t n) {
    std::mt19937 gen(42);
    std::uniform_real_distribution<float> dist(-100, 100);
    std::vector<float> v(n);
    for (auto& x : v) x = dist(gen);
    return v;
}

template<typename F>
double bench(F f, int iters) {
    for (int i = 0; i < 10; i++) f();
    auto t0 = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iters; i++) f();
    return std::chrono::duration<double, std::micro>(std::chrono::high_resolution_clock::now() - t0).count() / iters;
}

int main() {
    std::cout << "Vector SIMD Benchmark\n=====================\n\n";
    
    for (size_t n : {1024, 4096, 16384, 65536}) {
        auto a = gen(n), b = gen(n);
        std::vector<float> c(n);
        
        std::cout << "n = " << n << "\n";
        
        // Vec Add
        double t1 = bench([&]{ vec_add_scalar(a.data(), b.data(), c.data(), n); }, 5000);
        double t2 = bench([&]{ vec_add_neon(a.data(), b.data(), c.data(), n); }, 5000);
        std::cout << "  Add:  Scalar=" << std::setw(8) << t1 << "us  NEON=" << std::setw(8) << t2 << "us  Speedup=" << std::fixed << std::setprecision(2) << t1/t2 << "x\n";
        
        // Dot
        t1 = bench([&]{ dot_scalar(a.data(), b.data(), n); }, 5000);
        t2 = bench([&]{ dot_neon(a.data(), b.data(), n); }, 5000);
        std::cout << "  Dot:  Scalar=" << std::setw(8) << t1 << "us  NEON=" << std::setw(8) << t2 << "us  Speedup=" << t1/t2 << "x\n";
        
        // L2
        t1 = bench([&]{ l2_distance_scalar(a.data(), b.data(), n); }, 5000);
        t2 = bench([&]{ l2_distance_neon(a.data(), b.data(), n); }, 5000);
        std::cout << "  L2:   Scalar=" << std::setw(8) << t1 << "us  NEON=" << std::setw(8) << t2 << "us  Speedup=" << t1/t2 << "x\n\n";
    }
}
