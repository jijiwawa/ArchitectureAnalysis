/**
 * Protobuf Base64 NEON 优化实现
 *
 * 原始代码: upb/json/decode.c
 * 目标平台: ARM NEON (macOS M1/M2)
 *
 * 优化策略:
 * 1. 一次处理 16 字符 (4 组) → 输出 12 字节
 * 2. 向量化查表 (使用 vtbl 指令)
 * 3. 批量位移和合并
 */

#ifndef BASE64_NEON_H
#define BASE64_NEON_H

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#ifdef __ARM_NEON
#include <arm_neon.h>
#define BASE64_HAS_NEON 1
#else
#define BASE64_HAS_NEON 0
#endif

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Base64 解码 - 原生实现（标量版本）
 *
 * @param input  Base64 编码输入
 * @param len    输入长度
 * @param output 解码输出缓冲区
 * @return 解码后字节数，-1 表示错误
 */
int base64_decode_scalar(const char* input, size_t len, char* output);

/**
 * Base64 解码 - NEON 优化版本
 *
 * @param input  Base64 编码输入
 * @param len    输入长度
 * @param output 解码输出缓冲区
 * @return 解码后字节数，-1 表示错误
 */
int base64_decode_neon(const char* input, size_t len, char* output);

/**
 * 自动选择最优实现
 */
static inline int base64_decode(const char* input, size_t len, char* output) {
#if BASE64_HAS_NEON
    return base64_decode_neon(input, len, output);
#else
    return base64_decode_scalar(input, len, output);
#endif
}

#ifdef __cplusplus
}
#endif

#endif /* BASE64_NEON_H */
