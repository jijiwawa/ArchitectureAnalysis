// vector_distance_neon.c - 单精度向量距离 NEON 实现
#include "vector_distance.h"
#include <math.h>

#ifdef __ARM_NEON
#include <arm_neon.h>

float vector_l2_squared_distance_neon(int dim, const float* ax, const float* bx) {
    float distance = 0.0f;
    int i = 0;
    int count = (dim / 4) * 4;
    
    float32x4_t vdist = vdupq_n_f32(0.0f);
    for (; i < count; i += 4) {
        float32x4_t va = vld1q_f32(ax + i);
        float32x4_t vb = vld1q_f32(bx + i);
        float32x4_t vdiff = vsubq_f32(va, vb);
        vdist = vmlaq_f32(vdist, vdiff, vdiff);
    }
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        float diff = ax[i] - bx[i];
        distance += diff * diff;
    }
    return distance;
}

float vector_inner_product_neon(int dim, const float* ax, const float* bx) {
    float distance = 0.0f;
    int i = 0;
    int count = (dim / 4) * 4;
    
    float32x4_t vdist = vdupq_n_f32(0.0f);
    for (; i < count; i += 4) {
        float32x4_t va = vld1q_f32(ax + i);
        float32x4_t vb = vld1q_f32(bx + i);
        vdist = vmlaq_f32(vdist, va, vb);
    }
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        distance += ax[i] * bx[i];
    }
    return distance;
}

double vector_cosine_similarity_neon(int dim, const float* ax, const float* bx) {
    int i = 0;
    int count = (dim / 4) * 4;
    
    float32x4_t vsim = vdupq_n_f32(0.0f);
    float32x4_t vna = vdupq_n_f32(0.0f);
    float32x4_t vnb = vdupq_n_f32(0.0f);
    
    for (; i < count; i += 4) {
        float32x4_t va = vld1q_f32(ax + i);
        float32x4_t vb = vld1q_f32(bx + i);
        vsim = vmlaq_f32(vsim, va, vb);
        vna = vmlaq_f32(vna, va, va);
        vnb = vmlaq_f32(vnb, vb, vb);
    }
    
    float similarity = vaddvq_f32(vsim);
    float norma = vaddvq_f32(vna);
    float normb = vaddvq_f32(vnb);
    
    for (; i < dim; i++) {
        similarity += ax[i] * bx[i];
        norma += ax[i] * ax[i];
        normb += bx[i] * bx[i];
    }
    return (double)similarity / sqrt((double)norma * (double)normb);
}

float vector_l1_distance_neon(int dim, const float* ax, const float* bx) {
    float distance = 0.0f;
    int i = 0;
    int count = (dim / 4) * 4;
    
    float32x4_t vdist = vdupq_n_f32(0.0f);
    for (; i < count; i += 4) {
        float32x4_t va = vld1q_f32(ax + i);
        float32x4_t vb = vld1q_f32(bx + i);
        float32x4_t vdiff = vsubq_f32(va, vb);
        vdist = vaddq_f32(vdist, vabsq_f32(vdiff));
    }
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        distance += fabsf(ax[i] - bx[i]);
    }
    return distance;
}

#endif
