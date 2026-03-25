// bit_distance.h - 位向量距离函数
#ifndef BIT_DISTANCE_H
#define BIT_DISTANCE_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// 原生 C 实现
uint64_t bit_hamming_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
double bit_jaccard_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);

// NEON 实现
#ifdef __ARM_NEON
#include <arm_neon.h>
uint64_t bit_hamming_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
double bit_jaccard_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
#endif

#ifdef __cplusplus
}
#endif

#endif
