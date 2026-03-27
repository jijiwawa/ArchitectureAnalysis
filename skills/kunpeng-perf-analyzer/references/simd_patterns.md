# SIMD 优化模式

## 1. 向量化基础

### 1.1 什么是SIMD

SIMD (Single Instruction, Multiple Data) 是一种并行计算方式，单条指令同时处理多个数据元素。

### 1.2 ARM SIMD发展

| 代数 | 技术 | 位宽 | 鲲鹏支持 |
|------|------|------|---------|
| ARMv7 | NEON | 128-bit | - |
| ARMv8.0 | NEON | 128-bit | 鲲鹏920 |
| ARMv8.2 | SVE | 可变(最大2048-bit) | 鲲鹏920 |
| ARMv8.4 | SVE2 | 可变 | 鲲鹏990 |

## 2. 常见优化模式

### 2.1 循环向量化

```c
// 标量版本
for (int i = 0; i < n; i++) {
    c[i] = a[i] + b[i];
}

// NEON版本
#include <arm_neon.h>
for (int i = 0; i < n; i += 4) {
    float32x4_t va = vld1q_f32(a + i);
    float32x4_t vb = vld1q_f32(b + i);
    float32x4_t vc = vaddq_f32(va, vb);
    vst1q_f32(c + i, vc);
}
// 处理尾部元素
for (; i < n; i++) {
    c[i] = a[i] + b[i];
}
```

### 2.2 融合乘加 (FMA)

```c
// 标量版本: c = a * b + c
for (int i = 0; i < n; i++) {
    c[i] = a[i] * b[i] + c[i];
}

// NEON FMA版本
for (int i = 0; i < n; i += 4) {
    float32x4_t va = vld1q_f32(a + i);
    float32x4_t vb = vld1q_f32(b + i);
    float32x4_t vc = vld1q_f32(c + i);
    vc = vmlaq_f32(vc, va, vb);  // 一条指令完成
    vst1q_f32(c + i, vc);
}
```

### 2.3 条件处理

```c
// 标量版本
for (int i = 0; i < n; i++) {
    if (a[i] > 0) {
        c[i] = a[i] * b[i];
    } else {
        c[i] = 0;
    }
}

// NEON版本（无分支）
for (int i = 0; i < n; i += 4) {
    float32x4_t va = vld1q_f32(a + i);
    float32x4_t vb = vld1q_f32(b + i);

    // 比较结果作为mask
    uint32x4_t mask = vcgtq_f32(va, vdupq_n_f32(0.0f));

    // 条件计算
    float32x4_t product = vmulq_f32(va, vb);
    float32x4_t result = vbslq_f32(mask, product, vdupq_n_f32(0.0f));

    vst1q_f32(c + i, result);
}
```

### 2.4 数据预取

```c
for (int i = 0; i < n; i += 4) {
    // 预取未来数据
    __builtin_prefetch(&a[i + 16], 0, 3);
    __builtin_prefetch(&b[i + 16], 0, 3);

    float32x4_t va = vld1q_f32(a + i);
    float32x4_t vb = vld1q_f32(b + i);
    float32x4_t vc = vaddq_f32(va, vb);
    vst1q_f32(c + i, vc);
}
```

## 3. 矩阵运算优化

### 3.1 矩阵向量乘

```c
void matvec_neon(float* A, float* x, float* y, int M, int N) {
    for (int i = 0; i < M; i++) {
        float32x4_t sum = vdupq_n_f32(0.0f);

        for (int j = 0; j < N; j += 4) {
            float32x4_t va = vld1q_f32(&A[i * N + j]);
            float32x4_t vx = vld1q_f32(&x[j]);
            sum = vmlaq_f32(sum, va, vx);
        }

        // 水平求和
        float32x2_t s = vadd_f32(vget_low_f32(sum), vget_high_f32(sum));
        s = vpadd_f32(s, s);
        y[i] = vget_lane_f32(s, 0);
    }
}
```

### 3.2 矩阵乘法分块

```c
#define BLOCK_SIZE 64

void matmul_neon_blocked(float* A, float* B, float* C, int N) {
    for (int ii = 0; ii < N; ii += BLOCK_SIZE) {
        for (int jj = 0; jj < N; jj += BLOCK_SIZE) {
            for (int kk = 0; kk < N; kk += BLOCK_SIZE) {
                // 处理BLOCK_SIZE x BLOCK_SIZE的小块
                for (int i = ii; i < ii + BLOCK_SIZE; i++) {
                    for (int k = kk; k < kk + BLOCK_SIZE; k += 4) {
                        float32x4_t va = vld1q_f32(&A[i * N + k]);

                        for (int j = jj; j < jj + BLOCK_SIZE; j += 4) {
                            float32x4_t vb = vld1q_f32(&B[k * N + j]);
                            float32x4_t vc = vld1q_f32(&C[i * N + j]);
                            vc = vmlaq_f32(vc, va, vb);
                            vst1q_f32(&C[i * N + j], vc);
                        }
                    }
                }
            }
        }
    }
}
```

## 4. 常用NEON内置函数

### 4.1 数据类型

| 类型 | 说明 | 元素类型 |
|------|------|---------|
| float32x4_t | 4个float | float |
| float64x2_t | 2个double | double |
| int32x4_t | 4个int32 | int32_t |
| int16x8_t | 8个int16 | int16_t |
| uint8x16_t | 16个uint8 | uint8_t |

### 4.2 加载/存储

```c
// 加载
float32x4_t vld1q_f32(float const * ptr);
float32x2_t vld1_f32(float const * ptr);

// 存储
void vst1q_f32(float * ptr, float32x4_t val);
void vst1_f32(float * ptr, float32x2_t val);

// 交错加载
float32x4x2_t vld2q_f32(float const * ptr);  // 加载8个float到2个向量
```

### 4.3 算术运算

```c
// 加法
float32x4_t vaddq_f32(float32x4_t a, float32x4_t b);

// 减法
float32x4_t vsubq_f32(float32x4_t a, float32x4_t b);

// 乘法
float32x4_t vmulq_f32(float32x4_t a, float32x4_t b);

// 融合乘加: a = b * c + a
float32x4_t vmlaq_f32(float32x4_t a, float32x4_t b, float32x4_t c);

// 除法
float32x4_t vdivq_f32(float32x4_t a, float32x4_t b);

// 平方根
float32x4_t vsqrtq_f32(float32x4_t a);
```

### 4.4 比较运算

```c
// 大于比较，返回mask
uint32x4_t vcgtq_f32(float32x4_t a, float32x4_t b);

// 小于比较
uint32x4_t vcltq_f32(float32x4_t a, float32x4_t b);

// 相等比较
uint32x4_t vceqq_f32(float32x4_t a, float32x4_t b);
```

### 4.5 重排操作

```c
// 复制所有元素为同一值
float32x4_t vdupq_n_f32(float value);

// 反转元素顺序
float32x4_t vrev64q_f32(float32x4_t a);

// 提取低/高64位
float32x2_t vget_low_f32(float32x4_t a);
float32x2_t vget_high_f32(float32x4_t a);

// 合并两个向量的低/高部分
float32x4_t vcombine_f32(float32x2_t low, float32x2_t high);

// 按条件选择
float32x4_t vbslq_f32(uint32x4_t mask, float32x4_t a, float32x4_t b);
```

## 5. SVE 进阶

### 5.1 可变向量长度

```c
#include <arm_sve.h>

void add_sve(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; ) {
        // 自动处理边界
        svbool_t pg = svwhilelt_b32(i, n);

        // 加载、计算、存储
        svfloat32_t va = svld1_f32(pg, a + i);
        svfloat32_t vb = svld1_f32(pg, b + i);
        svfloat32_t vc = svadd_f32_z(pg, va, vb);
        svst1_f32(pg, c + i, vc);

        // 获取当前向量宽度
        i += svcntw();
    }
}
```

### 5.2 SVE优势

1. **可变向量长度**: 代码自动适应硬件
2. **谓词寄存器**: 高效处理条件
3. **gather/scatter**: 非连续内存访问
4. **水平操作**: 高效归约

## 6. 优化检查清单

- [ ] 数据对齐 (16字节或64字节)
- [ ] 循环展开
- [ ] 数据预取
- [ ] 减少依赖链
- [ ] 避免混合类型
- [ ] 处理边界情况
- [ ] 验证数值精度
