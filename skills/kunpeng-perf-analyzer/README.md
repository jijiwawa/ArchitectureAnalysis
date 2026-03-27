# kunpeng-perf-analyzer 使用指南

> 鲲鹏CPU性能分析 Skill 完整使用手册
>
> 版本: 1.0.0 | 更新日期: 2026-03-27

---

## 目录

1. [快速开始](#1-快速开始)
2. [环境准备](#2-环境准备)
3. [加载 Skill](#3-加载-skill)
4. [基础用法](#4-基础用法)
5. [脚本工具](#5-脚本工具)
6. [参考文档](#6-参考文档)
7. [实战案例](#7-实战案例)
8. [常见问题](#8-常见问题)

---

## 1. 快速开始

### 1.1 一分钟快速体验

```bash
# 1. 加载 skill
claude plugin install ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/kunpeng-perf

# 2. 在 Claude Code 中使用
# 直接告诉 Claude：
"帮我分析这个 perf 报告，识别热点函数并给出优化建议"
```

### 1.2 核心功能一览

```
┌─────────────────────────────────────────────────────────┐
│                  kunpeng-perf-analyzer                  │
├─────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │  热点分析   │  │  火焰图生成  │  │  瓶颈识别   │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │  优化建议   │  │  SIMD代码   │  │  4+1视图    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
```

---

## 2. 环境准备

### 2.1 系统要求

| 要求 | 说明 |
|------|------|
| 处理器 | 鲲鹏920/990 或兼容 ARMv8.2+ 处理器 |
| 操作系统 | Linux (openEuler, CentOS, Ubuntu 等) |
| 内核版本 | 4.18+ (推荐 5.4+) |
| 权限 | root 或配置 perf_event_paranoid |

### 2.2 安装依赖工具

```bash
# openEuler / CentOS / RHEL
sudo yum install -y perf bpftrace python3

# Ubuntu / Debian
sudo apt install -y linux-tools-common linux-tools-generic \
                    bpftrace python3

# 安装 FlameGraph (可选，用于火焰图)
git clone https://github.com/brendangregg/FlameGraph.git
export PATH=$PATH:$(pwd)/FlameGraph
```

### 2.3 配置权限

```bash
# 允许非 root 用户使用 perf
sudo sysctl -w kernel.perf_event_paranoid=1

# 永久配置
echo "kernel.perf_event_paranoid=1" | sudo tee -a /etc/sysctl.conf

# 允许非 root 用户使用 bpftrace
sudo sysctl -w kernel.unprivileged_bpf_disabled=0
```

### 2.4 验证环境

```bash
# 验证 perf
perf --version

# 验证 bpftrace
bpftrace --version

# 验证 Python
python3 --version

# 验证 CPU 架构
cat /proc/cpuinfo | grep "CPU implementer"
# 0x48 表示华为鲲鹏
```

---

## 3. 加载 Skill

### 3.1 方式一：命令行加载

```bash
claude plugin install ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/kunpeng-perf
```

### 3.2 方式二：启动时指定

```bash
claude --plugin-dir ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/kunpeng-perf
```

### 3.3 验证加载成功

在 Claude Code 对话中输入：

```
帮我查看 kunpeng-perf-analyzer skill 的功能
```

---

## 4. 基础用法

### 4.1 采集性能数据

**方式一：使用 Claude 辅助采集**

```
请帮我采集进程 12345 的性能数据，采集 60 秒
```

**方式二：手动采集**

```bash
# 基础采集
perf record -g -p 12345 -- sleep 30

# 采集硬件计数器
perf record -e cycles,instructions,cache-misses,cache-references \
            -g -p 12345 -- sleep 30

# 生成报告
perf report --stdio > perf_report.txt
```

### 4.2 分析热点函数

将 perf 报告提供给 Claude：

```
请分析这个 perf 报告，识别 Top 10 热点函数：

[粘贴 perf report 输出]
```

### 4.3 获取优化建议

```
这个函数占用了 35% CPU，请给出优化建议：

void process_array(float* data, int n) {
    for (int i = 0; i < n; i++) {
        data[i] = data[i] * 2.0f + 1.0f;
    }
}
```

### 4.4 生成 4+1 视图

```
请为这个热点函数生成 4+1 架构视图：

[粘贴源代码]
```

---

## 5. 脚本工具

### 5.1 hotspot_collector.sh - 一键采集

**基本用法**

```bash
# 采集指定进程
./hotspot_collector.sh -p 12345 -d 60

# 采集并收集硬件计数器
./hotspot_collector.sh -p 12345 -d 30 -H

# 指定输出目录
./hotspot_collector.sh -p 12345 -d 30 -o ./my_analysis
```

**参数说明**

| 参数 | 说明 | 默认值 |
|------|------|--------|
| -p | 目标进程 PID | 必需 |
| -d | 采集时长（秒） | 30 |
| -o | 输出目录 | ./perf_data |
| -H | 采集硬件计数器 | 否 |
| -k | 采集内核符号 | 否 |

**输出文件**

```
./perf_data/
├── perf_report_20260327_143000.txt    # 文本报告
├── perf_data_20260327_143000.data     # 原始数据
└── flamegraph_20260327_143000.svg     # 火焰图（如已安装）
```

### 5.2 flamegraph_gen.py - 火焰图生成

**基本用法**

```bash
# 从 perf.data 生成火焰图
python3 flamegraph_gen.py -i perf.data -o flamegraph.svg

# 自定义标题
python3 flamegraph_gen.py -i perf.data -o flamegraph.svg \
                          -t "My Application Flame Graph"
```

**依赖**

```bash
# 需要安装 FlameGraph 工具
git clone https://github.com/brendangregg/FlameGraph.git
export PATH=$PATH:$(pwd)/FlameGraph
```

### 5.3 bottleneck_analyzer.py - 瓶颈分析

**基本用法**

```bash
# 分析 perf 报告
python3 bottleneck_analyzer.py perf_report.txt

# 输出 JSON 格式
python3 bottleneck_analyzer.py --json perf_report.txt
```

**输出示例**

```markdown
# 性能分析报告

## 1. 瓶颈类型
**内存密集型**

## 2. 热点函数 Top 10
| 排名 | 函数名 | CPU% | DSO |
|------|--------|------|-----|
| 1 | process_data | 35.2% | myapp |
| 2 | compute_hash | 18.5% | myapp |
...

## 3. 优化建议
### 高优先级
- **向量化**: 使用NEON/SVE指令进行向量化
  - 预期收益: 2-8x
  - 实现方法: 参考 simd_patterns.md
```

---

## 6. 参考文档

### 6.1 文档列表

| 文档 | 路径 | 内容 |
|------|------|------|
| perf 使用指南 | references/perf_events.md | perf 命令详解 |
| 鲲鹏调优手册 | references/kunpeng_tuning.md | 编译优化、SIMD、高性能库 |
| bpftrace 探针 | references/bpftrace_probes.md | 动态追踪脚本 |
| SIMD 优化模式 | references/simd_patterns.md | NEON/SVE 优化模式 |

### 6.2 快速查阅

```
# 在 Claude 中直接提问：
"参考 kunpeng_tuning.md，告诉我如何配置 PGO 优化"
"查看 simd_patterns.md，给我一个矩阵乘法 NEON 优化示例"
```

---

## 7. 实战案例

### 7.1 案例1：Web服务器性能优化

**场景**: Nginx 处理请求延迟高

```bash
# Step 1: 采集数据
./hotspot_collector.sh -p $(pgrep nginx) -d 60 -H

# Step 2: 分析报告
# 将生成的 perf_report.txt 提供给 Claude

# Step 3: 根据建议优化
# Claude 可能建议：启用 gzip 压缩优化、调整 worker 数量等
```

### 7.2 案例2：数据库热点优化

**场景**: MySQL 查询性能瓶颈

```bash
# Step 1: 定位热点
perf record -g -p $(pgrep mysqld) -- sleep 30
perf report --stdio > mysql_perf.txt

# Step 2: 让 Claude 分析
# 提示词："分析这个 MySQL 性能报告，识别热点函数并给出优化建议"

# Step 3: 可能的优化方向
# - 索引优化
# - 查询重写
# - 缓冲池调整
```

### 7.3 案例3：计算密集型应用优化

**场景**: 图像处理程序 CPU 占用高

```bash
# Step 1: 采集数据
perf record -g -e cycles,instructions,cache-misses \
            -p $PID -- sleep 30

# Step 2: 分析热点
perf report --stdio

# Step 3: 优化示例
```

**原始代码**:
```c
void process_image(float* pixels, int n) {
    for (int i = 0; i < n; i++) {
        pixels[i] = pixels[i] * 0.5f + 0.5f;
    }
}
```

**优化后 (NEON)**:
```c
#include <arm_neon.h>

void process_image_neon(float* pixels, int n) {
    float32x4_t scale = vdupq_n_f32(0.5f);
    float32x4_t offset = vdupq_n_f32(0.5f);

    for (int i = 0; i < n; i += 4) {
        __builtin_prefetch(&pixels[i + 16]);
        float32x4_t v = vld1q_f32(pixels + i);
        v = vmlaq_f32(offset, v, scale);  // v * 0.5 + 0.5
        vst1q_f32(pixels + i, v);
    }

    // 处理尾部
    for (int i = (n / 4) * 4; i < n; i++) {
        pixels[i] = pixels[i] * 0.5f + 0.5f;
    }
}
```

**预期收益**: 3-4x 加速

### 7.4 案例4：完整优化工作流

```bash
# Day 1: 基线采集
./hotspot_collector.sh -p $PID -d 60 -H -o baseline

# Day 2: 实施优化
# - 根据分析结果修改代码
# - 应用编译器优化选项

# Day 3: 验证效果
./hotspot_collector.sh -p $PID -d 60 -H -o optimized

# 对比分析
python3 bottleneck_analyzer.py baseline/perf_report.txt > baseline_analysis.md
python3 bottleneck_analyzer.py optimized/perf_report.txt > optimized_analysis.md
```

---

## 8. 常见问题

### Q1: perf 采集失败 "Permission denied"

```bash
# 解决方案
sudo sysctl -w kernel.perf_event_paranoid=1

# 或使用 sudo
sudo perf record -g -p $PID -- sleep 30
```

### Q2: 函数显示为 [unknown]

```bash
# 原因：缺少调试符号

# 解决方案1：编译时添加 -g
gcc -g -O2 program.c -o program

# 解决方案2：安装调试符号包
# openEuler
sudo yum install gdb

# 解决方案3：禁用 strip
gcc -g -O2 -Wl,--strip-debug program.c -o program  # 不推荐
```

### Q3: 火焰图生成失败

```bash
# 检查 FlameGraph 是否安装
which flamegraph.pl

# 安装
git clone https://github.com/brendangregg/FlameGraph.git
export PATH=$PATH:$(pwd)/FlameGraph
```

### Q4: CPI 计算不准确

```bash
# 确保采集了 cycles 和 instructions
perf stat -e cycles,instructions -p $PID -- sleep 10

# 检查是否支持硬件计数器
perf list | grep -E "cycles|instructions"
```

### Q5: NEON 优化效果不明显

可能原因：
1. 数据未对齐（建议 16 字节对齐）
2. 循环次数太小（SIMD 有开销）
3. 内存带宽瓶颈（非计算瓶颈）

```c
// 确保数据对齐
float* data = aligned_alloc(16, n * sizeof(float));

// 或使用编译器属性
float data[n] __attribute__((aligned(16)));
```

### Q6: SVE 代码无法编译

```bash
# 需要 GCC 8.0+ 或 LLVM 9.0+
gcc --version

# 编译选项
gcc -O3 -march=armv8.2-a+sve -o program program.c
```

---

## 附录

### A. 快速参考卡片

```
┌─────────────────────────────────────────────────────────────┐
│                    kunpeng-perf-analyzer                     │
│                     快速参考卡片                              │
├─────────────────────────────────────────────────────────────┤
│ 采集命令:                                                    │
│   perf record -g -p <PID> -- sleep <seconds>                │
│   perf record -e cycles,instructions,cache-misses -g ...    │
│                                                              │
│ 分析命令:                                                    │
│   perf report --stdio                                        │
│   perf report -g graph,0.5,caller                           │
│                                                              │
│ 瓶颈判断:                                                    │
│   CPI > 2.0  → 内存瓶颈                                      │
│   CPI < 1.0  → CPU瓶颈                                       │
│   cache-miss > 10% → 缓存优化                                │
│   branch-miss > 5%  → 分支优化                               │
│                                                              │
│ 编译优化:                                                    │
│   gcc -O3 -march=armv8.2-a+sve -mtune=tsv110                │
│   -ffast-math -funroll-loops                                 │
│   -fprofile-generate / -fprofile-use                        │
│                                                              │
│ SIMD 类型:                                                   │
│   NEON: 128-bit (4x float32)                                │
│   SVE:  可变宽度 (鲲鹏920: 256-bit)                          │
└─────────────────────────────────────────────────────────────┘
```

### B. 相关资源

| 资源 | 链接 |
|------|------|
| 鲲鹏开发者社区 | https://www.hikunpeng.com/developer |
| ARM NEON 文档 | https://developer.arm.com/architectures/instruction-sets/intrinsics/ |
| perf Wiki | https://perf.wiki.kernel.org/ |
| FlameGraph | https://github.com/brendangregg/FlameGraph |
| bpftrace | https://github.com/iovisor/bpftrace |

---

*文档版本: 1.0.0*
*最后更新: 2026-03-27*
