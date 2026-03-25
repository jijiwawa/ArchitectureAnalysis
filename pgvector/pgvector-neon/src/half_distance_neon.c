// half_distance_neon.c - NEON 优化实现
#include "half_distance.h"
#include <math.h>

#ifdef __ARM_NEON
#include <arm_neon.h>

float halfvec_l2_squared_distance_neon(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    int i = 0, count = (dim / 4) * 4;
    float32x4_t vdist = vdupq_n_f32(0.0f);
    
    for (; i < count; i += 4) {
        float ax_f[4], bx_f[4];
        for (int j = 0; j < 4; j++) {
            ax_f[j] = half_to_float(ax[i + j]);
            bx_f[j] = half_to_float(bx[i + j]);
        }
        float32x4_t vax = vld1q_f32(ax_f);
        float32x4_t vbx = vld1q_f32(bx_f);
        float32x4_t vdiff = vsubq_f32(vax, vbx);
        vdist = vmlaq_f32(vdist, vdiff, vdiff);
    }
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        float diff = half_to_float(ax[i]) - half_to_float(bx[i]);
        distance += diff * diff;
    }
    return distance;
}

float halfvec_inner_product_neon(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    int i = 0, count = (dim / 4) * 4;
    float32x4_t vdist = vdupq_n_f32(0.0f);
    
    for (; i < count; i += 4) {
        float ax_f[4], bx_f[4];
        for (int j = 0; j < 4; j++) {
            ax_f[j] = half_to_float(ax[i + j]);
            bx_f[j] = half_to_float(bx[i + j]);
        }
        float32x4_t vax = vld1q_f32(ax_f);
        float32x4_t vbx = vld1q_f32(bx_f);
        vdist = vmlaq_f32(vdist, vax, vbx);
    }
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        distance += half_to_float(ax[i]) * half_to_float(bx[i]);
    }
    return distance;
}

double halfvec_cosine_similarity_neon(int dim, const half* ax, const half* bx) {
    int i = 0, count = (dim / 4) * 4;
    float32x4_t vsim = vdupq_n_f32(0.0f);
    float32x4_t vna = vdupq_n_f32(0.0f);
    float32x4_t vnb = vdupq_n_f32(0.0f);
    
    for (; i < count; i += 4) {
        float ax_f[4], bx_f[4];
        for (int j = 0; j < 4; j++) {
            ax_f[j] = half_to_float(ax[i + j]);
            bx_f[j] = half_to_float(bx[i + j]);
        }
        float32x4_t vax = vld1q_f32(ax_f);
        float32x4_t vbx = vld1q_f32(bx_f);
        vsim = vmlaq_f32(vsim, vax, vbx);
        vna = vmlaq_f32(vna, vax, vax);
        vnb = vmlaq_f32(vnb, vbx, vbx);
    }
    
    float similarity = vaddvq_f32(vsim);
    float norma = vaddvq_f32(vna);
    float normb = vaddvq_f32(vnb);
    
    for (; i < dim; i++) {
        float axi = half_to_float(ax[i]);
        float bxi = half_to_float(bx[i]);
        similarity += axi * bxi;
        norma += axi * axi;
        normb += bxi * bxi;
    }
    return (double)similarity / sqrt((double)norma * (double)normb);
}

float halfvec_l1_distance_neon(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    int i = 0, count = (dim / 4) * 4;
    float32x4_t vdist = vdupq_n_f32(0.0f);
    
    for (; i < count; i += 4) {
        float ax_f[4], bx_f[4];
        for (int j = 0; j < 4; j++) {
            ax_f[j] = half_to_float(ax[i + j]);
            bx_f[j] = half_to_float(bx[i + j]);
        }
        float32x4_t vax = vld1q_f32(ax_f);
        float32x4_t vbx = vld1q_f32(bx_f);
        float32x4_t vdiff = vsubq_f32(vax, vbx);
        vdist = vaddq_f32(vdist, vabsq_f32(vdiff));
    }
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        distance += fabsf(half_to_float(ax[i]) - half_to_float(bx[i]));
    }
    return distance;
}

#endif
