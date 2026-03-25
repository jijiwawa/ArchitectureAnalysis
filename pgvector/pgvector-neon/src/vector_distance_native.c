// vector_distance_native.c - 单精度向量距离原生实现
#include "vector_distance.h"
#include <math.h>

float vector_l2_squared_distance_native(int dim, const float* ax, const float* bx) {
    float distance = 0.0f;
    for (int i = 0; i < dim; i++) {
        float diff = ax[i] - bx[i];
        distance += diff * diff;
    }
    return distance;
}

float vector_inner_product_native(int dim, const float* ax, const float* bx) {
    float distance = 0.0f;
    for (int i = 0; i < dim; i++) {
        distance += ax[i] * bx[i];
    }
    return distance;
}

double vector_cosine_similarity_native(int dim, const float* ax, const float* bx) {
    float similarity = 0.0f, norma = 0.0f, normb = 0.0f;
    for (int i = 0; i < dim; i++) {
        similarity += ax[i] * bx[i];
        norma += ax[i] * ax[i];
        normb += bx[i] * bx[i];
    }
    return (double)similarity / sqrt((double)norma * (double)normb);
}

float vector_l1_distance_native(int dim, const float* ax, const float* bx) {
    float distance = 0.0f;
    for (int i = 0; i < dim; i++) {
        distance += fabsf(ax[i] - bx[i]);
    }
    return distance;
}
