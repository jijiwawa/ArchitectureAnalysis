// half_distance_native.c - 从 pgvector halfutils.c 提取的原生实现
#include "half_distance.h"
#include <math.h>

// L2 距离平方 - 原生实现
float halfvec_l2_squared_distance_native(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    for (int i = 0; i < dim; i++) {
        float diff = half_to_float(ax[i]) - half_to_float(bx[i]);
        distance += diff * diff;
    }
    return distance;
}

// 内积 - 原生实现
float halfvec_inner_product_native(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    for (int i = 0; i < dim; i++) {
        distance += half_to_float(ax[i]) * half_to_float(bx[i]);
    }
    return distance;
}

// 余弦相似度 - 原生实现
double halfvec_cosine_similarity_native(int dim, const half* ax, const half* bx) {
    float similarity = 0.0f, norma = 0.0f, normb = 0.0f;
    for (int i = 0; i < dim; i++) {
        float axi = half_to_float(ax[i]);
        float bxi = half_to_float(bx[i]);
        similarity += axi * bxi;
        norma += axi * axi;
        normb += bxi * bxi;
    }
    return (double)similarity / sqrt((double)norma * (double)normb);
}

// L1 距离 - 原生实现
float halfvec_l1_distance_native(int dim, const half* ax, const half* bx) {
    float distance = 0.0f;
    for (int i = 0; i < dim; i++) {
        distance += fabsf(half_to_float(ax[i]) - half_to_float(bx[i]));
    }
    return distance;
}
