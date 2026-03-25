// half_distance.h - 半精度向量距离函数
#ifndef HALF_DISTANCE_H
#define HALF_DISTANCE_H

#include "half_types.h"

#ifdef __cplusplus
extern "C" {
#endif

// 原生 C 实现
float halfvec_l2_squared_distance_native(int dim, const half* ax, const half* bx);
float halfvec_inner_product_native(int dim, const half* ax, const half* bx);
double halfvec_cosine_similarity_native(int dim, const half* ax, const half* bx);
float halfvec_l1_distance_native(int dim, const half* ax, const half* bx);

// NEON 实现
#ifdef __ARM_NEON
#include <arm_neon.h>
float halfvec_l2_squared_distance_neon(int dim, const half* ax, const half* bx);
float halfvec_inner_product_neon(int dim, const half* ax, const half* bx);
double halfvec_cosine_similarity_neon(int dim, const half* ax, const half* bx);
float halfvec_l1_distance_neon(int dim, const half* ax, const half* bx);
#endif

#ifdef __cplusplus
}
#endif

#endif
