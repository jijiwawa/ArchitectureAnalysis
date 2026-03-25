// test_all.cpp - GTest 测试文件
#include <gtest/gtest.h>
#include <cmath>
#include <vector>
#include <random>
#include <cstring>
#include "../include/half_types.h"
#include "../include/half_distance.h"
#include "../include/bit_distance.h"
#include "../include/vector_distance.h"

// ============== Half Vector Tests ==============

class HalfDistanceTest : public ::testing::Test {
protected:
    std::vector<half> generate_random_half(int n, float min_val = -10.0f, float max_val = 10.0f) {
        std::vector<half> data(n);
        std::mt19937 gen(42);
        std::uniform_real_distribution<float> dist(min_val, max_val);
        for (int i = 0; i < n; i++) {
            data[i] = float_to_half(dist(gen));
        }
        return data;
    }
    
    bool float_equal(float a, float b, float eps = 1e-5f) {
        if (std::isnan(a) && std::isnan(b)) return true;
        if (std::isinf(a) && std::isinf(b)) return (a > 0) == (b > 0);
        return std::fabs(a - b) < eps;
    }
};

TEST_F(HalfDistanceTest, L2SquaredDistance_Small) {
    for (int dim : {4, 8, 16, 32}) {
        auto a = generate_random_half(dim);
        auto b = generate_random_half(dim);
        
        float native = halfvec_l2_squared_distance_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        float neon = halfvec_l2_squared_distance_neon(dim, a.data(), b.data());
        EXPECT_TRUE(float_equal(native, neon)) << "dim=" << dim;
#endif
    }
}

TEST_F(HalfDistanceTest, L2SquaredDistance_Large) {
    for (int dim : {128, 256, 512, 1024}) {
        auto a = generate_random_half(dim);
        auto b = generate_random_half(dim);
        
        float native = halfvec_l2_squared_distance_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        float neon = halfvec_l2_squared_distance_neon(dim, a.data(), b.data());
        EXPECT_TRUE(float_equal(native, neon, 1e-4f)) << "dim=" << dim;
#endif
    }
}

TEST_F(HalfDistanceTest, InnerProduct) {
    for (int dim : {4, 16, 64, 256}) {
        auto a = generate_random_half(dim);
        auto b = generate_random_half(dim);
        
        float native = halfvec_inner_product_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        float neon = halfvec_inner_product_neon(dim, a.data(), b.data());
        EXPECT_TRUE(float_equal(native, neon)) << "dim=" << dim;
#endif
    }
}

TEST_F(HalfDistanceTest, CosineSimilarity) {
    for (int dim : {4, 16, 64, 256}) {
        auto a = generate_random_half(dim);
        auto b = generate_random_half(dim);
        
        double native = halfvec_cosine_similarity_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        double neon = halfvec_cosine_similarity_neon(dim, a.data(), b.data());
        EXPECT_NEAR(native, neon, 1e-6) << "dim=" << dim;
#endif
    }
}

TEST_F(HalfDistanceTest, L1Distance) {
    for (int dim : {4, 16, 64, 256}) {
        auto a = generate_random_half(dim);
        auto b = generate_random_half(dim);
        
        float native = halfvec_l1_distance_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        float neon = halfvec_l1_distance_neon(dim, a.data(), b.data());
        EXPECT_TRUE(float_equal(native, neon)) << "dim=" << dim;
#endif
    }
}

// ============== Bit Vector Tests ==============

class BitDistanceTest : public ::testing::Test {
protected:
    std::vector<uint8_t> generate_random_bits(uint32_t bytes) {
        std::vector<uint8_t> data(bytes);
        std::mt19937 gen(42);
        std::uniform_int_distribution<int> dist(0, 255);
        for (uint32_t i = 0; i < bytes; i++) {
            data[i] = dist(gen);
        }
        return data;
    }
};

TEST_F(BitDistanceTest, HammingDistance) {
    for (uint32_t bytes : {8, 16, 32, 64, 128}) {
        auto a = generate_random_bits(bytes);
        auto b = generate_random_bits(bytes);
        
        uint64_t native = bit_hamming_distance_native(bytes, a.data(), b.data());
#ifdef __ARM_NEON
        uint64_t neon = bit_hamming_distance_neon(bytes, a.data(), b.data());
        EXPECT_EQ(native, neon) << "bytes=" << bytes;
#endif
    }
}

TEST_F(BitDistanceTest, JaccardDistance) {
    for (uint32_t bytes : {8, 16, 32, 64, 128}) {
        auto a = generate_random_bits(bytes);
        auto b = generate_random_bits(bytes);
        
        double native = bit_jaccard_distance_native(bytes, a.data(), b.data());
#ifdef __ARM_NEON
        double neon = bit_jaccard_distance_neon(bytes, a.data(), b.data());
        EXPECT_NEAR(native, neon, 1e-10) << "bytes=" << bytes;
#endif
    }
}

// ============== Vector (float32) Tests ==============

class VectorDistanceTest : public ::testing::Test {
protected:
    std::vector<float> generate_random_float(int n, float min_val = -100.0f, float max_val = 100.0f) {
        std::vector<float> data(n);
        std::mt19937 gen(42);
        std::uniform_real_distribution<float> dist(min_val, max_val);
        for (int i = 0; i < n; i++) {
            data[i] = dist(gen);
        }
        return data;
    }
};

TEST_F(VectorDistanceTest, L2SquaredDistance) {
    for (int dim : {4, 16, 64, 256, 1024}) {
        auto a = generate_random_float(dim);
        auto b = generate_random_float(dim);
        
        float native = vector_l2_squared_distance_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        float neon = vector_l2_squared_distance_neon(dim, a.data(), b.data());
        EXPECT_TRUE(std::fabs(native - neon) < 1e-3f) << "dim=" << dim;
#endif
    }
}

TEST_F(VectorDistanceTest, InnerProduct) {
    for (int dim : {4, 16, 64, 256, 1024}) {
        auto a = generate_random_float(dim);
        auto b = generate_random_float(dim);
        
        float native = vector_inner_product_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        float neon = vector_inner_product_neon(dim, a.data(), b.data());
        EXPECT_TRUE(std::fabs(native - neon) < 1e-3f) << "dim=" << dim;
#endif
    }
}

TEST_F(VectorDistanceTest, CosineSimilarity) {
    for (int dim : {4, 16, 64, 256}) {
        auto a = generate_random_float(dim);
        auto b = generate_random_float(dim);
        
        double native = vector_cosine_similarity_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        double neon = vector_cosine_similarity_neon(dim, a.data(), b.data());
        EXPECT_NEAR(native, neon, 1e-6) << "dim=" << dim;
#endif
    }
}

TEST_F(VectorDistanceTest, L1Distance) {
    for (int dim : {4, 16, 64, 256, 1024}) {
        auto a = generate_random_float(dim);
        auto b = generate_random_float(dim);
        
        float native = vector_l1_distance_native(dim, a.data(), b.data());
#ifdef __ARM_NEON
        float neon = vector_l1_distance_neon(dim, a.data(), b.data());
        EXPECT_TRUE(std::fabs(native - neon) < 1e-3f) << "dim=" << dim;
#endif
    }
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
