// SIMD GTest 测试模板
#include <gtest/gtest.h>
#include <cmath>
#include <vector>
#include <random>

// 声明待测试函数
extern "C" {
    void func_native(const float* a, const float* b, float* c, int n);
    void func_neon(const float* a, const float* b, float* c, int n);
}

class SIMDTest : public ::testing::Test {
protected:
    std::vector<float> generate_random_data(int n, float min_val = -100.0f, float max_val = 100.0f) {
        std::vector<float> data(n);
        std::mt19937 gen(42);  // 固定种子，可复现
        std::uniform_real_distribution<float> dist(min_val, max_val);
        for (int i = 0; i < n; i++) {
            data[i] = dist(gen);
        }
        return data;
    }

    bool float_equal(float a, float b, float epsilon = 1e-6f) {
        if (std::isnan(a) && std::isnan(b)) return true;
        if (std::isinf(a) && std::isinf(b)) return (a > 0) == (b > 0);
        return std::fabs(a - b) < epsilon;
    }

    void compare_results(const float* expected, const float* actual, int n) {
        for (int i = 0; i < n; i++) {
            EXPECT_TRUE(float_equal(expected[i], actual[i]))
                << "Mismatch at index " << i 
                << ": expected=" << expected[i] 
                << ", actual=" << actual[i];
        }
    }
};

// 测试用例：空数组
TEST_F(SIMDTest, EmptyArray) {
    std::vector<float> a, b, expected, actual;
    func_native(a.data(), b.data(), expected.data(), 0);
    func_neon(a.data(), b.data(), actual.data(), 0);
    compare_results(expected.data(), actual.data(), 0);
}

// 测试用例：单元素
TEST_F(SIMDTest, SingleElement) {
    std::vector<float> a = {1.0f}, b = {2.0f};
    std::vector<float> expected(1), actual(1);
    func_native(a.data(), b.data(), expected.data(), 1);
    func_neon(a.data(), b.data(), actual.data(), 1);
    compare_results(expected.data(), actual.data(), 1);
}

// 测试用例：边界长度 (4, 8, 16)
TEST_F(SIMDTest, BoundaryLengths) {
    for (int n : {4, 8, 12, 16, 17, 32, 64, 128, 256}) {
        auto a = generate_random_data(n);
        auto b = generate_random_data(n);
        std::vector<float> expected(n), actual(n);
        
        func_native(a.data(), b.data(), expected.data(), n);
        func_neon(a.data(), b.data(), actual.data(), n);
        
        compare_results(expected.data(), actual.data(), n);
    }
}

// 测试用例：特殊值
TEST_F(SIMDTest, SpecialValues) {
    std::vector<float> a = {0.0f, -0.0f, INFINITY, -INFINITY, NAN, 1e-38f, 1e38f};
    std::vector<float> b = {0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 1.0f, 1.0f};
    int n = a.size();
    std::vector<float> expected(n), actual(n);
    
    func_native(a.data(), b.data(), expected.data(), n);
    func_neon(a.data(), b.data(), actual.data(), n);
    
    compare_results(expected.data(), actual.data(), n);
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
