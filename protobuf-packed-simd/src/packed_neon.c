/**
 * Protobuf Packed 解码 NEON 优化
 * 优化目标: 大端模式下的字节序批量转换
 */

#include <stdint.h>
#include <stddef.h>
#include <string.h>

#ifdef __ARM_NEON
#include <arm_neon.h>
#define HAS_NEON 1
#else
#define HAS_NEON 0
#endif

/* 标量版本：4 字节字节序转换 */
void bswap32_scalar(const uint32_t* src, uint32_t* dst, size_t n) {
    for (size_t i = 0; i < n; i++) {
        uint32_t x = src[i];
        dst[i] = (x >> 24) | ((x >> 8) & 0xFF00) | ((x << 8) & 0xFF0000) | (x << 24);
    }
}

/* 标量版本：8 字节字节序转换 */
void bswap64_scalar(const uint64_t* src, uint64_t* dst, size_t n) {
    for (size_t i = 0; i < n; i++) {
        uint64_t x = src[i];
        dst[i] = (x >> 56) | ((x >> 40) & 0xFF00ULL) | ((x >> 24) & 0xFF0000ULL) |
                 ((x >> 8) & 0xFF000000ULL) | ((x << 8) & 0xFF00000000ULL) |
                 ((x << 24) & 0xFF0000000000ULL) | ((x << 40) & 0xFF000000000000ULL) |
                 (x << 56);
    }
}

#if HAS_NEON

/* NEON 版本：4 字节字节序转换 */
void bswap32_neon(const uint32_t* src, uint32_t* dst, size_t n) {
    size_t i = 0;
    /* 一次处理 4 个 uint32 */
    for (; i + 4 <= n; i += 4) {
        uint32x4_t v = vld1q_u32(src + i);
        /* 使用 rev32 指令反转字节序 */
        v = vreinterpretq_u32_u8(vrev32q_u8(vreinterpretq_u8_u32(v)));
        vst1q_u32(dst + i, v);
    }
    /* 尾部处理 */
    for (; i < n; i++) {
        uint32_t x = src[i];
        dst[i] = (x >> 24) | ((x >> 8) & 0xFF00) | ((x << 8) & 0xFF0000) | (x << 24);
    }
}

/* NEON 版本：8 字节字节序转换 */
void bswap64_neon(const uint64_t* src, uint64_t* dst, size_t n) {
    size_t i = 0;
    /* 一次处理 2 个 uint64 */
    for (; i + 2 <= n; i += 2) {
        uint64x2_t v = vld1q_u64(src + i);
        /* 使用 rev64 指令反转字节序 */
        v = vreinterpretq_u64_u8(vrev64q_u8(vreinterpretq_u8_u64(v)));
        vst1q_u64(dst + i, v);
    }
    /* 尾部处理 */
    for (; i < n; i++) {
        uint64_t x = src[i];
        dst[i] = (x >> 56) | ((x >> 40) & 0xFF00ULL) | ((x >> 24) & 0xFF0000ULL) |
                 ((x >> 8) & 0xFF000000ULL) | ((x << 8) & 0xFF00000000ULL) |
                 ((x << 24) & 0xFF0000000000ULL) | ((x << 40) & 0xFF000000000000ULL) |
                 (x << 56);
    }
}

#endif /* HAS_NEON */
