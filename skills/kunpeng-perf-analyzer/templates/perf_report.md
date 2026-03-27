# 性能分析报告模板

> 分析时间: {{timestamp}}
> 分析目标: {{target}}
> 分析时长: {{duration}}秒

---

## 1. 执行摘要

| 指标 | 值 |
|------|-----|
| 分析目标 | {{program_name}} |
| 进程PID | {{pid}} |
| 分析时长 | {{duration}}秒 |
| 总体瓶颈 | {{bottleneck_type}} |
| CPI | {{cpi}} |
| 缓存命中率 | {{cache_hit_rate}}% |

---

## 2. 热点函数 Top 10

| 排名 | 函数名 | CPU% | 样本数 | 模块 | 优化建议 |
|------|--------|------|--------|------|---------|
| 1 | {{func1_name}} | {{func1_pct}}% | {{func1_samples}} | {{func1_dso}} | {{func1_suggestion}} |
| 2 | {{func2_name}} | {{func2_pct}}% | {{func2_samples}} | {{func2_dso}} | {{func2_suggestion}} |
| 3 | {{func3_name}} | {{func3_pct}}% | {{func3_samples}} | {{func3_dso}} | {{func3_suggestion}} |
| ... | ... | ... | ... | ... | ... |

---

## 3. 瓶颈分析

### 3.1 CPU瓶颈

- **CPI (Cycles Per Instruction)**: {{cpi}}
- **评估**: {{cpi_evaluation}}
  - CPI < 1.0: CPU密集型，考虑向量化优化
  - CPI > 2.0: 内存密集型，考虑缓存优化

### 3.2 内存瓶颈

- **缓存命中率**: {{cache_hit_rate}}%
- **L1缓存未命中**: {{l1_miss_rate}}%
- **LLC缓存未命中**: {{llc_miss_rate}}%
- **评估**: {{memory_evaluation}}

### 3.3 分支瓶颈

- **分支预测失败率**: {{branch_miss_rate}}%
- **评估**: {{branch_evaluation}}

---

## 4. 优化建议

### 4.1 高优先级（预期收益 >20%）

#### 建议1: {{high_suggestion1_title}}

- **目标函数**: {{high_suggestion1_target}}
- **当前瓶颈**: {{high_suggestion1_bottleneck}}
- **优化方案**: {{high_suggestion1_solution}}
- **预期收益**: {{high_suggestion1_gain}}
- **实现难度**: {{high_suggestion1_difficulty}}

**代码示例**:
```c
// 优化前
{{high_suggestion1_before}}

// 优化后
{{high_suggestion1_after}}
```

---

### 4.2 中优先级（预期收益 10-20%）

#### 建议1: {{medium_suggestion1_title}}

- **目标函数**: {{medium_suggestion1_target}}
- **优化方案**: {{medium_suggestion1_solution}}
- **预期收益**: {{medium_suggestion1_gain}}

---

### 4.3 低优先级（预期收益 <10%）

{{low_priority_suggestions}}

---

## 5. 4+1 架构视图

### 5.1 逻辑视图

```
{{logical_view}}
```

**调用关系图**:
```
main()
  └── process_data()
        ├── read_input()
        ├── compute()      <-- 热点函数
        │     ├── step1()
        │     └── step2()
        └── write_output()
```

### 5.2 进程视图

```
{{process_view}}
```

**并发模型**: {{concurrency_model}}

### 5.3 开发视图

```
{{development_view}}
```

**模块组织**:
```
src/
├── main.c
├── compute.c      <-- 热点模块
├── io.c
└── utils.c
```

### 5.4 物理视图

```
{{physical_view}}
```

**部署配置**:
- CPU: 鲲鹏920 64核
- 内存: 256GB DDR4
- NUMA: 2节点

### 5.5 场景视图

**关键场景**: {{key_scenario}}

```
1. 用户请求 → main()
2. 数据加载 → read_input()
3. 核心计算 → compute() [热点]
4. 结果输出 → write_output()
```

---

## 6. 优化代码示例

### 6.1 SIMD向量化

**目标函数**: compute()

```c
// 优化前 (标量版本)
void compute_scalar(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] * b[i] + c[i];
    }
}

// 优化后 (NEON向量化版本)
#include <arm_neon.h>
void compute_neon(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; i += 4) {
        float32x4_t va = vld1q_f32(a + i);
        float32x4_t vb = vld1q_f32(b + i);
        float32x4_t vc = vld1q_f32(c + i);
        vc = vmlaq_f32(vc, va, vb);  // FMA: vc = va * vb + vc
        vst1q_f32(c + i, vc);
    }
}
```

### 6.2 编译器优化

```bash
# 原始编译
gcc -O2 -o program program.c

# 优化编译
gcc -O3 -march=armv8.2-a+sve -mtune=tsv110 \
    -ffast-math -funroll-loops \
    -fprofile-generate -o program_pgo program.c

# 运行profile
./program_pgo < typical_input.txt

# 使用PGO编译
gcc -O3 -march=armv8.2-a+sve -mtune=tsv110 \
    -ffast-math -funroll-loops \
    -fprofile-use -o program_opt program.c
```

---

## 7. 下一步行动

1. [ ] 实现高优先级优化建议
2. [ ] 基准测试验证优化效果
3. [ ] 实现中优先级优化建议
4. [ ] 持续监控性能指标

---

## 附录

### A. 原始perf数据

```
{{raw_perf_data}}
```

### B. 硬件计数器

| 计数器 | 值 | 说明 |
|--------|-----|------|
| cycles | {{cycles}} | CPU周期 |
| instructions | {{instructions}} | 指令数 |
| cache-misses | {{cache_misses}} | 缓存未命中 |
| cache-references | {{cache_references}} | 缓存访问 |
| branch-misses | {{branch_misses}} | 分支预测失败 |

### C. 火焰图

![火焰图]({{flamegraph_path}})

---

*报告生成时间: {{report_time}}*
*工具: kunpeng-perf-analyzer v1.0*
