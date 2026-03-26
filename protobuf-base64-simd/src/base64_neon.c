/**
 * Protobuf Base64 NEON 优化实现
 */

#include "base64_neon.h"
#include <string.h>

/* Base64 解码查找表 - 从 Protobuf upb/json/decode.c 复制 */
static const signed char base64_decode_table[256] = {
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, 62, -1, 63, 52,
    53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1,
     0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
    16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, 63, -1,
    26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41,
    42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
};

/**
 * 标量版本
 */
int base64_decode_scalar(const char* input, size_t len, char* output) {
    const char* ptr = input;
    const char* end = ptr + len;
    char* out = output;
    const char* end4 = ptr + (len & ~3);

    for (; ptr < end4; ptr += 4, out += 3) {
        int val = base64_decode_table[(unsigned char)ptr[0]] << 18 |
                  base64_decode_table[(unsigned char)ptr[1]] << 12 |
                  base64_decode_table[(unsigned char)ptr[2]] << 6  |
                  base64_decode_table[(unsigned char)ptr[3]];

        if (val < 0) {
            if (end - ptr == 4 && ptr[3] == '=') {
                end = (ptr[2] == '=') ? ptr + 2 : ptr + 3;
            }
            break;
        }

        out[0] = (val >> 16) & 0xFF;
        out[1] = (val >> 8)  & 0xFF;
        out[2] = val & 0xFF;
    }

    if (ptr < end) {
        int val = -1;
        switch (end - ptr) {
            case 2:
                val = base64_decode_table[(unsigned char)ptr[0]] << 18 |
                      base64_decode_table[(unsigned char)ptr[1]] << 12;
                out[0] = (val >> 16) & 0xFF;
                out += 1;
                break;
            case 3:
                val = base64_decode_table[(unsigned char)ptr[0]] << 18 |
                      base64_decode_table[(unsigned char)ptr[1]] << 12 |
                      base64_decode_table[(unsigned char)ptr[2]] << 6;
                out[0] = (val >> 16) & 0xFF;
                out[1] = (val >> 8)  & 0xFF;
                out += 2;
                break;
        }
        if (val < 0) return -1;
    }

    return (int)(out - output);
}

#if BASE64_HAS_NEON

/**
 * 从 4 个 6 位值合并为 3 个 8 位值
 */
static inline void merge_group(const int8_t* in, char* out) {
    int val = (in[0] & 0x3F) << 18 |
              (in[1] & 0x3F) << 12 |
              (in[2] & 0x3F) << 6  |
              (in[3] & 0x3F);
    
    out[0] = (val >> 16) & 0xFF;
    out[1] = (val >> 8)  & 0xFF;
    out[2] = val & 0xFF;
}

/**
 * NEON 优化版本
 */
int base64_decode_neon(const char* input, size_t len, char* output) {
    const char* ptr = input;
    const char* end = ptr + len;
    char* out = output;
    const char* end16 = ptr + (len & ~15);

    /* 主循环：每次处理 16 字符 = 4 组 = 12 字节输出 */
    for (; ptr < end16; ptr += 16, out += 12) {
        /* 加载 16 字节 */
        uint8x16_t in = vld1q_u8((const uint8_t*)ptr);

        /* 查表转换 - 标量查表 */
        int8_t buf[16];
        uint8_t tmp[16];
        vst1q_u8(tmp, in);
        
        int has_error = 0;
        for (int i = 0; i < 16; i++) {
            buf[i] = base64_decode_table[tmp[i]];
            if (buf[i] < 0) has_error = 1;
        }
        
        if (has_error) {
            /* 有错误，回退到标量处理 */
            goto scalar_fallback;
        }

        /* 4 组合并 */
        for (int g = 0; g < 4; g++) {
            merge_group(buf + g * 4, out + g * 3);
        }
    }

    /* 处理剩余 < 16 字节 */
    if (ptr < end) {
        int remaining = base64_decode_scalar(ptr, end - ptr, out);
        if (remaining < 0) return -1;
        out += remaining;
    }

    return (int)(out - output);

scalar_fallback:
    return base64_decode_scalar(input, len, output);
}

#endif /* BASE64_HAS_NEON */
