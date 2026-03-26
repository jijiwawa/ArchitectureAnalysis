// Base64 性能基准测试
#include <chrono>
#include <iostream>
#include <vector>
#include <random>
#include <iomanip>
#include <cstring>

extern "C" {
#include "../src/base64_neon.h"
}

class Benchmark {
public:
    std::vector<char> generate_base64_data(size_t output_bytes) {
        // 输出字节数 -> base64 输入长度 (4/3 比例)
        size_t input_len = ((output_bytes + 2) / 3) * 4;
        std::vector<char> data(input_len);
        
        const char* chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        std::mt19937 gen(42);
        std::uniform_int_distribution<> dist(0, 63);
        
        for (size_t i = 0; i < input_len; i++) {
            data[i] = chars[dist(gen)];
        }
        return data;
    }

    double measure(auto func, const char* input, size_t len, char* output, int iterations) {
        // 预热
        for (int i = 0; i < 10; i++) {
            func(input, len, output);
        }
        
        auto start = std::chrono::high_resolution_clock::now();
        for (int i = 0; i < iterations; i++) {
            func(input, len, output);
        }
        auto end = std::chrono::high_resolution_clock::now();
        
        return std::chrono::duration<double, std::milli>(end - start).count() / iterations;
    }

    void run(size_t output_bytes, int iterations = 1000) {
        auto input = generate_base64_data(output_bytes);
        std::vector<char> output_scalar(output_bytes + 16);
        std::vector<char> output_neon(output_bytes + 16);
        
        double t_scalar = measure(base64_decode_scalar, input.data(), input.size(), output_scalar.data(), iterations);
        double t_neon = measure(base64_decode_neon, input.data(), input.size(), output_neon.data(), iterations);
        
        // 验证结果一致
        bool match = (memcmp(output_scalar.data(), output_neon.data(), output_bytes) == 0);
        
        double speedup = t_scalar / t_neon;
        double throughput = (output_bytes / 1024.0 / 1024.0) / (t_neon / 1000.0);  // MB/s
        
        std::cout << "| " << std::setw(7) << output_bytes
                  << " | " << std::setw(9) << std::fixed << std::setprecision(3) << t_scalar << " ms"
                  << " | " << std::setw(9) << t_neon << " ms"
                  << " | " << std::setw(7) << std::setprecision(2) << speedup << "x"
                  << " | " << std::setw(9) << std::setprecision(2) << throughput << " MB/s"
                  << " | " << (match ? "✓" : "✗")
                  << " |" << std::endl;
    }
};

int main() {
    std::cout << "\n";
    std::cout << "Base64 Decode Performance Benchmark (ARM NEON)\n";
    std::cout << "==============================================\n\n";
    std::cout << "| Size (B) | Scalar     | NEON       | Speedup | Throughput | Match |\n";
    std::cout << "|----------|------------|------------|---------|------------|-------|\n";
    
    Benchmark bench;
    
    // 不同数据规模测试
    for (size_t size : {64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768}) {
        int iterations = (size < 1024) ? 5000 : (size < 8192) ? 1000 : 500;
        bench.run(size, iterations);
    }
    
    std::cout << "\n注：Speedup > 1 表示 NEON 更快\n";
    std::cout << "    Throughput = 解码输出字节 / 时间\n";
    
    return 0;
}
