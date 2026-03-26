# SIMD Optimizer Skill 使用指南

## 概述

SIMD Optimizer 是一个用于将 C/C++ 原生代码优化为 ARM NEON/SVE/SVE2 SIMD 版本的技能包。它提供了完整的优化工作流，从代码分析到性能验证。

## 快速开始

### 1. 安装

```bash
# 方法一：使用安装脚本
curl -fsSL https://your-domain/install-simd-optimizer.sh | bash

# 方法二：手动安装
mkdir -p ~/.openclaw/skills/simd-optimizer
# 将 skill 文件复制到该目录
```

### 2. 基本用法

在 OpenClaw 中直接说：

```
帮我优化这个函数的 SIMD 性能
```

或更具体：

```
用 NEON 优化这个循环：
for (int i = 0; i < n; i++) {
    c[i] = a[i] + b[i];
}
```

## 工作流程

### 阶段 1: 识别待优化代码

Agent 会自动扫描源码，识别：
- 循环内的数学运算
- 向量/矩阵操作
- 字符串处理
- 内存拷贝/比较

**示例**：
```c
// 原生实现
float dot_product(const float* a, const float* b, int n) {
    float sum = 0;
    for (int i = 0; i < n; i++) {
        sum += a[i] * b[i];
    }
    return sum;
}
```

### 阶段 2: 生成 SIMD 版本

Agent 会生成对应的 NEON 实现：

```c
#include <arm_neon.h>

float dot_product_neon(const float* a, const float* b, int n) {
    float32x4_t vsum = vdupq_n_f32(0);
    int i = 0;
    
    // 向量化循环
    for (; i + 4 <= n; i += 4) {
        float32x4_t va = vld1q_f32(a + i);
        float32x4_t vb = vld1q_f32(b + i);
        vsum = vmlaq_f32(vsum, va, vb);  // vsum += va * vb
    }
    
    // 水平求和
    float sum = vaddvq_f32(vsum);
    
    // 尾部处理
    for (; i < n; i++) {
        sum += a[i] * b[i];
    }
    
    return sum;
}
```

### 阶段 3: 生成测试用例

自动生成 GTest 测试：

```cpp
#include <gtest/gtest.h>

TEST(DotProductTest, NEON_Equivalence) {
    float a[] = {1, 2, 3, 4, 5, 6, 7, 8};
    float b[] = {8, 7, 6, 5, 4, 3, 2, 1};
    
    float native = dot_product(a, b, 8);
    float neon = dot_product_neon(a, b, 8);
    
    EXPECT_NEAR(native, neon, 1e-6);
}
```

### 阶段 4: 性能对比

生成基准测试并输出：

```
| Size  | Native    | NEON      | Speedup |
|-------|-----------|-----------|---------|
| 64    | 0.012 ms  | 0.004 ms  | 3.0x    |
| 256   | 0.048 ms  | 0.015 ms  | 3.2x    |
| 1024  | 0.195 ms  | 0.058 ms  | 3.4x    |
```

## 支持的指令集

| 指令集 | 架构 | 向量宽度 | 适用场景 |
|--------|------|----------|----------|
| NEON | ARMv7/v8 | 128-bit | 通用 SIMD |
| SVE | ARMv8-A | 可变 | 高性能计算 |
| SVE2 | ARMv9-A | 可变 | 增强 SIMD |

## 常见优化模式

### 1. 向量运算

```c
// 加法
vst1q_f32(c, vaddq_f32(vld1q_f32(a), vld1q_f32(b)));

// 乘法
vst1q_f32(c, vmulq_f32(vld1q_f32(a), vld1q_f32(b)));

// 乘加
vsum = vmlaq_f32(vsum, va, vb);
```

### 2. 查找极值

```c
float32x4_t vmax = vld1q_f32(a);
for (int i = 4; i < n; i += 4) {
    vmax = vmaxq_f32(vmax, vld1q_f32(a + i));
}
float max = vmaxvq_f32(vmax);
```

### 3. 条件处理

```c
float32x4_t vthresh = vdupq_n_f32(threshold);
for (int i = 0; i < n; i += 4) {
    float32x4_t v = vld1q_f32(a + i);
    uint32x4_t mask = vcgtq_f32(v, vthresh);
    v = vbslq_f32(mask, vthresh, v);
    vst1q_f32(a + i, v);
}
```

## 输出物

每次优化完成后，Agent 会生成：

```
project/
├── src/
│   ├── func.c           # 原生实现
│   └── func_neon.c      # SIMD 实现
├── tests/
│   └── func_test.cpp    # GTest 测试
└── docs/
    └── simd_optimization_report.md  # 优化报告
```

## 最佳实践

### ✅ 推荐场景

- 数据规模 > 64 元素
- 循环内无分支
- 连续内存访问
- 对齐的内存地址

### ❌ 避免

- 小数据量 (< 16)
- 复杂条件分支
- 非连续访问
- 频繁函数调用

## 调试技巧

### 1. 打印向量值

```c
void print_neon(float32x4_t v) {
    float buf[4];
    vst1q_f32(buf, v);
    printf("[%f, %f, %f, %f]\n", buf[0], buf[1], buf[2], buf[3]);
}
```

### 2. 检查对齐

```c
if ((uintptr_t)ptr % 16 != 0) {
    printf("Warning: unaligned pointer\n");
}
```

### 3. 回退到标量

```c
#ifdef __ARM_NEON
    // SIMD path
#else
    // Scalar fallback
#endif
```

## 依赖环境

- GCC/Clang 支持 ARM NEON
- Google Test (gtest)
- CMake (可选)

### Ubuntu/Debian

```bash
sudo apt-get install build-essential cmake libgtest-dev
```

### macOS (M1/M2)

```bash
brew install cmake googletest
```

## 常见问题

**Q: 编译报错 "cannot find -lgtest"**

A: 需要先安装并编译 gtest：
```bash
cd /usr/src/gtest && sudo cmake . && sudo make && sudo cp lib/*.a /usr/lib/
```

**Q: 加速比不如预期**

A: 检查：
1. 数据是否对齐 (16 字节)
2. 循环次数是否足够
3. 是否有内存瓶颈

**Q: NEON 和 SVE 如何选择？**

A: 
- NEON: 通用场景，兼容性好
- SVE: 数据量大且支持可变长度时

## 进阶用法

### 自定义测试数据

```cpp
std::vector<float> generate_test_data(int n, float min_val, float max_val) {
    std::mt19937 gen(42);
    std::uniform_real_distribution<float> dist(min_val, max_val);
    std::vector<float> data(n);
    for (int i = 0; i < n; i++) data[i] = dist(gen);
    return data;
}
```

### 多轮性能测试

```cpp
for (int iter = 0; iter < 10; iter++) {
    auto start = std::chrono::high_resolution_clock::now();
    func_neon(a, b, c, n);
    auto end = std::chrono::high_resolution_clock::now();
    times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
}
// 取中位数避免异常值
std::sort(times.begin(), times.end());
double median = times[times.size() / 2];
```

## 总结

SIMD Optimizer Skill 提供了从代码分析到性能验证的完整工作流：

1. **识别** - 自动发现优化机会
2. **实现** - 生成 SIMD 代码
3. **测试** - 验证正确性
4. **对比** - 量化性能提升

让 Agent 帮你完成繁重的 SIMD 优化工作！

---

*文档版本: 1.0*
*更新时间: 2026-03-26*
