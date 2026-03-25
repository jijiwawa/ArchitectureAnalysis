### 2.1 half 类型定义

```c
typedef uint16_t half;  // IEEE 754 half-precision (16-bit)
```

#### 转换函数

```c
// half → float
float half_to_float(half h);

// float → half
half float_to_half(float f);
```

#### 实现细节

```c
static inline float half_to_float(half h) {
    uint32_t sign = (h >> 15) & 1;
    uint32_t exponent = (h >> 10) & 0x1F;
    uint32_t mantissa = h & 0x03FF;
    
    uint32_t result;
    if (exponent == 0) {
        // Subnormal or zero
        result = sign << 31;
    } else if (exponent == 31) {
        // Inf or NaN
        result = (sign << 31) | 0x7F800000 | (mantissa << 13);
    } else {
        // Normal
        result = (sign << 31) | ((exponent - 15 + 127) << 23) | (mantissa << 13);
    }
    
    union { uint32_t i; float f; } u;
    u.i = result;
    return u.f;
}
```

---

### 2.2 half 向量 L2 距离平方

#### 函数签名

```c
float halfvec_l2_squared_distance_native(int dim, const half* ax, const half* bx);
float halfvec_l2_squared_distance_neon(int dim, const half* ax, const half* bx);
```

#### 参数

| 参数 | 类型 | 说明 |
|------|------|------|
| dim | int | 向量维度 (1-16000) |
| ax | const half* | 第一个向量指针 (uint16_t) |
| bx | const half* | 第二个向量指针 (uint16_t) |

#### NEON 实现 (使用 FP16 硬件指令)

```c
#if defined(__ARM_FP16_FORMAT_IEEE)
// 使用 ARM FP16 硬件指令
for (; i < count; i += 4) {
    float16x4_t vah = vld1_f16((const float16_t*)(ax + i));
    float16x4_t vbh = vld1_f16((const float16_t*)(bx + i));
    float32x4_t vax = vcvt_f32_f16(vah);  // 硬件转换
    float32x4_t vbx = vcvt_f32_f16(vbh);
    float32x4_t vdiff = vsubq_f32(vax, vbx);
    vdist = vmlaq_f32(vdist, vdiff, vdiff);
}
#else
// 软件转换回退
for (; i < count; i += 4) {
    float ax_f[4], bx_f[4];
    for (int j = 0; j < 4; j++) {
        ax_f[j] = half_to_float(ax[i + j]);
        bx_f[j] = half_to_float(bx[i + j]);
    }
    // ... 同上
}
#endif
```

#### 性能

| 维度 | Native (us) | NEON-FP16 (us) | 加速比 |
|------|-------------|----------------|--------|
| 128 | 0.12 | 0.01 | **13.1x** |
| 512 | 0.46 | 0.05 | **9.2x** |
| 1024 | 0.92 | 0.12 | **7.8x** |

---

### 2.3 half 向量内积

```c
float halfvec_inner_product_native(int dim, const half* ax, const half* bx);
float halfvec_inner_product_neon(int dim, const half* ax, const half* bx);
```

---

### 2.4 half 向量余弦相似度

```c
double halfvec_cosine_similarity_native(int dim, const half* ax, const half* bx);
double halfvec_cosine_similarity_neon(int dim, const half* ax, const half* bx);
```

---

## 3. 位向量距离接口

### 3.1 汉明距离

#### 函数签名

```c
uint64_t bit_hamming_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
uint64_t bit_hamming_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
```

#### 参数

| 参数 | 类型 | 说明 |
|------|------|------|
| bytes | uint32_t | 字节数 (通常为 dim/8) |
| ax | const uint8_t* | 第一个位向量 |
| bx | const uint8_t* | 第二个位向量 |

#### 返回值

- 类型: `uint64_t`
- 含义: XOR 后 1 的个数

#### Native 实现

```c
uint64_t distance = 0;
for (; bytes >= 8; bytes -= 8) {
    uint64_t axs, bxs;
    memcpy(&axs, ax, 8);
    memcpy(&bxs, bx, 8);
    distance += __builtin_popcountll(axs ^ bxs);
    ax += 8; bx += 8;
}
// 处理剩余字节...
return distance;
```

#### NEON 实现 (查表法)

```c
// popcount 查找表
static const uint8_t popcount_lut[32] = {
    0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,
    0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4
};

uint8x16_t lut_lo = vld1q_u8(popcount_lut);
uint8x16_t lut_hi = vld1q_u8(popcount_lut + 16);

for (; i + 16 <= bytes; i += 16) {
    uint8x16_t va = vld1q_u8(ax + i);
    uint8x16_t vb = vld1q_u8(bx + i);
    uint8x16_t vxor = veorq_u8(va, vb);
    
    // 查表：低4位 + 高4位
    uint8x16_t lo = vandq_u8(vxor, vdupq_n_u8(0x0F));
    uint8x16_t hi = vshrq_n_u8(vxor, 4);
    uint8x16_t cnt = vaddq_u8(vqtbl1q_u8(lut_lo, lo), vqtbl1q_u8(lut_hi, hi));
    
    // 累加
    distance += vaddvq_u32(vpaddlq_u16(vpaddlq_u8(cnt)));
}
```

---

### 3.2 Jaccard 距离

#### 函数签名

```c
double bit_jaccard_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
double bit_jaccard_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
```

#### 返回值

- 类型: `double`
- 含义: 1 - (|A∩B| / |A∪B|)
- 范围: [0, 1]

#### 公式

```
intersection = popcount(A & B)
union = popcount(A) + popcount(B) - intersection
jaccard = 1 - (intersection / union)
```

---

## 4. 错误处理

### 4.1 参数验证

```c
// 维度检查
if (dim < 1 || dim > VECTOR_MAX_DIM) {
    return NAN;
}

// 空指针检查
if (ax == NULL || bx == NULL) {
    return NAN;
}
```

### 4.2 特殊值处理

| 情况 | 返回值 |
|------|--------|
| dim = 0 | NAN |
| 零向量 (余弦) | NAN |
| NaN 输入 | NAN |
| Inf 输入 | 继续计算 |

---

## 5. 内存对齐

### 5.1 推荐对齐

| 类型 | 推荐对齐 |
|------|----------|
| float32 向量 | 16 字节 (128-bit) |
| half 向量 | 8 字节 (64-bit) |
| 位向量 | 16 字节 (128-bit) |

### 5.2 非对齐处理

NEON 的 `vld1q_f32` 支持非对齐加载，但性能略降。

---

## 6. 线程安全

所有函数均为**无状态纯函数**，完全线程安全。

```c
// 多线程安全
#pragma omp parallel for
for (int i = 0; i < n; i++) {
    distances[i] = vector_l2_squared_distance_neon(dim, query, data[i]);
}
```

---

## 7. 版本兼容性

| 版本 | 变更 |
|------|------|
| v1.0 | 初始版本，float32 优化 |
| v1.1 | 添加 FP16 硬件加速 |
| v1.2 | 添加位向量优化 |
