// half_distance_neon.c - NEON 优化实现 (使用 FP16 硬件加速)
#include "half_distance.h"
#include <math.h>

#ifdef __ARM_NEON
#include <arm_neon.h>

// 检查是否支持 ARM FP16
#if defined(__ARM_FP16_FORMAT_IEEE) || defined(__ARM_FP16_FORMAT_ALTERNATIVE)
#define HAS_FP16 1
typedef __fp16 fp16_t;
#else
#define HAS_FP16 0
#endif

// L2 距离平方 - NEON 优化实现
float halfvec_l2_squared_distance_neon(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    int i = 0;
    int count = (dim / 4) * 4;
    float32x4_t vdist = vdupq_n_f32(0.0f);
    
#if HAS_FP16
    // 使用硬件 FP16 指令
    for (; i < count; i += 4) {
        // 加载 4 个 half (8 字节) 并转换为 float
        float16x4_t vah = vld1_f16((const float16_t*)(ax + i));
        float16x4_t vbh = vld1_f16((const float16_t*)(bx + i));
        float32x4_t vax = vcvt_f32_f16(vah);
        float32x4_t vbx = vcvt_f32_f16(vbh);
        float32x4_t vdiff = vsubq_f32(vax, vbx);
        vdist = vmlaq_f32(vdist, vdiff, vdiff);
    }
#else
    // 软件转换：批量处理
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
#endif
    
    distance = vaddvq_f32(vdist);
    
    // 处理尾部
    for (; i < dim; i++) {
        float diff = half_to_float(ax[i]) - half_to_float(bx[i]);
        distance += diff * diff;
    }
    return distance;
}

// 内积 - NEON 优化实现
float halfvec_inner_product_neon(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    int i = 0;
    int count = (dim / 4) * 4;
    float32x4_t vdist = vdupq_n_f32(0.0f);
    
#if HAS_FP16
    for (; i < count; i += 4) {
        float16x4_t vah = vld1_f16((const float16_t*)(ax + i));
        float16x4_t vbh = vld1_f16((const float16_t*)(bx + i));
        float32x4_t vax = vcvt_f32_f16(vah);
        float32x4_t vbx = vcvt_f32_f16(vbh);
        vdist = vmlaq_f32(vdist, vax, vbx);
    }
#else
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
#endif
    
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        distance += half_to_float(ax[i]) * half_to_float(bx[i]);
    }
    return distance;
}

// 余弦相似度 - NEON 优化实现
double halfvec_cosine_similarity_neon(int dim, const half* ax, const half* bx) {
    int i = 0;
    int count = (dim / 4) * 4;
    float32x4_t vsim = vdupq_n_f32(0.0f);
    float32x4_t vna = vdupq_n_f32(0.0f);
    float32x4_t vnb = vdupq_n_f32(0.0f);
    
#if HAS_FP16
    for (; i < count; i += 4) {
        float16x4_t vah = vld1_f16((const float16_t*)(ax + i));
        float16x4_t vbh = vld1_f16((const float16_t*)(bx + i));
        float32x4_t vax = vcvt_f32_f16(vah);
        float32x4_t vbx = vcvt_f32_f16(vbh);
        vsim = vmlaq_f32(vsim, vax, vbx);
        vna = vmlaq_f32(vna, vax, vax);
        vnb = vmlaq_f32(vnb, vbx, vbx);
    }
#else
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
#endif
    
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

// L1 距离 - NEON 优化实现
float halfvec_l1_distance_neon(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    int i = 0;
    int count = (dim / 4) * 4;
    float32x4_t vdist = vdupq_n_f32(0.0f);
    
#if HAS_FP16
    for (; i < count; i += 4) {
        float16x4_t vah = vld1_f16((const float16_t*)(ax + i));
        float16x4_t vbh = vld1_f16((const float16_t*)(bx + i));
        float32x4_t vax = vcvt_f32_f16(vah);
        float32x4_t vbx = vcvt_f32_f16(vbh);
        float32x4_t vdiff = vsubq_f32(vax, vbx);
        vdist = vaddq_f32(vdist, vabsq_f32(vdiff));
    }
#else
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
#endif
    
    distance = vaddvq_f32(vdist);
    
    for (; i < dim; i++) {
        distance += fabsf(half_to_float(ax[i]) - half_to_float(bx[i]));
    }
    return distance;
}

#endif
