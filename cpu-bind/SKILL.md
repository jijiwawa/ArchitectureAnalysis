# CPU-Bind Skill

## 概述

AI 机头场景专用 CPU 绑核工具，用于高负载进程的 CPU 亲和性优化。

## 功能

1. **进程分析** - 查看 Top N 高 CPU 利用率进程
2. **线程分析** - 查看进程内高 CPU 线程
3. **亲和性分析** - 查看当前 CPU 绑定状态
4. **自动绑核** - 为高 CPU 线程绑定独立核心

## 使用方法

### 1. 查看 Top 3 高 CPU 进程

```bash
python3 scripts/cpu_bind.py --mode top --count 3
```

### 2. 分析进程线程

```bash
python3 scripts/cpu_bind.py --mode analyze --pid <PID>
```

### 3. 绑定线程到独立核心

```bash
sudo python3 scripts/cpu_bind.py --mode bind --pid <PID> --top-threads 3
```

### 4. 验证绑定结果

```bash
python3 scripts/cpu_bind.py --mode verify --pid <PID>
```

### 5. 解除绑定

```bash
sudo python3 scripts/cpu_bind.py --mode unbind --pid <PID>
```

## 参数说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `--mode` | 运行模式: top/analyze/bind/verify/unbind | 必填 |
| `--pid` | 进程 ID | analyze/bind/verify 模式必填 |
| `--count` | Top N 进程数 | 3 |
| `--top-threads` | 绑定的 top N 线程数 | 3 |
| `--duration` | 采样时长（秒） | 3 |
| `--output` | 输出报告文件 | 无 |

## 典型工作流

```
1. 查看 top 进程 → 2. 分析目标进程 → 3. 绑定线程 → 4. 验证结果
```

## 注意事项

- 绑核操作需要 root 权限
- 确保目标核心数量充足
- 绑核后需监控性能变化
