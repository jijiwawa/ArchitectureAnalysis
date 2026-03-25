# pgvector NEON 优化 - 4+1 视图设计

## 1. 场景视图 (Scenario View)

### 1.1 用户场景

| 场景 | 描述 | 参与者 |
|------|------|--------|
| 向量搜索 | 用户在 PostgreSQL 中执行向量相似度查询 | 数据库用户、应用开发者 |
| 批量导入 | 大量向量数据导入数据库，需要快速距离计算 | 数据工程师 |
| 实时推荐 | 基于用户行为实时计算向量相似度 | 推荐系统 |

### 1.2 功能场景

| 场景 | 输入 | 输出 | 距离类型 |
|------|------|------|----------|
| L2 距离搜索 | 两个同维度向量 | 欧几里得距离平方 | L2 Squared |
| 内积搜索 | 两个同维度向量 | 点积值 | Inner Product |
| 余弦相似度 | 两个同维度向量 | 相似度值 (-1, 1) | Cosine Similarity |
| L1 距离搜索 | 两个同维度向量 | 曼哈顿距离 | L1 Distance |
| 汉明距离 | 两个同长度位向量 | 不同位数量 | Hamming |
| Jaccard 距离 | 两个同长度位向量 | 交集/并集比 | Jaccard |

### 1.3 性能场景

| 场景 | 目标 | 指标 |
|------|------|------|
| 高维向量 | 1024+ 维向量快速计算 | 延迟 < 1ms |
| 批量计算 | 10000+ 次距离计算 | 吞吐量 > 1M ops/s |
| 低延迟 | 实时查询响应 | P99 < 100us |

---

## 2. 逻辑视图 (Logical View)

### 2.1 模块划分

```
pgvector-neon/
├── 类型转换层 (Type Conversion)
│   ├── half_types.h      - half ↔ float 转换
│   └── 职责：精度无损转换、边界处理
│
├── 距离计算层 (Distance Calculation)
│   ├── vector_distance   - float32 向量距离
│   ├── half_distance     - float16 向量距离
│   ├── bit_distance      - 位向量距离
│   └── 职责：高效距离计算、SIMD 优化
│
└── 测试验证层 (Testing & Validation)
    ├── test_all           - GTest 功能测试
    ├── benchmark          - 性能基准测试
    └── 职责：正确性验证、性能回归检测
```

### 2.2 核心接口

#### 2.2.1 float32 向量接口

```c
// vector_distance.h

// L2 距离平方
float vector_l2_squared_distance_native(int dim, const float* ax, const float* bx);
float vector_l2_squared_distance_neon(int dim, const float* ax, const float* bx);

// 内积
float vector_inner_product_native(int dim, const float* ax, const float* bx);
float vector_inner_product_neon(int dim, const float* ax, const float* bx);

// 余弦相似度
double vector_cosine_similarity_native(int dim, const float* ax, const float* bx);
double vector_cosine_similarity_neon(int dim, const float* ax, const float* bx);

// L1 距离
float vector_l1_distance_native(int dim, const float* ax, const float* bx);
float vector_l1_distance_neon(int dim, const float* ax, const float* bx);
```

#### 2.2.2 half (float16) 向量接口

```c
// half_distance.h

// L2 距离平方
float halfvec_l2_squared_distance_native(int dim, const half* ax, const half* bx);
float halfvec_l2_squared_distance_neon(int dim, const half* ax, const half* bx);

// 内积
float halfvec_inner_product_native(int dim, const half* ax, const half* bx);
float halfvec_inner_product_neon(int dim, const half* ax, const half* bx);

// 余弦相似度
double halfvec_cosine_similarity_native(int dim, const half* ax, const half* bx);
double halfvec_cosine_similarity_neon(int dim, const half* ax, const half* bx);

// L1 距离
float halfvec_l1_distance_native(int dim, const half* ax, const half* bx);
float halfvec_l1_distance_neon(int dim, const half* ax, const half* bx);
```

#### 2.2.3 位向量接口

```c
// bit_distance.h

// 汉明距离
uint64_t bit_hamming_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
uint64_t bit_hamming_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);

// Jaccard 距离
double bit_jaccard_distance_native(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
double bit_jaccard_distance_neon(uint32_t bytes, const uint8_t* ax, const uint8_t* bx);
```

### 2.3 依赖关系

```
                    +------------------+
                    |   PostgreSQL     |
                    |   (pgvector)     |
                    +--------+---------+
                             |
                    +--------v---------+
                    |  pgvector-neon   |
                    |  (NEON 距离计算) |
                    +--------+---------+
                             |
            +----------------+----------------+
            |                |                |
    +-------v------+ +-------v------+ +-------v------+
    | vector_dist  | | half_dist    | | bit_dist     |
    | (float32)    | | (float16)    | | (binary)     |
    +--------------+ +--------------+ +--------------+
```

---

## 3. 开发视图 (Development View)

### 3.1 目录结构

```
pgvector-neon/
├── include/
│   ├── half_types.h          # half 类型定义 (68 行)
│   ├── half_distance.h       # half 距离函数声明 (22 行)
│   ├── bit_distance.h        # 位向量距离函数声明 (14 行)
│   └── vector_distance.h     # float32 距离函数声明 (21 行)
│
├── src/
│   ├── half_distance_native.c    # half 原生实现 (38 行)
│   ├── half_distance_neon.c      # half NEON 实现 (150 行)
│   ├── bit_distance_native.c     # 位向量原生实现 (48 行)
│   ├── bit_distance_neon.c       # 位向量 NEON 实现 (95 行)
│   ├── vector_distance_native.c  # float32 原生实现 (32 行)
│   └── vector_distance_neon.c    # float32 NEON 实现 (98 行)
│
├── tests/
│   ├── test_all.cpp          # GTest 功能测试 (220 行)
│   ├── simple_test.cpp       # 简单测试框架 (185 行)
│   └── benchmark.cpp         # 性能基准测试 (120 行)
│
├── Makefile                  # 简单构建 (27 行)
├── CMakeLists.txt            # CMake 构建 (35 行)
└── README.md                 # 项目说明
```

### 3.2 构建配置

```makefile
# Makefile
CC = g++
CFLAGS = -std=c++17 -O3 -I./include

# 检测 NEON 支持
ifeq ($(shell uname -m),aarch64)
    CFLAGS += -D__ARM_NEON
endif

all: test
    $(CC) $(CFLAGS) tests/simple_test.cpp src/*.c -o test
    ./test
```

### 3.3 平台支持

| 平台 | 架构 | SIMD | 状态 |
|------|------|------|------|
| ARM64 | aarch64 | NEON | ✅ 完全支持 |
| ARMv8 | armv8-a | NEON | ✅ 完全支持 |
| x86_64 | x86_64 | SSE/AVX | ⚠️ 仅原生实现 |

---

## 4. 过程视图 (Process View)

### 4.1 距离计算流程

```
用户请求
    |
    v
+------------------+
| PostgreSQL       |
| l2_distance()    |
+--------+---------+
         |
         v
+--------+---------+
| pgvector         |
| VectorL2Distance |
+--------+---------+
         |
         v
+--------+---------+     +------------------+
| 检测 CPU 特性    | --> | 选择最优实现     |
+--------+---------+     +--------+---------+
                               |
                +--------------+--------------+
                |                             |
        +-------v-------+            +--------v--------+
        | Native C 实现 |            |  NEON 实现      |
        | (标量循环)    |            | (SIMD 并行)     |
        +-------+-------+            +--------+--------+
                |                             |
                +--------------+--------------+
                               |
                               v
                       +-------+-------+
                       |   返回结果    |
                       +---------------+
```

### 4.2 NEON 优化流程

```
原始数据 (n 维)
    |
    v
+------------------+
| 批量加载         |
| vld1q_f32()      |  <-- 加载 4 个 float
+--------+---------+
         |
         v
+--------+---------+
| 向量运算         |
| vsubq_f32()      |  <-- 并行减法
| vmlaq_f32()      |  <-- FMA 乘加
+--------+---------+
         |
         v
+--------+---------+
| 水平归约         |
| vaddvq_f32()     |  <-- 求和
+--------+---------+
         |
         v
+--------+---------+
| 尾部处理         |
| (n % 4) 个元素   |
+--------+---------+
         |
         v
    返回结果
```

### 4.3 测试流程

```
+------------------+
| 编译测试程序     |
+--------+---------+
         |
         v
+--------+---------+
| 生成测试数据     |
| - 随机向量       |
| - 边界值         |
| - 特殊值 (NaN)   |
+--------+---------+
         |
         v
+--------+---------+     +------------------+
| 执行 Native 版本 | --> | 执行 NEON 版本   |
+--------+---------+     +--------+---------+
         |                             |
         +--------------+--------------+
                       |
                       v
              +--------+---------+
              | 比较结果         |
              | 精度误差 < 1e-5  |
              +--------+---------+
                       |
                       v
              +--------+---------+
              | 性能基准测试     |
              | - 多种维度       |
              | - 多次迭代       |
              +-----------------+
```

---

## 5. 物理视图 (Physical View)

### 5.1 部署架构

```
+------------------+
| PostgreSQL 服务器|
| +-------------+  |
| | pgvector    |  |
| | extension   |  |
| +------+------+  |
|        |         |
| +------v------+  |
| | pgvector-   |  |
| | neon.so     |  |
| +-------------+  |
+------------------+
         |
         v
+--------+---------+
| 硬件加速层       |
| ARM NEON 指令集  |
+------------------+
```

### 5.2 内存布局

```
向量数据内存布局:

float32 向量 (dim=4):
+------+------+------+------+
| f[0] | f[1] | f[2] | f[3] |
| 4B   | 4B   | 4B   | 4B   |
+------+------+------+------+
<-- 16 字节 (128-bit NEON 寄存器) -->

half 向量 (dim=8):
+------+------+------+------+------+------+------+------+
| h[0] | h[1] | h[2] | h[3] | h[4] | h[5] | h[6] | h[7] |
| 2B   | 2B   | 2B   | 2B   | 2B   | 2B   | 2B   | 2B   |
+------+------+------+------+------+------+------+------+
<-- 16 字节 (128-bit NEON 寄存器) -->

位向量 (bytes=16):
+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
| b0 | b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8 | b9 |... |b14 |b15 |
+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
<-- 16 字节 (128-bit NEON 寄存器) -->
```

### 5.3 寄存器使用

| 寄存器类型 | 大小 | 用途 |
|-----------|------|------|
| float32x4_t | 128-bit | 存储 4 个 float32 |
| float16x4_t | 64-bit | 存储 4 个 float16 |
| uint8x16_t | 128-bit | 存储 16 个 uint8 |
| uint32x4_t | 128-bit | 累加器 |

---

## 6. 设计决策

