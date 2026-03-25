// bit_distance_neon.c - 位向量距离 NEON 实现
#include "bit_distance.h"
#include <string.h>

#ifdef __ARM_NEON
#include <arm_neon.h>

// 汉明距离 - NEON 实现
uint64_t bit_hamming_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx) {
    uint64_t distance = 0;
    uint32_t i = 0;
    
    // NEON 每次处理 16 字节
    for (; i + 16 <= bytes; i += 16) {
        uint8x16_t va = vld1q_u8(ax + i);
        uint8x16_t vb = vld1q_u8(bx + i);
        uint8x16_t vxor = veorq_u8(va, vb);
        
        uint8_t xor_bytes[16];
        vst1q_u8(xor_bytes, vxor);
        
        for (int j = 0; j < 16; j++) {
            distance += __builtin_popcount(xor_bytes[j]);
        }
    }
    
    // 64位处理剩余
    for (; i + 8 <= bytes; i += 8) {
        uint64_t axs, bxs;
        memcpy(&axs, ax + i, 8);
        memcpy(&bxs, bx + i, 8);
        distance += __builtin_popcountll(axs ^ bxs);
    }
    
    // 最后剩余字节
    for (; i < bytes; i++) {
        distance += __builtin_popcount(ax[i] ^ bx[i]);
    }
    
    return distance;
}

// Jaccard 距离 - NEON 实现
double bit_jaccard_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx) {
    uint64_t ab = 0, aa = 0, bb = 0;
    uint32_t i = 0;
    
    // NEON 每次处理 16 字节
    for (; i + 16 <= bytes; i += 16) {
        uint8x16_t va = vld1q_u8(ax + i);
        uint8x16_t vb = vld1q_u8(bx + i);
        uint8x16_t vand = vandq_u8(va, vb);
        
        uint8_t and_bytes[16], a_bytes[16], b_bytes[16];
        vst1q_u8(and_bytes, vand);
        vst1q_u8(a_bytes, va);
        vst1q_u8(b_bytes, vb);
        
        for (int j = 0; j < 16; j++) {
            ab += __builtin_popcount(and_bytes[j]);
            aa += __builtin_popcount(a_bytes[j]);
            bb += __builtin_popcount(b_bytes[j]);
        }
    }
    
    // 64位处理剩余
    for (; i + 8 <= bytes; i += 8) {
        uint64_t axs, bxs;
        memcpy(&axs, ax + i, 8);
        memcpy(&bxs, bx + i, 8);
        ab += __builtin_popcountll(axs & bxs);
        aa += __builtin_popcountll(axs);
        bb += __builtin_popcountll(bxs);
    }
    
    // 最后剩余字节
    for (; i < bytes; i++) {
        ab += __builtin_popcount(ax[i] & bx[i]);
        aa += __builtin_popcount(ax[i]);
        bb += __builtin_popcount(bx[i]);
    }
    
    if (ab == 0) return 1.0;
    return 1.0 - ((double)ab / (double)(aa + bb - ab));
}

#endif
