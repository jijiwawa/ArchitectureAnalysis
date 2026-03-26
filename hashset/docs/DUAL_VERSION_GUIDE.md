# Hashset 双版本使用指南

## 版本说明

为满足不同场景需求，提供两个优化版本：

### 1. 单线程版本（`hash_set_single.h`）

**适用场景**：
- 1-2 线程
- 低并发场景
- 数据规模小（< 10万）

**特点**：
- ✅ 链表实现，单线程性能最优
- ✅ 内存占用低
- ✅ 实现简单稳定

**性能**：
- 单线程：基准性能
- 多线程：性能下降

### 2. 多线程版本（`hash_set.h`）

**适用场景**：
- 4 线程及以上
- 高并发场景
- 数据规模大（> 10万）

**特点**：
- ✅ 连续内存（std::vector）
- ✅ 哈希指纹快速比较
- ✅ 分段锁优化

**性能**：
- 4线程: **+20% 到 +87%**
- 8线程: **+104% 到 +223%**
- 16线程: **+203% 到 +319%**
- 32线程: **+206% 到 +379%**
- 单线程: **-82% 到 -85%**（不推荐）

## 使用方法

### 单线程场景

```cpp
#include "optimize/hash_set_single.h"

int main() {
    OptimizeHashSetSingle set;
    set.init();
    
    // 单线程操作
    for (int i = 0; i < 100000; i++) {
        set.insert(i);
    }
    
    for (int i = 0; i < 100000; i++) {
        bool found = set.contains(i);
    }
    
    return 0;
}
```

### 多线程场景（4线程以上）

```cpp
#include "optimize/hash_set.h"

int main() {
    OptimizeHashSet set;
    set.init();
    
    // 多线程操作
    #pragma omp parallel for num_threads(8)
    for (int i = 0; i < 1000000; i++) {
        set.insert(i);
        set.contains(i);
    }
    
    return 0;
}
```

## 性能对比

| 线程数 | 单线程版本 | 多线程版本 | 推荐 |
|--------|-----------|-----------|------|
| **1线程** | 基准 | -82 到 -85% | 单线程版本 ⭐⭐⭐⭐⭐ |
| **2线程** | 基准 | -10 到 -43% | 单线程版本 ⭐⭐⭐⭐ |
| **4线程** | 基准 | +20 到 +87% | 多线程版本 ⭐⭐⭐⭐⭐ |
| **8线程** | 下降 | +104 到 +223% | 多线程版本 ⭐⭐⭐⭐⭐ |
| **16线程** | 下降 | +203 到 +319% | 多线程版本 ⭐⭐⭐⭐⭐ |
| **32线程** | 下降 | +206 到 +379% | 多线程版本 ⭐⭐⭐⭐⭐ |

## 编译选项

### 单线程版本

```bash
g++ -std=c++17 -O3 -march=native -pthread -I. \
  optimize/hash_set_single.cpp \
  your_program.cpp \
  -o your_program
```

### 多线程版本

```bash
g++ -std=c++17 -O3 -march=native -pthread -I. \
  optimize/hash_set.cpp \
  your_program.cpp \
  -o your_program
```

## 决策建议

### 线程数判断

```cpp
// 运行时选择版本（推荐手动选择）
int thread_count = std::thread::hardware_concurrency();

if (thread_count <= 2) {
    // 使用单线程版本
    OptimizeHashSetSingle set;
} else {
    // 使用多线程版本
    OptimizeHashSet set;
}
```

### 数据规模判断

```cpp
int data_size = 1000000;

if (data_size < 100000 && thread_count <= 2) {
    // 单线程版本
} else {
    // 多线程版本
}
```

## 注意事项

### 1. API 兼容性
两个版本 API 完全兼容，可无缝切换。

### 2. 线程安全
- **单线程版本**：提供基本的线程安全（单锁）
- **多线程版本**：分段锁，高并发性能优秀

### 3. 内存占用
- **单线程版本**：每个节点单独分配
- **多线程版本**：连续内存，缓存友好

## 总结

| 场景 | 推荐版本 | 原因 |
|------|---------|------|
| 1-2线程 | 单线程版本 | 性能最优 |
| 4线程+ | 多线程版本 | 性能提升 20-379% |
| 小数据（<10万） | 单线程版本 | 开销小 |
| 大数据（>10万） | 多线程版本 | 缓存友好 |

---

**建议**：根据实际场景选择合适的版本，获得最优性能！

*更新时间: 2026-03-26 21:54*
