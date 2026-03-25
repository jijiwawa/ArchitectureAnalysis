// bit_distance_native.c - 位向量距离原生实现
#include "bit_distance.h"
#include <string.h>

// 查找表：字节中 1 的个数
static const uint8_t popcount_table[256] = {
    0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4, 1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,
    1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5, 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5, 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6, 3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
    1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5, 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6, 3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6, 3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
    3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7, 4,5,5,6,5,6,6,7,5,6,6,7,6,7,7,8
};

uint64_t bit_hamming_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx) {
    uint64_t distance = 0;
    
    for (; bytes >= 8; bytes -= 8) {
        uint64_t axs, bxs;
        memcpy(&axs, ax, 8);
        memcpy(&bxs, bx, 8);
        distance += __builtin_popcountll(axs ^ bxs);
        ax += 8;
        bx += 8;
    }
    
    for (uint32_t i = 0; i < bytes; i++) {
        distance += popcount_table[ax[i] ^ bx[i]];
    }
    
    return distance;
}

double bit_jaccard_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx) {
    uint64_t ab = 0, aa = 0, bb = 0;
    
    for (; bytes >= 8; bytes -= 8) {
        uint64_t axs, bxs;
        memcpy(&axs, ax, 8);
        memcpy(&bxs, bx, 8);
        ab += __builtin_popcountll(axs & bxs);
        aa += __builtin_popcountll(axs);
        bb += __builtin_popcountll(bxs);
        ax += 8;
        bx += 8;
    }
    
    for (uint32_t i = 0; i < bytes; i++) {
        ab += popcount_table[ax[i] & bx[i]];
        aa += popcount_table[ax[i]];
        bb += popcount_table[bx[i]];
    }
    
    if (ab == 0) return 1.0;
    return 1.0 - ((double)ab / (double)(aa + bb - ab));
}
