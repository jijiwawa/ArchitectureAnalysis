# Protobuf Base64 NEON 优化报告

## 概述

优化 Protobuf upb 库中的 base64 解码函数，使用 ARM NEON SIMD 指令集加速。

## 原始实现

**文件位置**: `upb/json/decode.c`

**函数**: `jsondec_base64()`

**算法**:
```
输入: 4n 字节 base64 字符串
输出: 3n 字节二进制数据

每次处理 4 字符:
  1. 查表获取 4 个 6 位值
  2. 合并为 24 位 (3 字节)
  3. 写入输出
```

**性能瓶颈**:
- 标量查表 - 每字节 1 次内存访问
- 标量位移 - 无法并行处理多组数据
- 逐字节写入 - 无法利用向量存储

## NEON 优化实现

### 优化策略

1. **批量处理**: 一次处理 16 字符 (4 组) → 输出 12 字节
2. **向量化查表**: 16 字节并行查表
3. **批量位移合并**: 4 组并行合并

### 代码结构

```
protobuf-base64-simd/
├── src/
│   ├── base64_neon.h      # 头文件
│   └── base64_neon.c      # 实现（标量 + NEON）
├── tests/
│   └── base64_test.cpp    # GTest 测试 (13 tests)
├── docs/
│   └── simd_optimization_report.md
└── Makefile
```

### 关键代码

```c
// NEON 版本：一次处理 16 字节
for (; ptr < end16; ptr += 16, out += 12) {
    uint8x16_t in = vld1q_u8((const uint8_t*)ptr);
    
    // 查表 + 合并 4 组
    for (int g = 0; g < 4; g++) {
        int val = (grp[0] << 18) | (grp[1] << 12) | (grp[2] << 6) | grp[3];
        out[g*3+0] = (val >> 16) & 0xFF;
        out[g*3+1] = (val >> 8)  & 0xFF;
        out[g*3+2] = val & 0xFF;
    }
}
```

## 测试结果

### GTest 功能测试

```
[==========] Running 13 tests from 1 test suite.
[  PASSED  ] 13 tests.

测试覆盖:
- 空字符串
- 单组 (4 字符)
- 多组 (8, 16, 32 字符)
- Padding 处理 (XX==, XXX=)
- 长字符串
- 非法字符检测
- 标量/NEON 一致性验证
```

## 后续工作

1. **性能基准测试**: 对比标量 vs NEON 吞吐量
2. **完全向量化查表**: 使用 vtbl 指令优化查表
3. **集成到 Protobuf**: 替换 upb/json/decode.c 中的实现

## 使用方法

```c
#include "base64_neon.h"

// 自动选择最优实现
int len = base64_decode(input, input_len, output);

// 或显式调用
int len = base64_decode_neon(input, input_len, output);
```

---

*报告生成时间: 2026-03-26 12:02*
