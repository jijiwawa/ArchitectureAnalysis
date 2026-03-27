# bpftrace 动态追踪指南

## 1. bpftrace 基础

### 1.1 安装

```bash
# Ubuntu/Debian
sudo apt install bpftrace

# CentOS/RHEL/openEuler
sudo yum install bpftrace

# 从源码编译
git clone https://github.com/iovisor/bpftrace
cd bpftrace
mkdir build && cd build
cmake ..
make && sudo make install
```

### 1.2 基本语法

```
// 探针类型: 探针名称 /过滤条件/ { 动作 }
probe:name /filter/ { action }
```

### 1.3 权限配置

```bash
# 允许非root用户使用bpftrace
sudo sysctl -w kernel.perf_event_paranoid=1
sudo sysctl -w kernel.unprivileged_bpf_disabled=0
```

## 2. 常用探针

### 2.1 进程探针

```bash
# 跟踪函数入口
bpftrace -e 'uprobe:./myapp:function_name { printf("called\n"); }'

# 跟踪函数返回
bpftrace -e 'uretprobe:./myapp:function_name { printf("returned: %d\n", retval); }'

# 跟踪系统调用
bpftrace -e 'tracepoint:syscalls:sys_enter_openat { printf("%s %s\n", comm, str(args->filename)); }'
```

### 2.2 内核探针

```bash
# 跟踪内核函数
bpftrace -e 'kprobe:vfs_read { printf("pid: %d\n", pid); }'

# 跟踪内核返回
bpftrace -e 'kretprobe:vfs_read { printf("ret: %d\n", retval); }'

# 跟踪tracepoint
bpftrace -e 'tracepoint:sched:sched_switch { printf("switch\n"); }'
```

### 2.3 USDT探针

```bash
# 查看USDT探针
bpftrace -l 'usdt:./myapp'

# 跟踪USDT
bpftrace -e 'usdt:./myapp:probe_name { printf("hit\n"); }'
```

## 3. 性能分析脚本

### 3.1 函数耗时统计

```bash
#!/usr/bin/env bpftrace
// func_latency.bt - 函数耗时统计

uprobe:./myapp:hot_function {
    @start[tid] = nsecs;
}

uretprobe:./myapp:hot_function /@start[tid]/ {
    @latency = hist((nsecs - @start[tid]) / 1000);  // 微秒
    delete(@start[tid]);
}

END {
    print(@latency);
}
```

### 3.2 函数调用频率

```bash
#!/usr/bin/env bpftrace
// func_count.bt - 函数调用计数

uprobe:./myapp:* {
    @[probe] = count();
}

END {
    print(@);
}
```

### 3.3 内存分配跟踪

```bash
#!/usr/bin/env bpftrace
// malloc_trace.bt - malloc跟踪

uprobe:/lib/aarch64-linux-gnu/libc.so.6:malloc {
    printf("malloc(%d) = ", arg0);
}

uretprobe:/lib/aarch64-linux-gnu/libc.so.6:malloc {
    printf("%p\n", retval);
}

uprobe:/lib/aarch64-linux-gnu/libc.so.6:free {
    printf("free(%p)\n", arg0);
}
```

### 3.4 IO延迟分析

```bash
#!/usr/bin/env bpftrace
// io_latency.bt - IO延迟分析

kprobe:vfs_read {
    @start[tid] = nsecs;
}

kretprobe:vfs_read /@start[tid]/ {
    @read_ns = hist(nsecs - @start[tid]);
    delete(@start[tid]);
}

kprobe:vfs_write {
    @start[tid] = nsecs;
}

kretprobe:vfs_write /@start[tid]/ {
    @write_ns = hist(nsecs - @start[tid]);
    delete(@start[tid]);
}

END {
    print(@read_ns);
    print(@write_ns);
}
```

## 4. 热点函数分析

### 4.1 CPU采样

```bash
#!/usr/bin/env bpftrace
// profile.bt - CPU采样

profile:hz:99 /pid == TARGET_PID/ {
    @[ustack] = count();
}

END {
    print(@);
}
```

### 4.2 锁竞争分析

```bash
#!/usr/bin/env bpftrace
// lock_contention.bt - 锁竞争分析

uprobe:./myapp:pthread_mutex_lock {
    @lock_start[tid] = nsecs;
}

uretprobe:./myapp:pthread_mutex_lock /@lock_start[tid]/ {
    @lock_wait = hist(nsecs - @lock_start[tid]);
    delete(@lock_start[tid]);
}

END {
    print(@lock_wait);
}
```

### 4.3 缓存未命中分析

```bash
#!/usr/bin/env bpftrace
// cache_miss.bt - 缓存未命中采样

hardware:cache-misses:1000000 {
    @[ustack] = count();
}

END {
    print(@);
}
```

## 5. 内置函数

### 5.1 常用函数

| 函数 | 说明 |
|------|------|
| `pid` | 进程ID |
| `tid` | 线程ID |
| `comm` | 进程名 |
| `nsecs` | 纳秒时间戳 |
| `arg0-argN` | 函数参数 |
| `retval` | 返回值 |
| `ustack` | 用户态调用栈 |
| `kstack` | 内核态调用栈 |
| `str()` | 转换为字符串 |

### 5.2 聚合函数

| 函数 | 说明 |
|------|------|
| `count()` | 计数 |
| `sum()` | 求和 |
| `avg()` | 平均值 |
| `min()` | 最小值 |
| `max()` | 最大值 |
| `hist()` | 直方图 |
| `lhist()` | 线性直方图 |

## 6. 实战案例

### 6.1 跟踪Redis命令

```bash
#!/usr/bin/env bpftrace
// redis_commands.bt

usdt:/usr/bin/redis-server:command__start {
    printf("cmd: %s\n", str(arg0));
}
```

### 6.2 跟踪MySQL查询

```bash
#!/usr/bin/env bpftrace
// mysql_query.bt

usdt:/usr/sbin/mysqld:query__start__ {
    printf("query: %s\n", str(arg0));
}
```

### 6.3 跟踪进程调度延迟

```bash
#!/usr/bin/env bpftrace
// sched_latency.bt

tracepoint:sched:sched_wakeup {
    @wakeup[args->pid] = nsecs;
}

tracepoint:sched:sched_switch /@wakeup[args->prev_pid]/ {
    @run_latency = hist(nsecs - @wakeup[args->prev_pid]);
    delete(@wakeup[args->prev_pid]);
}

END {
    print(@run_latency);
}
```

## 7. 调试技巧

### 7.1 列出可用探针

```bash
# 列出所有探针
bpftrace -l

# 过滤探针
bpftrace -l '*open*'
bpftrace -l 'uprobe:./myapp:*'
```

### 7.2 查看参数类型

```bash
# 查看tracepoint参数
bpftrace -lv 'tracepoint:syscalls:sys_enter_openat'

# 查看结构体定义
bpftrace -lv 'struct task_struct'
```

### 7.3 常见错误

```bash
# 错误: Permission denied
# 解决: 使用sudo或配置权限

# 错误: Probe not found
# 解决: 检查探针名称，使用 -l 列出

# 错误: Map size exceeded
# 解决: 减少map大小或使用过滤条件
```

## 8. 与perf对比

| 特性 | bpftrace | perf |
|------|----------|------|
| 实时追踪 | ✓ | ✗ |
| 自定义逻辑 | ✓ | ✗ |
| 低开销 | ✓ | 中等 |
| 学习曲线 | 较高 | 中等 |
| 内核支持 | 需要较新内核 | 广泛支持 |
