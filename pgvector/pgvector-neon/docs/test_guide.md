# pgvector NEON 优化 - 测试指南

## 1. 功能测试

### 1.1 测试环境准备

```bash
# 安装依赖
sudo apt-get install -y cmake g++ libgtest-dev

# 编译项目
cd pgvector-neon
mkdir build && cd build
cmake .. && make
```

### 1.2 运行测试

```bash
# 方式1：使用 CMake + GTest
./test_all

# 方式2：使用简单测试框架（无需 GTest）
./test_simple
```

### 1.3 测试用例覆盖

| 测试类别 | 测试项 | 维度/大小 |
|----------|--------|-----------|
| **float32** | L2距离 | 4, 16, 64, 256, 512 |
| | 内积 | 4, 16, 64, 256, 512 |
| | 余弦相似度 | 4, 16, 64, 256, 512 |
| | L1距离 | 4, 16, 64, 256, 512 |
| **half** | L2距离 | 4, 16, 64, 256, 512 |
| | 内积 | 4, 16, 64, 256, 512 |
| | 余弦相似度 | 4, 16, 64, 256, 512 |
| | L1距离 | 4, 16, 64, 256, 512 |
| **bit** | 汉明距离 | 8, 32, 128, 512, 1024 字节 |
| | Jaccard距离 | 8, 32, 128, 512, 1024 字节 |

### 1.4 测试数据生成

```cpp
// 随机 float32 向量
std::mt19937 gen(42);  // 固定种子，可复现
std::uniform_real_distribution<float> dist(-100.0f, 100.0f);
for (int i = 0; i < dim; i++) {
    a[i] = dist(gen);
}

// 随机 half 向量
for (int i = 0; i < dim; i++) {
    a[i] = float_to_half(dist(gen));
}

// 随机位向量
std::uniform_int_distribution<int> byte_dist(0, 255);
for (uint32_t i = 0; i < bytes; i++) {
    a[i] = byte_dist(gen);
}
```

### 1.5 精度验证

```cpp
// 浮点精度容差
const float FLOAT_EPSILON = 1e-5f;
const double DOUBLE_EPSILON = 1e-10;

// 比较函数
bool float_equal(float a, float b, float eps = FLOAT_EPSILON) {
    if (std::isnan(a) && std::isnan(b)) return true;
    if (std::isinf(a) && std::isinf(b)) return (a > 0) == (b > 0);
    return std::fabs(a - b) < eps;
}

// 测试断言
EXPECT_NEAR(native_result, neon_result, FLOAT_EPSILON);
```

### 1.6 边界测试

```cpp
// 空向量
TEST(VectorDistance, EmptyVector) {
    EXPECT_TRUE(std::isnan(vector_l2_squared_distance_neon(0, nullptr, nullptr)));
}

// 单元素
TEST(VectorDistance, SingleElement) {
    float a[] = {1.0f}, b[] = {2.0f};
    EXPECT_NEAR(vector_l2_squared_distance_neon(1, a, b), 1.0f, 1e-5f);
}

// 非对齐维度 (不满足4的倍数)
TEST(VectorDistance, NonAlignedDimension) {
    float a[7] = {1,2,3,4,5,6,7};
    float b[7] = {7,6,5,4,3,2,1};
    float native = vector_l2_squared_distance_native(7, a, b);
    float neon = vector_l2_squared_distance_neon(7, a, b);
    EXPECT_NEAR(native, neon, 1e-5f);
}

// 特殊值
TEST(VectorDistance, SpecialValues) {
    float a[] = {0.0f, -0.0f, INFINITY, -INFINITY, NAN};
    float b[] = {0.0f, 0.0f, 1.0f, 1.0f, 0.0f};
    // ... 验证行为
}
```

---

## 2. 性能测试

### 2.1 基准测试程序

```bash
# 编译
g++ -O3 -I./include -D__ARM_NEON tests/benchmark.cpp src/*.c -o benchmark

# 运行
./benchmark
```

### 2.2 性能指标

| 指标 | 说明 | 目标 |
|------|------|------|
| 延迟 | 单次计算耗时 | < 1us (dim=128) |
| 吞吐量 | 每秒操作数 | > 1M ops/s |
| 加速比 | NEON / Native | > 3x (float32) |

### 2.3 测试维度

```cpp
// 推荐测试维度
int dimensions[] = {4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};

// 迭代次数（保证统计显著性）
int iterations = 10000;
```

### 2.4 基准测试代码

```cpp
template<typename Func, typename... Args>
double benchmark(Func func, int iterations, Args... args) {
    // 预热
    for (int i = 0; i < 10; i++) {
        func(args...);
    }
    
    // 计时
    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        func(args...);
    }
    auto end = std::chrono::high_resolution_clock::now();
    
    // 返回平均耗时（微秒）
    return std::chrono::duration<double, std::micro>(end - start).count() / iterations;
}
```

### 2.5 性能报告格式

```
=== Performance Benchmark ===
| Func    | Dim   | Native (us) | NEON (us) | Speedup |
|---------|-------|-------------|-----------|---------|
| VEC-L2  |   128 |        0.03 |      0.01 |   3.01x |
| VEC-L2  |   512 |        0.17 |      0.05 |   3.54x |
| VEC-L2  |  1024 |        0.43 |      0.11 |   4.10x |
| HALF-L2 |   128 |        0.12 |      0.01 |  13.07x |
| HALF-L2 |   512 |        0.46 |      0.05 |   8.93x |
| HALF-L2 |  1024 |        0.92 |      0.12 |   7.81x |
| BIT-HAM |  1024 |        0.04 |      0.04 |   0.99x |
```

### 2.6 性能回归检测

```bash
#!/bin/bash
# perf_check.sh - 性能回归检查

THRESHOLD=3.0  # 最低加速比阈值

./benchmark > results.txt

# 检查加速比
grep -E "VEC-L2|HALF-L2" results.txt | while read line; do
    speedup=$(echo "$line" | awk '{print $NF}' | sed 's/x//')
    if (( $(echo "$speedup < $THRESHOLD" | bc -l) )); then
        echo "FAIL: $line (speedup < ${THRESHOLD}x)"
        exit 1
    fi
done

echo "Performance check passed!"
```

---

## 3. 集成测试

### 3.1 PostgreSQL 集成

```sql
-- 创建测试表
CREATE TABLE test_vectors (id serial, vec vector(128));
INSERT INTO test_vectors (vec) 
SELECT array_agg(random())::vector FROM generate_series(1, 128), generate_series(1, 1000);

-- 测试距离计算
EXPLAIN ANALYZE 
SELECT id, l2_distance(vec, '[1,2,3,...]'::vector) 
FROM test_vectors 
ORDER BY l2_distance(vec, '[1,2,3,...]'::vector) 
LIMIT 10;
```

### 3.2 压力测试

```bash
# 并发查询测试
pgbench -c 16 -j 4 -T 60 -f query.sql testdb
```

---

## 4. 验收标准

### 4.1 功能验收

- [ ] 所有测试用例通过
- [ ] 精度误差 < 1e-5
- [ ] 边界条件处理正确
- [ ] 特殊值（NaN/Inf）处理正确

### 4.2 性能验收

| 类型 | 最低加速比 |
|------|-----------|
| float32 L2 | 3.0x |
| half L2 | 5.0x |
| bit Hamming | 1.0x (允许持平) |

### 4.3 稳定性验收

- [ ] 无内存泄漏
- [ ] 无段错误
- [ ] 1000万次调用无异常
