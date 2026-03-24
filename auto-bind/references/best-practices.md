# 服务器绑核最佳实践

## 原则

1. **局部性优先** — 数据和处理在同一个 NUMA 节点
2. **避免争抢** — CPU 和内存不要过度集中
3. **隔离干扰** — 高 CPU 进程和 I/O 进程分开
4. **渐进调整** — 小步调整，测试效果

## 应用类型策略

### 网络密集型 (Web 服务器、API 网关)

```
┌─────────────────────────────────────────┐
│ Node 0 (网络 I/O)                        │
│   网卡中断                                │
│   Nginx/网关                              │
│   CPU 0-3: 网络处理                       │
│   CPU 4-7: 业务逻辑                       │
└─────────────────────────────────────────┘
```

**绑定策略：**
```bash
# 1. 绑定网卡中断到 Node 0
echo "f" > /proc/irq/<irq>/smp_affinity

# 2. 绑定 Nginx worker 到 Node 0
taskset -pc 0-7 <nginx_pid>

# 3. 启动时指定
numactl --cpunodebind=0 --membind=0 nginx
```

### 计算密集型 (深度学习、科学计算)

```
┌─────────────────────────────────────────┐
│ Node 0              Node 1              │
│   GPU 0              GPU 1              │
│   训练进程 0          训练进程 1          │
│   本地数据           本地数据            │
└─────────────────────────────────────────┘
```

**绑定策略：**
```bash
# 每个 GPU 对应一个 NUMA 节点
numactl --cpunodebind=0 --membind=0 python train.py --gpu 0 &
numactl --cpunodebind=1 --membind=1 python train.py --gpu 1 &
```

### 内存密集型 (数据库、缓存)

```
┌─────────────────────────────────────────┐
│ Node 0              Node 1              │
│   Redis 主          Redis 从           │
│   数据分片 0         数据分片 1         │
└─────────────────────────────────────────┘
```

**绑定策略：**
```bash
# Redis 主从分布在不同节点
numactl --cpunodebind=0 --membind=0 redis-server --port 6379 &
numactl --cpunodebind=1 --membind=1 redis-server --port 6380 &
```

## 绑核流程

### Step 1: 分析现状

```bash
# 查看进程 CPU 占用
ps -eo pid,tid,%cpu,%mem,comm --sort=-%cpu | head -20

# 查看 NUMA 内存分布
numastat -p <pid>

# 查看网卡中断
cat /proc/interrupts | grep eth
```

### Step 2: 制定策略

| 进程类型 | CPU 绑定 | 内存绑定 | 优先级 |
|---------|---------|---------|-------|
| 高 CPU 进程 | 专用核 | 本地 NUMA | 高 |
| 高内存进程 | NUMA 对应核 | 本地 NUMA | 高 |
| 网络 I/O | 与中断同节点 | 本地 | 中 |
| 后台进程 | 空闲核 | 本地 | 低 |

### Step 3: 执行绑定

```bash
# 1. 绑定网卡中断
for irq in $(grep eth0 /proc/interrupts | cut -d: -f1); do
    echo "f" > /proc/irq/$irq/smp_affinity
done

# 2. 绑定进程
taskset -pc 0-3 <high_cpu_pid>

# 3. NUMA 绑定启动
numactl --cpunodebind=0 --membind=0 ./your_app
```

### Step 4: 验证效果

```bash
# 检查绑定是否生效
taskset -pc <pid>

# 检查 NUMA 内存
numastat -p <pid>

# 检查跨 NUMA 访问
perf stat -e local_node_loads,remote_node_loads -p <pid> sleep 10
```

## 监控和调整

### 持续监控

```bash
# 定期检查
watch -n 5 "ps -eo pid,%cpu,comm --sort=-%cpu | head -10"

# NUMA 内存使用
watch -n 10 numastat

# 中断分布
watch -n 10 "cat /proc/interrupts | grep eth"
```

### 性能对比

```bash
# 绑核前
perf stat -e cycles,instructions,cache-misses ./benchmark

# 绑核后
perf stat -e cycles,instructions,cache-misses ./benchmark

# 对比 cache-miss 率
```

## 常见错误

### ❌ 错误示例

```bash
# 错误1: 所有进程绑到 CPU 0
taskset -pc 0 nginx mysql redis python
# 问题: CPU 0 过载，其他 CPU 闲置

# 错误2: 跨 NUMA 绑定
numactl --cpunodebind=0 --membind=1 ./app
# 问题: CPU 和内存不在同一节点，访问延迟高

# 错误3: 不考虑网卡位置
# 网卡在 Node 1，但进程绑在 Node 0
# 问题: 跨 NUMA 网络访问
```

### ✅ 正确示例

```bash
# 正确1: 按功能分配 CPU
taskset -pc 0-3 nginx     # 网络
taskset -pc 4-7 python    # 计算
taskset -pc 8-11 mysql    # 数据库

# 正确2: 同 NUMA 绑定
numactl --cpunodebind=0 --membind=0 nginx
numactl --cpunodebind=1 --membind=1 python

# 正确3: 中断和进程同节点
# 网卡中断 -> Node 0
# Nginx -> Node 0
```

## 检查清单

- [ ] 查看系统 NUMA 拓扑
- [ ] 识别高 CPU/内存进程
- [ ] 确定网卡位置和中断
- [ ] 制定绑定策略
- [ ] 执行绑定操作
- [ ] 验证绑定生效
- [ ] 测试性能对比
- [ ] 持续监控调整

## 参考资料

- [NUMA 绑定指南](numa-guide.md)
- Linux `numactl` 手册: `man numactl`
- Linux `taskset` 手册: `man taskset`
- 中断亲和性: `/proc/irq/*/smp_affinity`
