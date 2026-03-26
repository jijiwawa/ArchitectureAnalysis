#include <chrono>
#include <iostream>
#include <iomanip>
#include <vector>
#include <random>

extern "C" {
void bswap32_scalar(const uint32_t* src, uint32_t* dst, size_t n);
void bswap64_scalar(const uint64_t* src, uint64_t* dst, size_t n);
void bswap32_neon(const uint32_t* src, uint32_t* dst, size_t n);
void bswap64_neon(const uint64_t* src, uint64_t* dst, size_t n);
}

double bench(auto f, auto src, auto dst, size_t n, int iters) {
    for (int i = 0; i < 10; i++) f(src, dst, n);
    auto t0 = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iters; i++) f(src, dst, n);
    return std::chrono::duration<double, std::micro>(std::chrono::high_resolution_clock::now() - t0).count() / iters;
}

int main() {
    std::cout << "Packed Decode Benchmark\n======================\n\n";
    std::cout << "| Size | Scalar (us) | NEON (us) | Speedup |\n|------|-------------|-----------|---------|\n";

    for (size_t n : {64, 256, 1024, 4096}) {
        std::vector<uint32_t> s(n), d(n);
        double t1 = bench(bswap32_scalar, s.data(), d.data(), n, 1000);
        double t2 = bench(bswap32_neon, s.data(), d.data(), n, 1000);
        std::cout << "| " << std::setw(4) << n << " | " << std::setw(11) << std::fixed << std::setprecision(2) << t1
                  << " | " << std::setw(9) << t2 << " | " << std::setw(7) << std::setprecision(2) << t1/t2 << "x |\n";
    }
    return 0;
}
