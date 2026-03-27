# perf Events 使用指南

## 1. perf 基础

### 1.1 安装

```bash
# Ubuntu/Debian
sudo apt install linux-tools-common linux-tools-generic linux-tools-$(uname -r)

# CentOS/RHEL
sudo yum install perf

# openEuler
sudo yum install perf
```

### 1.2 权限配置

```bash
# 临时允许非root用户使用perf
sudo sysctl -w kernel.perf_event_paranoid=1

# 永久配置
echo "kernel.perf_event_paranoid=1" | sudo tee -a /etc/sysctl.conf
```

## 2. 常用命令

### 2.1 性能采集

```bash
# 采样指定进程（PID）
perf record -g -p <pid> -- sleep 30

# 采样整个系统
perf record -g -a -- sleep 30

# 采样指定命令
perf record -g -- ./my_program

# 指定采样频率
perf record -g -F 99 -p <pid> -- sleep 30

# 采集调用栈（用户态+内核态）
perf record -g -p <pid> --call-graph dwarf -- sleep 30
```

### 2.2 查看报告

```bash
# 交互式查看
perf report

# 文本输出
perf report --stdio

# 只看用户态
perf report --stdio --no-children --percent-limit 1

# 查看调用链
perf report -g graph,0.5,caller
```

### 2.3 实时监控

```bash
# 实时top
perf top

# 指定进程
perf top -p <pid>

# 指定事件
perf top -e cycles,instructions -p <pid>
```

## 3. 硬件事件

### 3.1 鲲鹏支持的硬件事件

```bash
# 查看支持的事件
perf list

# 常用硬件事件
perf record -e cycles,instructions,cache-misses,cache-references,branch-misses,branches -g -p <pid>
```

### 3.2 关键事件说明

| 事件 | 说明 | 用途 |
|------|------|------|
| cycles | CPU周期数 | 计算CPI |
| instructions | 指令数 | 计算CPI |
| cache-misses | 缓存未命中 | 内存瓶颈分析 |
| cache-references | 缓存访问次数 | 缓存命中率计算 |
| branch-misses | 分支预测失败 | 分支优化分析 |
| branches | 分支指令数 | 分支预测率计算 |
| L1-dcache-loads | L1数据缓存加载 | L1缓存分析 |
| L1-dcache-load-misses | L1缓存未命中 | L1效率分析 |
| LLC-loads | 最后级缓存加载 | LLC分析 |
| LLC-load-misses | LLC未命中 | LLC效率分析 |

### 3.3 鲲鹏特有事件

```bash
# 鲲鹏920特有事件
perf list | grep -i hisi

# 示例
perf record -e hisi_ddrc_flux_rd,hisi_ddrc_flux_wr -p <pid>
```

## 4. perf stat 统计

```bash
# 基础统计
perf stat -p <pid> -- sleep 10

# 详细统计
perf stat -d -p <pid> -- sleep 10

# 自定义事件
perf stat -e cycles,instructions,cache-misses -p <pid> -- sleep 10

# 重复运行
perf stat -r 10 -p <pid> -- sleep 5
```

## 5. 高级用法

### 5.1 火焰图数据采集

```bash
# 采集用于火焰图的数据
perf record -g -F 99 -p <pid> -- sleep 30

# 转换为火焰图格式
perf script | stackcollapse-perf.pl | flamegraph.pl > flamegraph.svg
```

### 5.2 内存访问分析

```bash
# 内存采样
perf mem record -p <pid> -- sleep 30
perf mem report
```

### 5.3 锁分析

```bash
# 锁竞争分析
perf lock record -p <pid> -- sleep 30
perf lock report
```

### 5.4 调度延迟分析

```bash
# 调度延迟
perf sched record -p <pid> -- sleep 30
perf sched latency
```

## 6. 输出解读

### 6.1 CPI 计算

```bash
# CPI = cycles / instructions
perf stat -e cycles,instructions -p <pid> -- sleep 10

# CPI < 1.0: CPU密集型
# CPI > 2.0: 内存密集型
```

### 6.2 缓存命中率

```bash
# 缓存命中率 = 1 - (cache-misses / cache-references)
perf stat -e cache-misses,cache-references -p <pid> -- sleep 10

# 命中率 > 90%: 良好
# 命中率 < 80%: 需要优化
```

## 7. 常见问题

### Q1: 权限错误

```bash
# 错误: Permission denied
# 解决:
sudo sysctl -w kernel.perf_event_paranoid=1
```

### Q2: 符号缺失

```bash
# 错误: [unknown] 符号
# 解决:
# 1. 安装调试符号
# 2. 编译时添加 -g
# 3. 禁用 strip
```

### Q3: 采样频率过高

```bash
# 错误: Too many events
# 解决: 降低采样频率
perf record -F 49 -g -p <pid>  # 默认4000，降低到49
```
