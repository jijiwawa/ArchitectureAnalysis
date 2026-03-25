// half_distance.h - Half precision distance functions
#ifndef HALF_DISTANCE_H
#define HALF_DISTANCE_H

#include "half_types.h"

// Native C implementations
float halfvec_l2_squared_distance_native(int dim, const half* ax, const half* bx);
float halfvec_inner_product_native(int dim, const half* ax, const half* bx);
double halfvec_cosine_similarity_native(int dim, const half* ax, const half* bx);
float halfvec_l1_distance_native(int dim, const half* ax, const half* bx);

// NEON implementations
#ifdef __ARM_NEON
#include <arm_neon.h>
float halfvec_l2_squared_distance_neon(int dim, const half* ax, const half* bx);
float halfvec_inner_product_neon(int dim, const half* ax, const half* bx);
double halfvec_cosine_similarity_neon(int dim, const half* ax, const half* bx);
float halfvec_l1_distance_neon(int dim, const half* ax, const half* bx);
#endif

#endif // HALF_DISTANCE_H
