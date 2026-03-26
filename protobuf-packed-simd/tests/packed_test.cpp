#include <gtest/gtest.h>
#include <cstring>
#include <vector>
#include <random>

extern "C" {
void bswap32_scalar(const uint32_t* src, uint32_t* dst, size_t n);
void bswap64_scalar(const uint64_t* src, uint64_t* dst, size_t n);
#if HAS_NEON
void bswap32_neon(const uint32_t* src, uint32_t* dst, size_t n);
void bswap64_neon(const uint64_t* src, uint64_t* dst, size_t n);
#endif
}

class PackedTest : public ::testing::Test {
protected:
    std::vector<uint32_t> gen_u32(size_t n) {
        std::mt19937 gen(42);
        std::vector<uint32_t> v(n);
        for (auto& x : v) x = gen();
        return v;
    }
    std::vector<uint64_t> gen_u64(size_t n) {
        std::mt19937_64 gen(42);
        std::vector<uint64_t> v(n);
        for (auto& x : v) x = gen();
        return v;
    }
};

TEST_F(PackedTest, BSwap32_Scalar) {
    auto src = gen_u32(100);
    std::vector<uint32_t> dst(100);
    bswap32_scalar(src.data(), dst.data(), 100);
    // 验证：再转一次应恢复原值
    std::vector<uint32_t> back(100);
    bswap32_scalar(dst.data(), back.data(), 100);
    EXPECT_EQ(src, back);
}

TEST_F(PackedTest, BSwap64_Scalar) {
    auto src = gen_u64(100);
    std::vector<uint64_t> dst(100);
    bswap64_scalar(src.data(), dst.data(), 100);
    std::vector<uint64_t> back(100);
    bswap64_scalar(dst.data(), back.data(), 100);
    EXPECT_EQ(src, back);
}

#if HAS_NEON
TEST_F(PackedTest, BSwap32_NEON_Consistency) {
    for (size_t n : {1, 4, 8, 16, 100, 255}) {
        auto src = gen_u32(n);
        std::vector<uint32_t> d1(n), d2(n);
        bswap32_scalar(src.data(), d1.data(), n);
        bswap32_neon(src.data(), d2.data(), n);
        EXPECT_EQ(d1, d2) << "n=" << n;
    }
}

TEST_F(PackedTest, BSwap64_NEON_Consistency) {
    for (size_t n : {1, 2, 4, 8, 100, 255}) {
        auto src = gen_u64(n);
        std::vector<uint64_t> d1(n), d2(n);
        bswap64_scalar(src.data(), d1.data(), n);
        bswap64_neon(src.data(), d2.data(), n);
        EXPECT_EQ(d1, d2) << "n=" << n;
    }
}
#endif

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
