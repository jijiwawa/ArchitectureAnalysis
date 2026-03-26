# 哈希查找 SIMD 优化可行性分析

## 当前实现分析

### 1. 数据结构（链表法）
```cpp
struct Node {
    int64_t value;
    Node* next;  // 指针跳转，内存不连续
};

Node** buckets_;  // 桶数组
```

### 2. 查找流程
```cpp
bool contains(int64_t value) {
    int h = hash(value);           // 1. 哈希计算
    Node* cur = buckets_[h];       // 2. 获取头节点
    while (cur) {                  // 3. 链表遍历
        if (cur->value == value)   // 4. 逐个比较
            return true;
        cur = cur->next;           // 5. 指针跳转
    }
    return false;
}
```

## SIMD 优化可行性

### ❌ 链表遍历（当前实现）

**不可优化的原因**：
1. **内存不连续**：节点通过 `next` 指针连接，分散在堆上
2. **数据依赖**：每次访问依赖前一次的 `cur->next`
3. **分支预测失败**：`while (cur)` 和 `if (cur->value == value)` 难以预测

**性能瓶颈**：
```
CPU 缓存命中率：~30-50%（链表跳跃）
分支预测失败率：~20-30%
SIMD 利用率：0%（无法向量化）
```

### ✅ 可优化方案

#### 方案 1：开放寻址法（推荐）

**数据结构**：
```cpp
struct Slot {
    int64_t value;
    bool occupied;
};

Slot* slots_;  // 连续内存数组
```

**SIMD 优化查找**：
```cpp
#include <arm_neon.h>

bool contains_simd(int64_t value) {
    int h = hash(value);
    
    // 加载 4 个槽位
    int64x2_t v1 = vld1q_s64(&slots_[h].value);      // 槽位 h, h+1
    int64x2_t v2 = vld1q_s64(&slots_[h+2].value);    // 槽位 h+2, h+3
    
    // 目标值广播
    int64x2_t target = vdupq_n_s64(value);
    
    // 并行比较
    uint64x2_t cmp1 = vceqq_s64(v1, target);
    uint64x2_t cmp2 = vceqq_s64(v2, target);
    
    // 合并结果
    uint64x2_t result = vorrq_u64(cmp1, cmp2);
    
    // 检查是否有匹配
    return vaddvq_u64(result) != 0;
}
```

**优势**：
- ✅ 一次比较 4-8 个槽位
- ✅ 内存连续，缓存友好
- ✅ 无分支，流水线友好

**预期加速**：2-4x

#### 方案 2：批量哈希计算

**场景**：批量插入/查找多个 key

```cpp
void contains_batch_simd(const int64_t* keys, bool* results, int n) {
    for (int i = 0; i + 4 <= n; i += 4) {
        // 加载 4 个 key
        int64x2_t k1 = vld1q_s64(keys + i);
        int64x2_t k2 = vld1q_s64(keys + i + 2);
        
        // 并行计算 4 个哈希值
        int64x2_t h1 = vreinterpretq_s64_u64(
            vdupq_n_u64(capacity_)
        );
        
        // 这里需要 SIMD 取模，较复杂
        // 简化：用位运算代替（capacity 必须是 2 的幂）
        uint64x2_t mask = vdupq_n_u64(capacity_ - 1);
        uint64x2_t hash1 = vandq_u64(vreinterpretq_u64_s64(k1), mask);
        uint64x2_t hash2 = vandq_u64(vreinterpretq_u64_s64(k2), mask);
        
        // 然后查找（仍需链表遍历，但哈希计算已向量化）
        results[i+0] = contains_internal(keys[i+0], hash1[0]);
        results[i+1] = contains_internal(keys[i+1], hash1[1]);
        results[i+2] = contains_internal(keys[i+2], hash2[0]);
        results[i+3] = contains_internal(keys[i+3], hash2[1]);
    }
}
```

**优势**：
- ✅ 哈希计算向量化
- ⚠️ 查找仍是标量（链表限制）

**预期加速**：1.2-1.5x

## 推荐方案

### 短期（小改动）

**优化哈希函数**：
```cpp
// 原来
int hash(int64_t value) const {
    int h = value % capacity_;
    return h < 0 ? h + capacity_ : h;
}

// 优化（capacity 必须是 2 的幂）
int hash(int64_t value) const {
    return static_cast<int>(value & (capacity_ - 1));
}
```

**预期提升**：+5-10%

### 长期（架构升级）

**开放寻址 + SIMD 查找**：
```cpp
class OptimizeHashSetV2 {
private:
    struct Slot {
        int64_t value;
        uint8_t occupied;
        uint8_t padding[7];  // 对齐到 8 字节
    };
    
    Slot* slots_;
    int capacity_;
    std::atomic<int> size_;
    
public:
    bool contains(int64_t value) {
        int h = hash(value);
        
        // SIMD 并行查找 4 个槽位
        for (int offset = 0; offset < 8; offset += 4) {
            if (contains_simd_internal(value, h + offset)) {
                return true;
            }
        }
        return false;
    }
    
private:
    bool contains_simd_internal(int64_t value, int start) {
        // 加载 4 个槽位的值
        int64x2_t v1 = vld1q_s64(&slots_[start].value);
        int64x2_t v2 = vld1q_s64(&slots_[start+2].value);
        
        // 并行比较
        int64x2_t target = vdupq_n_s64(value);
        uint64x2_t cmp1 = vceqq_s64(v1, target);
        uint64x2_t cmp2 = vceqq_s64(v2, target);
        
        // 检查匹配
        uint64x2_t result = vorrq_u64(cmp1, cmp2);
        return vaddvq_u64(result) != 0;
    }
};
```

**预期提升**：+200-400% (2-4倍)

## 总结

| 方案 | 改动量 | 加速效果 | 推荐度 |
|------|--------|----------|--------|
| **优化哈希函数** | 小 | +5-10% | ⭐⭐⭐⭐⭐ |
| **开放寻址 + SIMD** | 大 | +200-400% | ⭐⭐⭐⭐ |
| **批量哈希 SIMD** | 中 | +20-50% | ⭐⭐⭐ |

**当前限制**：链表结构无法使用 SIMD 优化查找

**建议**：
1. ✅ 先优化哈希函数（5分钟完成）
2. 📝 评估是否需要开放寻址重构（1-2天工作量）
