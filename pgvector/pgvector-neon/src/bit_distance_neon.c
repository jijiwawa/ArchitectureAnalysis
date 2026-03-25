// bit_distance_neon.c - 位向量距离 NEON 优化实现
#include "bit_distance.h"
#include <string.h>

#ifdef __ARM_NEON
#include <arm_neon.h>

// popcount 查找表：16 个 8 位值
// 使用 NEON TBL 指令一次查 16 个值
static const uint8_t popcount_lut[32] = {
    0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,  // 低 4 位
    0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4   // 高 4 位
};

// 汉明距离 - NEON 优化实现
uint64_t bit_hamming_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx) {
    uint64_t distance = 0;
    uint32_t i = 0;
    
    // NEON 每次处理 16 字节，使用查表法
    uint8x16_t lut_lo = vld1q_u8(popcount_lut);
    uint8x16_t lut_hi = vld1q_u8(popcount_lut + 16);
    
    for (; i + 16 <= bytes; i += 16) {
        uint8x16_t va = vld1q_u8(ax + i);
        uint8x16_t vb = vld1q_u8(bx + i);
        uint8x16_t vxor = veorq_u8(va, vb);
        
        // 查表：低 4 位
        uint8x16_t lo = vandq_u8(vxor, vdupq_n_u8(0x0F));
        uint8x16_t cnt_lo = vqtbl1q_u8(lut_lo, lo);
        
        // 查表：高 4 位
        uint8x16_t hi = vshrq_n_u8(vxor, 4);
        uint8x16_t cnt_hi = vqtbl1q_u8(lut_hi, hi);
        
        // 累加
        uint8x16_t cnt = vaddq_u8(cnt_lo, cnt_hi);
        
        // 水平求和（4 个 uint32 累加）
        uint16x8_t sum = vpaddlq_u8(cnt);
        uint32x4_t sum2 = vpaddlq_u16(sum);
        distance += vaddvq_u32(sum2);
    }
    
    // 64 位处理剩余
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

// Jaccard 距离 - NEON 优化实现
double bit_jaccard_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx) {
    uint64_t ab = 0, aa = 0, bb = 0;
    uint32_t i = 0;
    
    uint8x16_t lut_lo = vld1q_u8(popcount_lut);
    uint8x16_t lut_hi = vld1q_u8(popcount_lut + 16);
    
    for (; i + 16 <= bytes; i += 16) {
        uint8x16_t va = vld1q_u8(ax + i);
        uint8x16_t vb = vld1q_u8(bx + i);
        
        // AND
        uint8x16_t vand = vandq_u8(va, vb);
        uint8x16_t lo_and = vandq_u8(vand, vdupq_n_u8(0x0F));
        uint8x16_t hi_and = vshrq_n_u8(vand, 4);
        uint8x16_t cnt_and = vaddq_u8(vqtbl1q_u8(lut_lo, lo_and), vqtbl1q_u8(lut_hi, hi_and));
        
        // A
        uint8x16_t lo_a = vandq_u8(va, vdupq_n_u8(0x0F));
        uint8x16_t hi_a = vshrq_n_u8(va, 4);
        uint8x16_t cnt_a = vaddq_u8(vqtbl1q_u8(lut_lo, lo_a), vqtbl1q_u8(lut_hi, hi_a));
        
        // B
        uint8x16_t lo_b = vandq_u8(vb, vdupq_n_u8(0x0F));
        uint8x16_t hi_b = vshrq_n_u8(vb, 4);
        uint8x16_t cnt_b = vaddq_u8(vqtbl1q_u8(lut_lo, lo_b), vqtbl1q_u8(lut_hi, hi_b));
        
        // 累加
        uint16x8_t sum_and = vpaddlq_u8(cnt_and);
        uint32x4_t sum2_and = vpaddlq_u16(sum_and);
        ab += vaddvq_u32(sum2_and);
        
        uint16x8_t sum_a = vpaddlq_u8(cnt_a);
        uint32x4_t sum2_a = vpaddlq_u16(sum_a);
        aa += vaddvq_u32(sum2_a);
        
        uint16x8_t sum_b = vpaddlq_u8(cnt_b);
        uint32x4_t sum2_b = vpaddlq_u16(sum_b);
        bb += vaddvq_u32(sum2_b);
    }
    
    // 64 位处理剩余
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
