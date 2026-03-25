# NUMA 绑定指南

## 什么是 NUMA

NUMA (Non-Uniform Memory Access) 是一种内存架构，多处理器系统中每个 CPU 有自己的本地内存，访问本地内存比访问远程内存更快。

```
┌─────────────────────────────────────────────────────────────┐
│                      NUMA 架构示例                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   Node 0                    Node 1                          │
│  ┌──────────┐              ┌──────────┐                     │
│  │ CPU 0-7  │              │ CPU 8-15 │                     │
│  │ Memory   │◄──快────────►│ Memory   │                     │
│  │ 32GB     │              │ 32GB     │                     │
│  └────┬─────┘              └────┬─────┘                     │
│       │                         │                           │
│       │         慢              │                           │
│       └─────────────────────────┘                           │
│           (跨 NUMA 访问)                                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## NUMA 相关命令

### 查看系统 NUMA 拓扑

```bash
# 查看 NUMA 节点信息
numactl --hardware

# 查看各节点内存使用
numastat

# 查看节点 CPU 列表
ls /sys/devices/system/node/
cat /sys/devices/system/node/node0/cpulist
```

### 查看进程 NUMA 内存分布

```bash
# 查看进程内存在各 NUMA 节点的分布
numastat -p <pid>

# 示例输出
# Node 0 Node 1 Total
# --------------- --------------- ---------------
# Mem 1024 512 1536
```

### 检测跨 NUMA 访问

```bash
# 使用 perf 检测
perf stat -e local_node_loads,remote_node_loads -p <pid> sleep 5

# 输出示例
# 15,234 local_node_loads
# 1,532 remote_node_loads  # 这个值高说明跨 NUMA 访问多
```

## NUMA 绑定方法

### 1. 启动时绑定 (numactl)

```bash
# 绑定到 Node 0 的 CPU 和内存
numactl --cpunodebind=0 --membind=0 ./my_app

# 绑定到指定 CPU 和内存节点
numactl --physcpubind=0-3 --membind=0 ./my_app

# 优先使用本地内存，允许跨 NUMA
numactl --preferred=0 ./my_app
```

### 2. 运行时绑定 (taskset)

```bash
# 只能绑定 CPU，不能绑定内存
taskset -pc 0-3 <pid>

# 启动时绑定
taskset -c 0-3 ./my_app
```

### 3. 中断绑核

```bash
# 查看中断 CPU 亲和性
cat /proc/irq/<irq_num>/smp_affinity

# 绑定中断到 CPU 0-3 (掩码: f = 1111)
echo "f" > /proc/irq/<irq_num>/smp_affinity

# 绑定到 CPU 0,2 (掩码: 5 = 0101)
echo "5" > /proc/irq/<irq_num>/smp_affinity
```

## CPU 掩码计算

```python
# Python 计算掩码
def cpus_to_mask(cpus):
    mask = 0
    for cpu in cpus:
        mask |= (1 << cpu)
    return format(mask, 'x')

# 示例
cpus_to_mask([0, 1, 2, 3])  # 'f'
cpus_to_mask([0, 2])        # '5'
cpus_to_mask([8, 9])        # '300'
```

## 常见场景

### Web 服务器 (Nginx)

```bash
# Node 0 运行 Nginx
numactl --cpunodebind=0 --membind=0 nginx

# 中断绑定到 Node 0 的 CPU
for irq in $(grep eth0 /proc/interrupts | cut -d: -f1); do
    echo "f" > /proc/irq/$irq/smp_affinity
done
```

### 数据库 (MySQL)

```bash
# 绑定到 Node 1，大内存优先
numactl --cpunodebind=1 --membind=1 --interleave=all mysqld

# 或使用 preferred，允许必要时使用其他节点
numactl --preferred=1 mysqld
```

### 深度学习训练

```bash
# 绑定到特定 NUMA 节点
numactl --cpunodebind=0 --membind=0 python train.py

# 多卡训练时，每张卡绑定到对应的 NUMA 节点
# GPU 0 -> Node 0
numactl --cpunodebind=0 --membind=0 python train.py --gpu 0
# GPU 1 -> Node 1
numactl --cpunodebind=1 --membind=1 python train.py --gpu 1
```

## 最佳实践

1. **绑定内存比绑定 CPU 更重要** — 跨 NUMA 访问延迟影响更大
2. **中断和进程在同一 NUMA 节点** — 网络密集型应用
3. **大内存进程必须绑定** — 避免内存碎片化
4. **测试验证** — 使用 numastat 和 perf 确认绑定效果
5. **监控调整** — 根据实际运行情况调整绑定策略

## 常见问题

### Q: 如何判断是否需要 NUMA 绑定？

```bash
# 检查跨 NUMA 访问
perf stat -e local_node_loads,remote_node_loads -p <pid> sleep 10

# 如果 remote_node_loads 占比 > 20%，建议绑定
```

### Q: 绑定后性能反而下降？

可能原因：
- 绑定到错误的 NUMA 节点（数据实际在另一个节点）
- 绑定的 CPU 不足，导致争抢
- 中断和进程不在同一节点

### Q: 多 NUMA 节点如何选择？

- 网络密集型：绑定到网卡所在的 NUMA 节点
- 内存密集型：绑定到内存更多的节点
- 计算密集型：绑定到空闲 CPU 多的节点
