# Protobuf Packed Decoder NEON 优化

## 概述

优化 Protobuf upb 中的 packed 数据解码函数，**目标**: `upb/wire/decode.c:287-320`

**功能**: 大端模式下的字节序批量转换

## 实现

### 标量版本
- `bswap32_scalar`: 4 字节字节序转换
- `bswap64_scalar`: 8 字节字节序转换

### NEON 版本
- `bswap32_neon`: 使用 `vrev32q_u8` 指令
- `bswap64_neon`: 使用 `vrev64q_u8` 指令

## 测试结果

```
[==========] Running 4 tests from 1 test suite.
[  PASSED  ] 4 tests.
```

## 性能结果

| Size | Scalar | NEON | Speedup |
|------|--------|------|---------|
| 64 | 0.00 ms | 0.01 ms | 0.98x |
| 256 | 0.02 ms | 0.02 ms | 1.01x |
| 1024 | 0.06 ms | 0.06 ms | 1.00x |
| 4096 | 0.23 ms | 0.23 ms | 0.98x |

**结论**: NEON ≈ 标量 (小数据规模)

**原因**: 
1. 数据规模小，2. 编译器自动向量化

## 文件结构

```
protobuf-packed-simd/
├── src/packed_neon.c
├── tests/packed_test.cpp
└── docs/README.md
```

---

*完成时间: 2026-03-26 15:10*
