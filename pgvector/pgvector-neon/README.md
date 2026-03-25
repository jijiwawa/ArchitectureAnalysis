# pgvector-neon

pgvector NEON/SVE SIMD 优化实现

## 项目结构

```
pgvector-neon/
├── include/
│   ├── half_types.h          # half 精度类型定义
│   ├── half_distance.h       # half 精度距离函数
│   ├── bit_distance.h        # 位向量距离函数
│   └── vector_distance.h     # 单精度向量距离函数
├── src/
│   ├── half_distance_native.c   # half 原生实现
│   ├── half_distance_neon.c     # half NEON 实现
│   ├── bit_distance_native.c    # bit 原生实现
│   ├── bit_distance_neon.c      # bit NEON 实现
│   ├── vector_distance_native.c # vector 原生实现
│   └── vector_distance_neon.c   # vector NEON 实现
├── tests/
│   ├── test_all.cpp          # GTest 测试
│   └── benchmark.cpp         # 性能基准测试
├── CMakeLists.txt
└── README.md
```

## 优化接口

### 1. Half Precision (float16)
| 函数 | 描述 |
|------|------|
| `halfvec_l2_squared_distance` | L2 距离平方 |
| `halfvec_inner_product` | 内积 |
| `halfvec_cosine_similarity` | 余弦相似度 |
| `halfvec_l1_distance` | L1 距离 |

### 2. Bit Vector
| 函数 | 描述 |
|------|------|
| `bit_hamming_distance` | 汉明距离 |
| `bit_jaccard_distance` | Jaccard 距离 |

### 3. Float32 Vector
| 函数 | 描述 |
|------|------|
| `vector_l2_squared_distance` | L2 距离平方 |
| `vector_inner_product` | 内积 |
| `vector_cosine_similarity` | 余弦相似度 |
| `vector_l1_distance` | L1 距离 |

## 编译

### 编译测试
```bash
mkdir build && cd build
cmake ..
make
```

### 运行测试
```bash
./test_all
```

### 运行性能测试
```bash
./benchmark
```

## 依赖

- CMake 3.10+
- GCC/Clang with ARM NEON support
- Google Test (for testing)

## 注意

- NEON 代码仅在 ARM 平台上生效
- x86 平台编译通过但使用原生实现
- 需要在 ARM 设备上运行性能测试
