/**
 * 向量运算 NEON 优化 - 展示真正的 SIMD 加速效果
 */

#include <stdint.h>
#include <stddef.h>

#ifdef __ARM_NEON
#include <arm_neon.h>
#define HAS_NEON 1
#else
#define HAS_NEON 0
#endif

/* ========== 标量版本 ========== */

void vec_add_scalar(const float* a, const float* b, float* c, size_t n) {
    for (size_t i = 0; i < n; i++) c[i] = a[i] + b[i];
}

void vec_mul_scalar(const float* a, const float* b, float* c, size_t n) {
    for (size_t i = 0; i < n; i++) c[i] = a[i] * b[i];
}

float dot_scalar(const float* a, const float* b, size_t n) {
    float sum = 0;
    for (size_t i = 0; i < n; i++) sum += a[i] * b[i];
    return sum;
}

float l2_distance_scalar(const float* a, const float* b, size_t n) {
    float dist = 0;
    for (size_t i = 0; i < n; i++) {
        float d = a[i] - b[i];
        dist += d * d;
    }
    return dist;
}

/* ========== NEON 版本 ========== */

#if HAS_NEON

void vec_add_neon(const float* a, const float* b, float* c, size_t n) {
    size_t i = 0;
    for (; i + 4 <= n; i += 4) {
        float32x4_t va = vld1q_f32(a + i);
        float32x4_t vb = vld1q_f32(b + i);
        vst1q_f32(c + i, vaddq_f32(va, vb));
    }
    for (; i < n; i++) c[i] = a[i] + b[i];
}

void vec_mul_neon(const float* a, const float* b, float* c, size_t n) {
    size_t i = 0;
    for (; i + 4 <= n; i += 4) {
        float32x4_t va = vld1q_f32(a + i);
        float32x4_t vb = vld1q_f32(b + i);
        vst1q_f32(c + i, vmulq_f32(va, vb));
    }
    for (; i < n; i++) c[i] = a[i] * b[i];
}

float dot_neon(const float* a, const float* b, size_t n) {
    float32x4_t vsum = vdupq_n_f32(0);
    size_t i = 0;
    for (; i + 4 <= n; i += 4) {
        vsum = vmlaq_f32(vsum, vld1q_f32(a + i), vld1q_f32(b + i));
    }
    float sum = vaddvq_f32(vsum);
    for (; i < n; i++) sum += a[i] * b[i];
    return sum;
}

float l2_distance_neon(const float* a, const float* b, size_t n) {
    float32x4_t vdist = vdupq_n_f32(0);
    size_t i = 0;
    for (; i + 4 <= n; i += 4) {
        float32x4_t d = vsubq_f32(vld1q_f32(a + i), vld1q_f32(b + i));
        vdist = vmlaq_f32(vdist, d, d);
    }
    float dist = vaddvq_f32(vdist);
    for (; i < n; i++) {
        float d = a[i] - b[i];
        dist += d * d;
    }
    return dist;
}

#endif
