---
name: auto-bind
description: 服务器应用自动绑核工具。支持网卡中断绑核、进程/线程 CPU 绑核、NUMA 内存绑定。使用场景：高性能计算优化、降低跨 NUMA 访问延迟、提升服务器应用性能。Use when user asks about CPU binding, NUMA optimization, interrupt affinity, taskset, numactl, or server performance tuning.
---

# Auto Bind - 服务器应用自动绑核

自动化服务器绑核工具，提升 CPU 利用率，降低 NUMA 跨节点访问延迟。

## 🚀 快速开始

### 1. 环境检测（首次使用）

```bash
# 检查环境兼容性
python3 scripts/check_environment.py

# 运行完整测试套件
python3 scripts/test_all.py
```

### 2. 基本使用

```bash
# 完整自动绑核流程
sudo python3 scripts/auto_bind.py --mode full

# 仅检查当前状态（无需 sudo）
python3 scripts/auto_bind.py --mode check

# 仅绑定网卡中断
sudo python3 scripts/auto_bind.py --mode interrupt --nic eth0

# 仅绑定进程（按 CPU 占用排序）
sudo python3 scripts/auto_bind.py --mode process --top 10

# 仅 NUMA 优化
sudo python3 scripts/auto_bind.py --mode numa --process nginx,mysql
```

## 🔍 环境要求

### 必需命令（已预装）
- `taskset` - 进程 CPU 绑核
- `lscpu` - CPU 拓扑信息
- `ps` / `top` - 进程监控

### 可选命令（用于高级功能）
- `numactl` / `numastat` - NUMA 内存绑定（NUMA 系统）
- `perf` - 性能分析和跨 NUMA 访问检测

### 权限要求
- **检查模式** - 普通用户即可
- **绑核操作** - 需要 root 权限（sudo）

### 环境类型

| 环境类型 | 可用功能 | 限制 |
|---------|---------|------|
| **物理服务器** | ✅ 所有功能 | 无 |
| **虚拟机** | ✅ CPU 绑核，⚠️ NUMA | 可能无 NUMA 拓扑 |
| **容器** | ✅ CPU 绑核，❌ NUMA | 无硬件中断，单 NUMA |
| **单 NUMA 系统** | ✅ CPU 绑核 | 无 NUMA 优化 |

## 📋 核心功能

| 功能 | 说明 | 环境 |
|------|------|------|
| **中断绑核** | 检测网卡中断，绑定到指定 CPU 核 | 物理服务器 |
| **进程绑核** | 按 CPU 占用排序，自动绑定进程到 CPU 核 | 所有环境 |
| **NUMA 绑定** | 检测内存访问，按 NUMA 节点绑定内存 | 多 NUMA 系统 |
| **绑定验证** | 检查所有绑定是否符合预期 | 所有环境 |

## 🔄 工作流程

```
┌─────────────────────────────────────────────────────────────┐
│                     Auto Bind 工作流                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 检查网卡中断                                             │
│     ├── top 观察中断进程                                     │
│     ├── 识别网卡中断号                                       │
│     └── 绑定到指定 CPU 核                                    │
│                                                             │
│  2. 分析 CPU 占用                                            │
│     ├── ps 查看 CPU 占比排序                                 │
│     ├── 识别高占用进程/线程                                   │
│     └── taskset/numactl 绑核                                 │
│                                                             │
│  3. NUMA 内存优化                                            │
│     ├── numastat 查看内存分布                                │
│     ├── perf 检测跨 NUMA 访问                                │
│     └── numactl 绑核绑内存                                   │
│                                                             │
│  4. 验证绑定结果                                             │
│     ├── 检查各进程 CPU 亲和性                                │
│     ├── 检查中断 CPU 绑定                                    │
│     └── 生成绑定报告                                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 📚 详细步骤

### Step 1: 检查网卡中断

```bash
# 查看中断分布
cat /proc/interrupts

# 查看网卡中断号
grep eth0 /proc/interrupts

# 查看当前中断 CPU 亲和性
cat /proc/irq/<irq_num>/smp_affinity

# 绑定中断到指定 CPU（例如 CPU 0-3）
echo "f" > /proc/irq/<irq_num>/smp_affinity
```

### Step 2: 进程 CPU 绑核

```bash
# 查看 CPU 占用 Top 10
ps -eo pid,tid,%cpu,comm --sort=-%cpu | head -20

# 使用 taskset 绑定进程到 CPU 0
taskset -pc 0 <pid>

# 使用 numactl 启动进程（绑定到 NUMA 节点 0）
numactl --cpunodebind=0 --membind=0 ./your_app
```

### Step 3: NUMA 内存分析

```bash
# 查看进程 NUMA 内存分布
numastat -p <pid>

# 使用 perf 检测跨 NUMA 访问
perf stat -e local_node_loads,remote_node_loads -p <pid>

# 启动时绑定 NUMA 节点
numactl --cpunodebind=0 --membind=0 -- ./your_app
```

### Step 4: 验证绑定

```bash
# 查看进程 CPU 亲和性
taskset -pc <pid>

# 查看进程 NUMA 绑定
numactl --show <pid>

# 查看线程 CPU 亲和性
taskset -pc <tid>
```

## 🛠️ 脚本说明

| 脚本 | 功能 | 环境 |
|------|------|------|
| `auto_bind.py` | 主脚本，整合所有功能 | 所有 |
| `check_environment.py` | 环境检测和兼容性检查 | 所有 |
| `test_all.py` | 功能测试套件 | 所有 |
| `check_interrupts.py` | 检查网卡中断分布 | 物理服务器 |
| `check_numa.py` | 检查 NUMA 内存分布 | 多 NUMA 系统 |
| `verify_binding.py` | 验证绑定结果 | 所有 |

## 💼 使用场景

### 1. 高性能 Web 服务器

```bash
# Nginx + MySQL 绑核优化
sudo python3 scripts/auto_bind.py \
  --mode numa \
  --process nginx,mysql \
  --nginx-cpus 0-3 \
  --mysql-cpus 4-7 \
  --nginx-node 0 \
  --mysql-node 1
```

### 2. 深度学习训练

```bash
# 训练进程绑核（避免跨 NUMA）
sudo python3 scripts/auto_bind.py \
  --mode numa \
  --process python \
  --bind-memory \
  --node 0
```

### 3. 网络密集型应用

```bash
# 网卡中断绑核
sudo python3 scripts/auto_bind.py \
  --mode interrupt \
  --nic eth0 \
  --cpus 0-3
```

### 4. 容器环境优化

```bash
# 容器内进程绑核（无 NUMA，无中断）
python3 scripts/auto_bind.py --mode check
sudo python3 scripts/auto_bind.py --mode process --processes python3 --cpus 0-3
python3 scripts/verify_binding.py
```

## 🤖 与 AI 助手配合

**用户说：**
- "帮我优化服务器绑核"
- "检查网卡中断分布"
- "这个进程跨 NUMA 访问严重吗？"
- "帮我绑定 nginx 到 CPU 0-3"
- "调试 auto-bind skill 可用性"

**AI 会：**
1. 运行 `check_environment.py` 检测环境
2. 运行 `auto_bind.py --mode check` 查看当前状态
3. 分析 CPU 占用和 NUMA 分布
4. 执行绑核操作
5. 验证绑定结果
6. 生成优化报告

## ⚠️ 注意事项

1. **需要 root 权限** — 绑核操作需要 sudo
2. **谨慎操作** — 错误绑核可能导致性能下降
3. **先检查** — 使用 `--mode check` 先查看当前状态
4. **验证结果** — 绑核后务必验证是否生效
5. **环境差异** — 容器环境功能受限（无中断，单 NUMA）

## 📖 参考资料

- [环境检测说明](scripts/README.md)
- [NUMA 绑定指南](references/numa-guide.md)
- [最佳实践](references/best-practices.md)

## 🧪 测试验证

```bash
# 完整测试套件
python3 scripts/test_all.py

# 单项测试
python3 scripts/check_environment.py
python3 scripts/auto_bind.py --mode check --output test-report.md
python3 scripts/verify_binding.py
```
