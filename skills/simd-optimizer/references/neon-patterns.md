# NEON/SVE 优化模式

## 常用数据类型

### NEON (128-bit)
```c
float32x4_t   // 4 个 float
float64x2_t   // 2 个 double
int32x4_t     // 4 个 int32
int16x8_t     // 8 个 int16
int8x16_t     // 16 个 int8
uint8x16_t    // 16 个 uint8
```

### SVE (可伸缩)
```c
svfloat32_t   // float 向量 (VL 长度)
svfloat64_t   // double 向量
svint32_t     // int32 向量
svbool_t      // 谓词寄存器
```

## 常用优化模式

### 1. 向量加法
```c
// 原生
for (int i = 0; i < n; i++) {
    c[i] = a[i] + b[i];
}

// NEON
for (int i = 0; i + 4 <= n; i += 4) {
    float32x4_t va = vld1q_f32(a + i);
    float32x4_t vb = vld1q_f32(b + i);
    vst1q_f32(c + i, vaddq_f32(va, vb));
}
```

### 2. 点积 (内积)
```c
// 原生
float sum = 0;
for (int i = 0; i < n; i++) {
    sum += a[i] * b[i];
}

// NEON
float32x4_t vsum = vdupq_n_f32(0);
for (int i = 0; i + 4 <= n; i += 4) {
    float32x4_t va = vld1q_f32(a + i);
    float32x4_t vb = vld1q_f32(b + i);
    vsum = vmlaq_f32(vsum, va, vb);  // vsum += va * vb
}
// 水平求和
float sum = vaddvq_f32(vsum);
```

### 3. L2 距离
```c
// 原生
float dist = 0;
for (int i = 0; i < n; i++) {
    float diff = a[i] - b[i];
    dist += diff * diff;
}

// NEON
float32x4_t vdist = vdupq_n_f32(0);
for (int i = 0; i + 4 <= n; i += 4) {
    float32x4_t va = vld1q_f32(a + i);
    float32x4_t vb = vld1q_f32(b + i);
    float32x4_t vdiff = vsubq_f32(va, vb);
    vdist = vmlaq_f32(vdist, vdiff, vdiff);
}
float dist = vaddvq_f32(vdist);
```

### 4. 最大值/最小值
```c
// NEON
float32x4_t vmax = vld1q_f32(a);
for (int i = 4; i + 4 <= n; i += 4) {
    float32x4_t v = vld1q_f32(a + i);
    vmax = vmaxq_f32(vmax, v);
}
float max = vmaxvq_f32(vmax);
```

### 5. 条件赋值
```c
// 原生
for (int i = 0; i < n; i++) {
    if (a[i] > threshold) {
        a[i] = threshold;
    }
}

// NEON
float32x4_t vthresh = vdupq_n_f32(threshold);
for (int i = 0; i + 4 <= n; i += 4) {
    float32x4_t va = vld1q_f32(a + i);
    va = vminq_f32(va, vthresh);
    vst1q_f32(a + i, va);
}
```

## SVE 模式

### 1. 自适应长度循环
```c
// SVE 自动适应向量长度
svbool_t pg = svptrue_b32();
svfloat32_t vsum = svdup_f32(0);

for (int i = 0; i < n; i += svcntw()) {
    svbool_t pg = svwhilelt_b32(i, n);
    svfloat32_t va = svld1_f32(pg, a + i);
    svfloat32_t vb = svld1_f32(pg, b + i);
    vsum = svmla_f32_m(pg, vsum, va, vb);
}
float sum = svaddv_f32(svptrue_b32(), vsum);
```

## 常见陷阱

1. **对齐问题**：使用 `vld1q_f32` 不要求对齐，但 `vld1q_f32` 更快
2. **尾部处理**：必须处理 n % 4 的剩余元素
3. **精度问题**：浮点累加顺序不同可能导致微小差异
