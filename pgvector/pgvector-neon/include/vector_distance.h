// vector_distance.h - 单精度向量距离函数
#ifndef VECTOR_DISTANCE_H
#define VECTOR_DISTANCE_H

#include <stdint.h>

// 原生 C 实现
float vector_l2_squared_distance_native(int dim, const float* ax, const float* bx);
float vector_inner_product_native(int dim, const float* ax, const float* bx);
double vector_cosine_similarity_native(int dim, const float* ax, const float* bx);
float vector_l1_distance_native(int dim, const float* ax, const float* bx);

// NEON 实现
#ifdef __ARM_NEON
#include <arm_neon.h>
float vector_l2_squared_distance_neon(int dim, const float* ax, const float* bx);
float vector_inner_product_neon(int dim, const float* ax, const float* bx);
double vector_cosine_similarity_neon(int dim, const float* ax, const float* bx);
float vector_l1_distance_neon(int dim, const float* ax, const float* bx);
#endif

#endif
