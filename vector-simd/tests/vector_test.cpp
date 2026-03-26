#include <gtest/gtest.h>
#include <vector>
#include <random>
#include <cmath>

extern "C" {
void vec_add_scalar(const float* a, const float* b, float* c, size_t n);
void vec_mul_scalar(const float* a, const float* b, float* c, size_t n);
float dot_scalar(const float* a, const float* b, size_t n);
float l2_distance_scalar(const float* a, const float* b, size_t n);
#if HAS_NEON
void vec_add_neon(const float* a, const float* b, float* c, size_t n);
void vec_mul_neon(const float* a, const float* b, float* c, size_t n);
float dot_neon(const float* a, const float* b, size_t n);
float l2_distance_neon(const float* a, const float* b, size_t n);
#endif
}

class VecTest : public ::testing::Test {
protected:
    std::vector<float> gen(size_t n) {
        std::mt19937 gen(42);
        std::uniform_real_distribution<float> dist(-100, 100);
        std::vector<float> v(n);
        for (auto& x : v) x = dist(gen);
        return v;
    }
    bool near(float a, float b, float eps = 1e-4f) { return fabs(a - b) < eps; }
};

TEST_F(VecTest, Add) {
    auto a = gen(1000), b = gen(1000);
    std::vector<float> c1(1000), c2(1000);
    vec_add_scalar(a.data(), b.data(), c1.data(), 1000);
#if HAS_NEON
    vec_add_neon(a.data(), b.data(), c2.data(), 1000);
    for (size_t i = 0; i < 1000; i++) EXPECT_NEAR(c1[i], c2[i], 1e-4f);
#endif
}

TEST_F(VecTest, Dot) {
    auto a = gen(1000), b = gen(1000);
    float r1 = dot_scalar(a.data(), b.data(), 1000);
#if HAS_NEON
    float r2 = dot_neon(a.data(), b.data(), 1000);
    EXPECT_NEAR(r1, r2, fabs(r1) * 1e-4f);
#endif
}

TEST_F(VecTest, L2) {
    auto a = gen(1000), b = gen(1000);
    float r1 = l2_distance_scalar(a.data(), b.data(), 1000);
#if HAS_NEON
    float r2 = l2_distance_neon(a.data(), b.data(), 1000);
    EXPECT_NEAR(r1, r2, fabs(r1) * 1e-4f);
#endif
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
