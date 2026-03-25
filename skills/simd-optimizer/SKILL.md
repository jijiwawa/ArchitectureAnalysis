---
name: simd-optimizer
description: SIMD 优化开发工作流。用于将 C/C++ 原生代码优化为 NEON/SVE/SVE2 SIMD 版本。触发场景：(1) 用户要求进行 SIMD 优化 (2) 将代码从 x86 移植到 ARM (3) 需要对比原生和 SIMD 版本的性能 (4) 使用 gtest 测试 SIMD 实现。支持：提取待优化接口、实现 SIMD 版本、gtest 测试框架、性能基准对比。
---

# SIMD Optimizer Skill

将 C/C++ 原生代码优化为 ARM NEON/SVE/SVE2 SIMD 版本的完整工作流。

## 工作流程

### 阶段 1: 识别待优化接口

1. **扫描源码** - 找到计算密集型函数：
   - 循环内数学运算
   - 向量/矩阵操作
   - 字符串处理
   - 内存拷贝/比较

2. **提取原生实现** - 记录：
   - 函数签名
   - 输入/输出类型
   - 算法逻辑

3. **确认优化价值** - 评估：
   - 调用频率
   - 数据规模
   - 预期加速比

### 阶段 2: 实现 SIMD 版本

1. **选择指令集**：
   - NEON: ARMv7-A/ARMv8-A 基础 SIMD
   - SVE: ARMv8-A 可伸缩向量扩展
   - SVE2: ARMv9-A 增强版

2. **实现模式** - 参考 [references/neon-patterns.md](references/neon-patterns.md)

3. **代码结构**：
```c
#ifdef __ARM_NEON
#include <arm_neon.h>

// SIMD 版本
void func_neon(const float* a, const float* b, float* c, int n) {
    int i = 0;
    for (; i + 4 <= n; i += 4) {
        float32x4_t va = vld1q_f32(a + i);
        float32x4_t vb = vld1q_f32(b + i);
        float32x4_t vc = vaddq_f32(va, vb);
        vst1q_f32(c + i, vc);
    }
    // 尾部处理
    for (; i < n; i++) {
        c[i] = a[i] + b[i];
    }
}
#endif
```

### 阶段 3: GTest 测试框架

1. **目录结构**：
```
project/
├── src/
│   ├── func.c           # 原生实现
│   └── func_neon.c      # SIMD 实现
└── tests/
    ├── func_test.cpp    # GTest 测试
    └── test_data/       # 测试数据
```

2. **测试模板** - 参考 [assets/gtest_template.cpp](assets/gtest_template.cpp)

3. **测试数据构造**：
   - 边界值：0, 最小值, 最大值
   - 随机值：均匀分布
   - 特殊值：NaN, Inf (浮点)
   - 多种长度：1, 4, 8, 16, 64, 128, 256

### 阶段 4: 功能正确性验证

1. **运行测试**：
```bash
# 编译
g++ -std=c++11 tests/func_test.cpp -lgtest -lgtest_main -o test_func
# 运行
./test_func
```

2. **结果比较**：
   - 浮点：允许微小误差 (1e-6)
   - 整数：必须完全一致

3. **失败处理**：
   - 打印输入/期望/实际值
   - 检查边界条件
   - 验证尾部处理

### 阶段 5: 性能基准测试

1. **基准测试模板** - 参考 [assets/benchmark_template.cpp](assets/benchmark_template.cpp)

2. **测试方法**：
```cpp
auto start = std::chrono::high_resolution_clock::now();
for (int i = 0; i < iterations; i++) {
    func_native(input, output, size);
}
auto end = std::chrono::high_resolution_clock::now();
```

3. **性能指标**：
   - 执行时间 (ms)
   - 吞吐量 (MB/s 或 ops/s)
   - 加速比 = 原生时间 / SIMD 时间

## 输出物

每次优化完成后生成：

1. **优化报告** (`simd_optimization_report.md`)：
   - 原生实现代码
   - SIMD 实现代码
   - 测试用例
   - 性能对比数据

2. **代码文件**：
   - `func_neon.c/h` - SIMD 实现
   - `func_test.cpp` - GTest 测试

## 进度汇报

长任务需每 15 分钟汇报：
- 当前阶段
- 已完成接口数
- 遇到的问题
- 下一步计划

## 注意事项

- 问题需用户确认后再实施
- 保持代码可读性，添加注释
- 处理好非 SIMD 路径的回退
