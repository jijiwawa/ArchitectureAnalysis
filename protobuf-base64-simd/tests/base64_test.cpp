/**
 * Protobuf Base64 NEON 优化 - GTest 测试
 */

#include <gtest/gtest.h>
#include <cstring>
#include <string>
#include <vector>
#include "../src/base64_neon.h"

class Base64Test : public ::testing::Test {
protected:
    void SetUp() override {
        // 测试缓冲区
        output_ = new char[4096];
    }

    void TearDown() override {
        delete[] output_;
    }

    char* output_;
};

// ========== 基本功能测试 ==========

TEST_F(Base64Test, Scalar_EmptyString) {
    int len = base64_decode_scalar("", 0, output_);
    EXPECT_EQ(len, 0);
}

TEST_F(Base64Test, Scalar_SingleGroup) {
    // "TWFu" -> "Man"
    int len = base64_decode_scalar("TWFu", 4, output_);
    EXPECT_EQ(len, 3);
    EXPECT_EQ(std::string(output_, len), "Man");
}

TEST_F(Base64Test, Scalar_TwoGroups) {
    // "TWFuIGlz" -> "Man is"
    int len = base64_decode_scalar("TWFuIGlz", 8, output_);
    EXPECT_EQ(len, 6);
    EXPECT_EQ(std::string(output_, len), "Man is");
}

TEST_F(Base64Test, Scalar_WithPadding1) {
    // "TWE=" -> "Ma"
    int len = base64_decode_scalar("TWE=", 4, output_);
    EXPECT_EQ(len, 2);
    EXPECT_EQ(std::string(output_, len), "Ma");
}

TEST_F(Base64Test, Scalar_WithPadding2) {
    // "TQ==" -> "M"
    int len = base64_decode_scalar("TQ==", 4, output_);
    EXPECT_EQ(len, 1);
    EXPECT_EQ(std::string(output_, len), "M");
}

TEST_F(Base64Test, Scalar_LongString) {
    // "SGVsbG8gV29ybGQh" -> "Hello World!"
    int len = base64_decode_scalar("SGVsbG8gV29ybGQh", 16, output_);
    EXPECT_EQ(len, 12);
    EXPECT_EQ(std::string(output_, len), "Hello World!");
}

// ========== NEON 版本测试 ==========

#if BASE64_HAS_NEON

TEST_F(Base64Test, Neon_EmptyString) {
    int len = base64_decode_neon("", 0, output_);
    EXPECT_EQ(len, 0);
}

TEST_F(Base64Test, Neon_SingleGroup) {
    int len = base64_decode_neon("TWFu", 4, output_);
    EXPECT_EQ(len, 3);
    EXPECT_EQ(std::string(output_, len), "Man");
}

TEST_F(Base64Test, Neon_16Bytes) {
    // "TWFuIGlzIGRlYWRQ" -> "Man is deadP" (12 bytes)
    int len = base64_decode_neon("TWFuIGlzIGRlYWRQ", 16, output_);
    EXPECT_EQ(len, 12);
}

TEST_F(Base64Test, Neon_32Bytes) {
    // 32 字符 = 2 次 16 字节循环
    const char* input = "VGhpcyBpcyBhIHRlc3Qgb2YgYmFzZTY0";
    int len = base64_decode_neon(input, 32, output_);
    EXPECT_EQ(len, 24);
}

#endif

// ========== 标量 vs NEON 一致性测试 ==========

TEST_F(Base64Test, Consistency_ShortStrings) {
    std::vector<std::string> test_cases = {
        "TWFu",
        "TWFuIGlz",
        "SGVsbG8gV29ybGQh",
        "VGhpcyBpcyBhIHRlc3Q="
    };

    char output_scalar[256];
    char output_neon[256];

    for (const auto& tc : test_cases) {
        int len_s = base64_decode_scalar(tc.c_str(), tc.size(), output_scalar);

#if BASE64_HAS_NEON
        int len_n = base64_decode_neon(tc.c_str(), tc.size(), output_neon);
        EXPECT_EQ(len_s, len_n) << "Length mismatch for: " << tc;
        if (len_s > 0) {
            EXPECT_EQ(std::string(output_scalar, len_s),
                      std::string(output_neon, len_n))
                << "Content mismatch for: " << tc;
        }
#endif
    }
}

// ========== 边界测试 ==========

TEST_F(Base64Test, Edge_InvalidChar) {
    // 包含非法字符
    int len = base64_decode_scalar("TWF!", 4, output_);
    EXPECT_EQ(len, -1);  // 应该返回错误
}

TEST_F(Base64Test, Edge_AllPadding) {
    // "====" 非法
    int len = base64_decode_scalar("====", 4, output_);
    EXPECT_EQ(len, -1);  // 或者 0，取决于实现
}

// ========== 性能数据生成 ==========

TEST_F(Base64Test, DISABLED_Benchmark_Data) {
    // 生成测试数据用于基准测试
    std::string input_1k(1366, 'A');  // 1024 字节输出需要 1366 字节输入
    // 填充有效 base64 字符
    const char* chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    for (size_t i = 0; i < input_1k.size(); i++) {
        input_1k[i] = chars[i % 64];
    }

    std::cout << "1KB test input length: " << input_1k.size() << std::endl;
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
