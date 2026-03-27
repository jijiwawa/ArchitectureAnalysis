# 鲲鹏处理器调优手册

## 1. 鲲鹏处理器架构

### 1.1 鲲鹏920规格

| 规格 | 参数 |
|------|------|
| 架构 | ARMv8.2-A |
| 核心 | 64核 (32核x2晶粒) |
| 频率 | 2.6GHz |
| L1 Cache | 64KB I-Cache + 64KB D-Cache |
| L2 Cache | 512KB (每核) |
| L3 Cache | 64MB (共享) |
| 内存 | 8通道DDR4-2933 |
| SIMD | NEON 128-bit + SVE 256-bit |

### 1.2 鲲鹏990规格

| 规格 | 参数 |
|------|------|
| 架构 | ARMv8.4-A |
| 核心 | 128核 |
| 频率 | 2.6GHz |
| L3 Cache | 128MB |
| 内存 | 16通道DDR4-3200 |
| SIMD | NEON 128-bit + SVE 512-bit |

## 2. 编译器优化

### 2.1 GCC 优化选项

```bash
# 基础优化
gcc -O3 -march=armv8.2-a -mtune=tsv110

# 启用SVE
gcc -O3 -march=armv8.2-a+sve -mtune=tsv110

# 完整优化选项
gcc -O3 \
    -march=armv8.2-a+sve \
    -mtune=tsv110 \
    -ffast-math \
    -funroll-loops \
    -ftree-vectorize \
    -fno-math-errno \
    -funsafe-math-optimizations
```

### 2.2 PGO (Profile-Guided Optimization)

```bash
# 第一阶段：生成profile
gcc -O3 -fprofile-generate -march=armv8.2-a+sve -o program_pgo program.c

# 运行典型工作负载
./program_pgo < typical_input.txt

# 第二阶段：使用profile优化
gcc -O3 -fprofile-use -fprofile-correction -march=armv8.2-a+sve -o program_opt program.c
```

### 2.3 LTO (Link-Time Optimization)

```bash
# 编译阶段
gcc -O3 -flto -c file1.c file2.c

# 链接阶段
gcc -O3 -flto -o program file1.o file2.o

# 完整LTO+PGO
gcc -O3 -flto -fprofile-use -march=armv8.2-a+sve -o program file1.c file2.c
```

## 3. SIMD 优化

### 3.1 NEON 向量化

```c
#include <arm_neon.h>

// 标量版本
void add_scalar(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] + b[i];
    }
}

// NEON向量化版本
void add_neon(float* a, float* b, float* c, int n) {
    int i = 0;
    for (; i <= n - 4; i += 4) {
        float32x4_t va = vld1q_f32(a + i);
        float32x4_t vb = vld1q_f32(b + i);
        float32x4_t vc = vaddq_f32(va, vb);
        vst1q_f32(c + i, vc);
    }
    // 处理剩余元素
    for (; i < n; i++) {
        c[i] = a[i] + b[i];
    }
}
```

### 3.2 SVE 向量化（鲲鹏920+）

```c
#include <arm_sve.h>

void add_sve(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; ) {
        // 获取谓词（处理边界）
        svbool_t pg = svwhilelt_b32(i, n);

        // 加载、计算、存储
        svfloat32_t va = svld1_f32(pg, a + i);
        svfloat32_t vb = svld1_f32(pg, b + i);
        svfloat32_t vc = svadd_f32_z(pg, va, vb);
        svst1_f32(pg, c + i, vc);

        // 更新索引
        i += svcntw();  // 获取当前SVE向量宽度
    }
}
```

### 3.3 常用NEON内置函数

| 操作 | 函数 | 说明 |
|------|------|------|
| 加载 | vld1q_f32 | 加载128位向量 |
| 存储 | vst1q_f32 | 存储128位向量 |
| 加法 | vaddq_f32 | 向量加法 |
| 乘法 | vmulq_f32 | 向量乘法 |
| FMA | vfmaq_f32 | 融合乘加 |
| 重新排列 | vrev64q_f32 | 反转元素顺序 |
| 预取 | vld1q_f32 | 配合prefetch |

## 4. 内存优化

### 4.1 数据预取

```c
// 编译器内置预取
#define PREFETCH(addr) __builtin_prefetch(addr, 0, 3)

void process_with_prefetch(float* data, int n) {
    for (int i = 0; i < n; i++) {
        // 预取8个元素之后的数据
        if (i + 8 < n) {
            PREFETCH(&data[i + 8]);
        }
        process(data[i]);
    }
}
```

### 4.2 缓存分块

```c
// 矩阵乘法分块优化
#define BLOCK_SIZE 64

void matmul_blocked(float* A, float* B, float* C, int N) {
    for (int ii = 0; ii < N; ii += BLOCK_SIZE) {
        for (int jj = 0; jj < N; jj += BLOCK_SIZE) {
            for (int kk = 0; kk < N; kk += BLOCK_SIZE) {
                // 处理小块
                for (int i = ii; i < ii + BLOCK_SIZE && i < N; i++) {
                    for (int j = jj; j < jj + BLOCK_SIZE && j < N; j++) {
                        float sum = C[i * N + j];
                        for (int k = kk; k < kk + BLOCK_SIZE && k < N; k++) {
                            sum += A[i * N + k] * B[k * N + j];
                        }
                        C[i * N + j] = sum;
                    }
                }
            }
        }
    }
}
```

### 4.3 数据布局优化

```c
// AoS (Array of Structures) - 不利于向量化
struct Particle_AoS {
    float x, y, z;
    float vx, vy, vz;
};
struct Particle_AoS particles[N];

// SoA (Structure of Arrays) - 利于向量化
struct Particle_SoA {
    float x[N], y[N], z[N];
    float vx[N], vy[N], vz[N];
};
struct Particle_SoA particles;
```

## 5. 高性能库

### 5.1 KML (鲲鹏数学库)

```bash
# 安装KML
yum install kml

# 链接选项
gcc -O3 -lkml -lm my_program.c
```

### 5.2 BLAS 性能对比

| 库 | 矩阵乘法 (GFLOPS) | 相对性能 |
|----|-------------------|---------|
| OpenBLAS | ~150 | 1.0x |
| KML BLAS | ~300 | 2.0x |
| Arm PL | ~280 | 1.9x |

### 5.3 常用替换

```c
// 原始代码
#include <cblas.h>
cblas_sgemm(...);

// 使用KML
#include <kml_blas.h>
kml_sgemm(...);
```

## 6. 系统调优

### 6.1 CPU频率

```bash
# 查看频率
cat /proc/cpuinfo | grep "MHz"

# 设置性能模式
cpupower frequency-set -g performance

# 或手动设置
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

### 6.2 内存大页

```bash
# 配置2MB大页
echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

# 配置1GB大页
echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
```

### 6.3 NUMA配置

```bash
# 查看NUMA拓扑
numactl --hardware

# 绑定NUMA节点
numactl --cpunodebind=0 --membind=0 ./program

# 交错内存分配
numactl --interleave=all ./program
```

### 6.4 中断亲和性

```bash
# 查看中断分布
cat /proc/interrupts

# 设置网卡中断亲和性
echo "0-31" > /proc/irq/eth0/smp_affinity
```

## 7. 性能监控

### 7.1 常用监控命令

```bash
# CPU利用率
mpstat -P ALL 1

# 内存使用
vmstat 1

# IO统计
iostat -x 1

# 网络统计
sar -n DEV 1

# 综合监控
perf stat -a -- sleep 10
```

### 7.2 鲲鹏特定监控

```bash
# 使用sysfs监控
cat /sys/class/hwmon/hwmon0/temp1_input

# 使用ipmi
ipmitool sensor list
```
