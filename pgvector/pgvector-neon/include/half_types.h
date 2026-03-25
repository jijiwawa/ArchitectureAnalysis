// half_types.h - Half precision float types and conversions
#ifndef HALF_TYPES_H
#define HALF_TYPES_H

#include <stdint.h>
#include <math.h>
#include <stdbool.h>

// Use uint16_t for half precision
typedef uint16_t half;

// Half to float conversion
static inline float half_to_float(half h) {
    uint32_t sign = (h >> 15) & 1;
    uint32_t exponent = (h >> 10) & 0x1F;
    uint32_t mantissa = h & 0x03FF;
    
    uint32_t result;
    
    if (exponent == 0) {
        if (mantissa == 0) {
            // Zero
            result = sign << 31;
        } else {
            // Subnormal - normalize
            exponent = -14;
            while (!(mantissa & 0x0400)) {
                mantissa <<= 1;
                exponent--;
            }
            mantissa &= 0x03FF;
            result = (sign << 31) | ((exponent + 127) << 23) | (mantissa << 13);
        }
    } else if (exponent == 31) {
        // Inf or NaN
        if (mantissa == 0) {
            result = (sign << 31) | 0x7F800000;
        } else {
            result = (sign << 31) | 0x7FC00000;
        }
    } else {
        // Normal
        result = (sign << 31) | ((exponent - 15 + 127) << 23) | (mantissa << 13);
    }
    
    union { uint32_t i; float f; } u;
    u.i = result;
    return u.f;
}

// Float to half conversion
static inline half float_to_half(float f) {
    union { float f; uint32_t i; } u;
    u.f = f;
    uint32_t bits = u.i;
    
    uint32_t sign = (bits >> 31) & 1;
    int32_t exponent = ((bits >> 23) & 0xFF) - 127;
    uint32_t mantissa = bits & 0x007FFFFF;
    
    uint16_t result;
    
    if (exponent < -24) {
        // Underflow to zero
        result = sign << 15;
    } else if (exponent > 15) {
        // Overflow to infinity
        result = (sign << 15) | 0x7C00;
    } else {
        int32_t new_exp = exponent + 15;
        
        if (exponent <= -15) {
            // Subnormal
            new_exp = 0;
            mantissa |= 0x00800000;  // Add implicit 1
            int shift = 14 - exponent;
            mantissa >>= shift;
        }
        
        // Round to nearest even
        uint32_t round_bit = (mantissa >> 12) & 1;
        uint32_t sticky = (mantissa & 0xFFF) ? 1 : 0;
        mantissa >>= 13;
        
        if (round_bit && (sticky || (mantissa & 1))) {
            mantissa++;
            if (mantissa == 0x400) {
                mantissa = 0;
                new_exp++;
            }
        }
        
        if (new_exp >= 31) {
            result = (sign << 15) | 0x7C00;
        } else {
            result = (sign << 15) | (new_exp << 10) | (mantissa & 0x3FF);
        }
    }
    
    return result;
}

#endif // HALF_TYPES_H
