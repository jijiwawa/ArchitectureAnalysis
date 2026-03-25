# pgvector NEON 优化实现

ARM NEON SIMD 优化版本的 pgvector 距离计算函数。

## 目录结构

```
pgvector-neon/
├── include/
│   ├── half_types.h          # half 精度类型定义
│   ├── half_distance.h       # half 距离函数声明
│   ├── bit_distance.h        # 位向量距离函数声明
│   └── vector_distance.h     # float32 距离函数声明
├── src/
│   ├── half_distance_native.c    # half 原生实现
│   ├── half_distance_neon.c      # half NEON 实现
│   ├── bit_distance_native.c     # 位向量原生实现
│   ├── bit_distance_neon.c       # 位向量 NEON 实现
│   ├── vector_distance_native.c  # float32 原生实现
│   └── vector_distance_neon.c    # float32 NEON 实现
├── tests/
│   └── simple_test.cpp       # 测试程序
├── Makefile
└── CMakeLists.txt
```

## 优化结果

| 类型 | 函数 | 维度 | Native (us) | NEON (us) | 加速比 |
|------|------|------|-------------|-----------|--------|
| **float32** | L2 距离 | 1024 | 0.44 | 0.11 | **4.07x** ✅ |
| half | L2 距离 | 1024 | 0.94 | 1.34 | 0.70x |
| bit | 汉明距离 | 1024 | 0.04 | 0.24 | 0.15x |

## 编译和运行

```bash
# 使用 Makefile
make

# 或使用 CMake
mkdir build && cd build
cmake .. && make
./test
```

## 实现说明

### float32 向量（已优化）
- 使用 NEON float32x4_t 向量寄存器
- 每次处理 4 个 float
- FMA 指令加速累加
- **加速比：4x**

### half 向量（待优化）
- 当前使用软件 half_to_float 转换
- 需要使用 ARM FP16 指令优化
- 暂时 NEON 版本更慢

### 位向量（待优化）
- 当前 NEON popcount 实现效率低
- 需要使用查表或其他优化方法
- 暂时 NEON 版本更慢

## 待优化项

1. half 向量：使用 ARM FP16/NEON half 指令
2. 位向量：优化 popcount 实现
3. 添加更多距离度量（余弦、内积等）

## 测试环境

- CPU: aarch64 (ARM64)
- OS: Linux
- 编译器: GCC 12.2.0
- NEON: 已启用
