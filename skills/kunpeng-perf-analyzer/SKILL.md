---
name: kunpeng-perf-analyzer
description: 鲲鹏CPU性能分析skill，用于分析perf热点数据、识别瓶颈函数、生成火焰图、推荐优化策略（SIMD/算子融合/PGO）。当用户提到性能分析、热点函数、perf、火焰图、CPU瓶颈、性能调优、profile、hotspot时使用。
---

# 鲲鹏 CPU 性能分析器

针对鲲鹏(ARM)处理器的性能分析与优化建议工具。

## 核心功能

1. **热点分析**: 分析 perf 数据，识别 CPU 密集函数
2. **火焰图生成**: 生成可视化火焰图
3. **瓶颈识别**: 识别内存/CPU/IO 瓶颈
4. **优化建议**: 根据函数特征推荐优化策略
5. **4+1视图生成**: 为热点函数生成架构视图

## 使用流程

### Step 1: 采集性能数据

使用以下命令采集热点数据：

```bash
# 基础采集（30秒）
perf record -g -p <pid> -- sleep 30

# 系统级采集
perf record -g -a -- sleep 30

# 采集硬件计数器（鲲鹏支持）
perf record -e cycles,instructions,cache-misses,cache-references -g -p <pid> -- sleep 30

# 生成报告
perf report --stdio > perf_report.txt
```

### Step 2: 分析热点函数

读取 perf 报告后，分析以下维度：

| 维度 | 关注点 | 优化方向 |
|------|--------|---------|
| CPU 占用 | 高占比函数(>5%) | 算法优化、向量化 |
| 调用栈深度 | 深调用链 | 内联、算子融合 |
| 缓存未命中 | 高 cache-misses | 数据布局优化 |
| 分支预测 | 高 branch-misses | 分支优化 |

### Step 3: 识别瓶颈类型

根据性能指标判断瓶颈类型：

```python
# 瓶颈判断逻辑
if CPI > 2.0:
    bottleneck = "内存瓶颈"
    suggestions = ["数据预取", "缓存优化", "数据布局调整"]
elif vectorization_ratio < 0.3:
    bottleneck = "向量化不足"
    suggestions = ["SIMD优化", "循环展开", "数据对齐"]
elif cache_miss_rate > 0.1:
    bottleneck = "缓存瓶颈"
    suggestions = ["缓存分块", "数据局部性优化"]
```

### Step 4: 生成优化建议

根据函数特征推荐优化策略：

#### 计算密集型函数
- **SIMD 向量化**: 使用 NEON/SVE 指令
- **循环展开**: 减少循环开销
- **算子融合**: 合并多个计算操作

#### 内存密集型函数
- **数据预取**: `__builtin_prefetch`
- **缓存分块**: 矩阵分块处理
- **数据布局**: AoS → SoA 转换

#### 调用频繁函数
- **函数内联**: `__attribute__((always_inline))`
- **热路径优化**: 减少分支
- **编译器 PGO**: Profile-Guided Optimization

### Step 5: 生成 4+1 视图

为热点函数生成架构视图：

| 视图 | 内容 | 用途 |
|------|------|------|
| 逻辑视图 | 函数调用关系 | 理解代码结构 |
| 进程视图 | 并行/并发关系 | 理解执行流 |
| 开发视图 | 模块组织 | 理解代码组织 |
| 物理视图 | 部署/资源映射 | 理解运行环境 |
| 场景视图 | 关键用例流程 | 理解核心路径 |

## 鲲鹏特有优化

### NEON/SVE 向量化

```c
// NEON 基础向量化示例
#include <arm_neon.h>

void vector_add(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; i += 4) {
        float32x4_t va = vld1q_f32(a + i);
        float32x4_t vb = vld1q_f32(b + i);
        float32x4_t vc = vaddq_f32(va, vb);
        vst1q_f32(c + i, vc);
    }
}

// SVE 向量化示例（鲲鹏920支持）
#include <arm_sve.h>

void sve_add(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; ) {
        svbool_t pg = svwhilelt_b32(i, n);
        svfloat32_t va = svld1_f32(pg, a + i);
        svfloat32_t vb = svld1_f32(pg, b + i);
        svfloat32_t vc = svadd_f32_z(pg, va, vb);
        svst1_f32(pg, c + i, vc);
        i += svcntw();
    }
}
```

### 数据预取

```c
// 鲲鹏数据预取优化
#define PREFETCH(addr) __builtin_prefetch(addr, 0, 3)

for (int i = 0; i < n; i++) {
    PREFETCH(&data[i + 8]);  // 预取8个元素之后的数据
    process(data[i]);
}
```

### 编译器优化选项

```bash
# GCC 鲲鹏优化选项
gcc -O3 -march=armv8.2-a+sve -mtune=tsv110 \
    -ffast-math -funroll-loops \
    -fprofile-generate  # PGO 第一阶段

# 运行程序收集 profile
./program

# PGO 第二阶段
gcc -O3 -march=armv8.2-a+sve -mtune=tsv110 \
    -ffast-math -funroll-loops \
    -fprofile-use -fprofile-correction

# LTO 优化
gcc -O3 -flto -ffat-lto-objects ...
```

## 高性能库替换

| 场景 | 原库 | 替换库 | 预期收益 |
|------|------|--------|---------|
| BLAS | OpenBLAS | KML (鲲鹏数学库) | 2-5x |
| FFT | FFTW | KML-FFT | 1.5-3x |
| 深度学习 | PyTorch CPU | Torch+KML | 1.5-2x |
| 图像处理 | OpenCV | OpenCV+NEON | 1.2-2x |

## 输出模板

性能分析报告应包含：

```markdown
# 性能分析报告

## 1. 执行摘要
- 分析目标: [程序/进程名]
- 分析时长: [秒]
- 总体瓶颈: [CPU/内存/IO]

## 2. 热点函数 Top 10
| 排名 | 函数名 | CPU% | 样本数 | 优化建议 |
|------|--------|------|--------|---------|

## 3. 瓶颈分析
- CPU 瓶颈: [描述]
- 内存瓶颈: [描述]
- 缓存瓶颈: [描述]

## 4. 优化建议
### 4.1 高优先级（预期收益 >20%）
### 4.2 中优先级（预期收益 10-20%）
### 4.3 低优先级（预期收益 <10%）

## 5. 4+1 架构视图
[热点函数的架构视图]

## 6. 优化代码示例
[针对热点函数的优化代码]
```

## 参考文件

详细参考信息请查阅：
- `references/perf_events.md`: perf 使用详细指南
- `references/kunpeng_tuning.md`: 鲲鹏调优手册
- `references/bpftrace_probes.md`: bpftrace 动态追踪
- `references/simd_patterns.md`: SIMD 优化模式

## 脚本工具

- `scripts/hotspot_collector.sh`: 一键采集热点数据
- `scripts/flamegraph_gen.py`: 生成火焰图
- `scripts/bottleneck_analyzer.py`: 瓶颈类型分析

## 使用示例

```
用户: 帮我分析这个程序的perf数据
助手: [读取 perf 报告]
      [识别 Top 10 热点函数]
      [分析瓶颈类型]
      [生成优化建议]
      [输出 4+1 视图]
```

---

**Skill 版本**: 1.0
**适用平台**: 鲲鹏 920/990, ARMv8.2+
**最后更新**: 2026-03-27
