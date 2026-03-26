/**
 * Protobuf Base64 NEON 优化实现
 */

#include "base64_neon.h"
#include <string.h>

/* Base64 解码查找表 - 自动生成 */
static const signed char base64_decode_table[256] = {
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  62,  -1,  63,
    52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
    15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  63,
    -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
    41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
    -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
};

/**
 * 标量版本 - 完整实现
 */
int base64_decode_scalar(const char* input, size_t len, char* output) {
    const char* ptr = input;
    const char* end = input + len;
    char* out = output;

    /* 主循环：每次处理 4 字符 */
    while (ptr + 4 <= end) {
        int v0 = base64_decode_table[(unsigned char)ptr[0]];
        int v1 = base64_decode_table[(unsigned char)ptr[1]];
        int v2 = base64_decode_table[(unsigned char)ptr[2]];
        int v3 = base64_decode_table[(unsigned char)ptr[3]];

        /* 检查 padding */
        if (ptr[3] == '=') {
            if (ptr[2] == '=') {
                /* XX== -> 1 字节 */
                if (v0 < 0 || v1 < 0) return -1;
                int val = (v0 << 18) | (v1 << 12);
                *out++ = (val >> 16) & 0xFF;
                return (int)(out - output);
            } else {
                /* XXX= -> 2 字节 */
                if (v0 < 0 || v1 < 0 || v2 < 0) return -1;
                int val = (v0 << 18) | (v1 << 12) | (v2 << 6);
                *out++ = (val >> 16) & 0xFF;
                *out++ = (val >> 8) & 0xFF;
                return (int)(out - output);
            }
        }

        /* 正常解码 */
        if (v0 < 0 || v1 < 0 || v2 < 0 || v3 < 0) return -1;

        int val = (v0 << 18) | (v1 << 12) | (v2 << 6) | v3;
        *out++ = (val >> 16) & 0xFF;
        *out++ = (val >> 8) & 0xFF;
        *out++ = val & 0xFF;
        ptr += 4;
    }

    /* 尾部处理：2 或 3 字符 */
    size_t remaining = end - ptr;
    if (remaining == 2) {
        int v0 = base64_decode_table[(unsigned char)ptr[0]];
        int v1 = base64_decode_table[(unsigned char)ptr[1]];
        if (v0 < 0 || v1 < 0) return -1;
        int val = (v0 << 18) | (v1 << 12);
        *out++ = (val >> 16) & 0xFF;
    } else if (remaining == 3) {
        int v0 = base64_decode_table[(unsigned char)ptr[0]];
        int v1 = base64_decode_table[(unsigned char)ptr[1]];
        int v2 = base64_decode_table[(unsigned char)ptr[2]];
        if (v0 < 0 || v1 < 0 || v2 < 0) return -1;
        int val = (v0 << 18) | (v1 << 12) | (v2 << 6);
        *out++ = (val >> 16) & 0xFF;
        *out++ = (val >> 8) & 0xFF;
    }

    return (int)(out - output);
}

#if BASE64_HAS_NEON

/**
 * NEON 优化版本
 * 一次处理 16 字符 = 4 组 = 12 字节输出
 */
int base64_decode_neon(const char* input, size_t len, char* output) {
    const char* ptr = input;
    const char* end = input + len;
    char* out = output;
    const char* end16 = ptr + (len & ~15);

    /* 主循环：每次 16 字节 */
    for (; ptr < end16; ptr += 16, out += 12) {
        uint8x16_t in = vld1q_u8((const uint8_t*)ptr);

        /* 查表 */
        int8_t values[16];
        uint8_t tmp[16];
        vst1q_u8(tmp, in);

        int has_error = 0;
        for (int i = 0; i < 16; i++) {
            values[i] = base64_decode_table[tmp[i]];
            if (values[i] < 0) has_error = 1;
        }

        if (has_error) {
            /* 回退到标量 */
            return base64_decode_scalar(input, len, output);
        }

        /* 4 组合并 */
        for (int g = 0; g < 4; g++) {
            const int8_t* grp = values + g * 4;
            int val = (grp[0] << 18) | (grp[1] << 12) | (grp[2] << 6) | grp[3];
            out[g * 3 + 0] = (val >> 16) & 0xFF;
            out[g * 3 + 1] = (val >> 8) & 0xFF;
            out[g * 3 + 2] = val & 0xFF;
        }
    }

    /* 剩余 < 16 字节 */
    if (ptr < end) {
        int remaining = base64_decode_scalar(ptr, end - ptr, out);
        if (remaining < 0) return -1;
        out += remaining;
    }

    return (int)(out - output);
}

#endif /* BASE64_HAS_NEON */
