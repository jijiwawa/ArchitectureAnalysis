#!/bin/bash
# SIMD Optimizer Skill 一键安装脚本
# 用法: curl -fsSL https://your-domain/install-simd-optimizer.sh | bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  SIMD Optimizer Skill 安装脚本${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 检测操作系统
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            echo "ubuntu"
        elif command -v yum &> /dev/null; then
            echo "centos"
        else
            echo "linux"
        fi
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
echo -e "${GREEN}[检测]${NC} 操作系统: $OS"

ARCH=$(uname -m)
echo -e "${GREEN}[检测]${NC} 架构: $ARCH"

if [[ "$ARCH" != "aarch64" && "$ARCH" != "arm64" ]]; then
    echo -e "${YELLOW}[警告]${NC} SIMD Optimizer 主要针对 ARM 架构优化"
fi

# 步骤 1: 安装依赖
echo ""
echo -e "${BLUE}[步骤 1/4]${NC} 安装系统依赖..."

run_as_root() {
    if command -v sudo &> /dev/null; then
        sudo "$@"
    elif [[ $EUID -eq 0 ]]; then
        "$@"
    else
        echo -e "${YELLOW}[跳过]${NC} 需要 root 权限，跳过: $*"
        return 1
    fi
}

install_dependencies() {
    case $OS in
        macos)
            if command -v brew &> /dev/null; then
                echo "  - 安装 cmake, gtest..."
                brew install cmake googletest 2>/dev/null || true
            fi
            ;;
        ubuntu|debian)
            echo "  - 安装 build-essential, cmake, libgtest-dev..."
            run_as_root apt-get update 2>/dev/null || true
            run_as_root apt-get install -y build-essential cmake libgtest-dev 2>/dev/null || {
                echo -e "${YELLOW}[提示]${NC} apt 安装失败，尝试检查现有依赖..."
            }
            # 检查 gtest 是否已安装
            if [[ -d /usr/src/gtest ]]; then
                echo "  - 编译 gtest 库..."
                cd /usr/src/gtest
                run_as_root cmake . 2>/dev/null && run_as_root make 2>/dev/null && run_as_root cp lib/*.a /usr/lib/ 2>/dev/null || true
                cd - > /dev/null
            fi
            ;;
        centos|rhel)
            run_as_root yum groupinstall -y "Development Tools" 2>/dev/null || true
            run_as_root yum install -y cmake gtest-devel 2>/dev/null || true
            ;;
    esac
    
    # 检查已有依赖
    echo ""
    echo "  依赖检查:"
    command -v gcc &> /dev/null && echo -e "    ${GREEN}✓${NC} gcc: $(gcc --version | head -1)" || echo -e "    ${RED}✗${NC} gcc 未安装"
    command -v cmake &> /dev/null && echo -e "    ${GREEN}✓${NC} cmake: $(cmake --version | head -1)" || echo -e "    ${YELLOW}△${NC} cmake 未安装"
    [[ -f /usr/include/gtest/gtest.h ]] && echo -e "    ${GREEN}✓${NC} gtest 已安装" || echo -e "    ${YELLOW}△${NC} gtest 未安装"
}

install_dependencies

# 步骤 2: 检查 OpenClaw
echo ""
echo -e "${BLUE}[步骤 2/4]${NC} 检查 OpenClaw..."

if command -v openclaw &> /dev/null; then
    OPENCLAW_VERSION=$(openclaw --version 2>/dev/null | head -1 || echo "unknown")
    echo -e "${GREEN}[OK]${NC} OpenClaw: $OPENCLAW_VERSION"
else
    echo -e "${YELLOW}[提示]${NC} 未检测到 OpenClaw CLI"
    echo "       如果已安装，请确保 openclaw 在 PATH 中"
fi

# 步骤 3: 安装 SIMD Optimizer Skill
echo ""
echo -e "${BLUE}[步骤 3/4]${NC} 安装 SIMD Optimizer Skill..."

SKILL_DIR="$HOME/.openclaw/skills/simd-optimizer"
mkdir -p "$SKILL_DIR/assets"
mkdir -p "$SKILL_DIR/references"

# SKILL.md
echo "  - 创建 SKILL.md..."
cat > "$SKILL_DIR/SKILL.md" << 'SKILL_EOF'
---
name: simd-optimizer
description: SIMD 优化开发工作流。用于将 C/C++ 原生代码优化为 NEON/SVE/SVE2 SIMD 版本。触发场景：(1) 用户要求进行 SIMD 优化 (2) 将代码从 x86 移植到 ARM (3) 需要对比原生和 SIMD 版本的性能 (4) 使用 gtest 测试 SIMD 实现。
---

# SIMD Optimizer Skill

将 C/C++ 原生代码优化为 ARM NEON/SVE/SVE2 SIMD 版本。

## 工作流程

### 阶段 1: 识别待优化接口
- 扫描计算密集型函数（循环、向量操作、字符串处理）
- 提取函数签名和算法逻辑
- 评估优化价值

### 阶段 2: 实现 SIMD 版本
- 选择指令集：NEON / SVE / SVE2
- 参考模式：[references/neon-patterns.md](references/neon-patterns.md)

```c
#ifdef __ARM_NEON
#include <arm_neon.h>
void func_neon(const float* a, const float* b, float* c, int n) {
    int i = 0;
    for (; i + 4 <= n; i += 4) {
        vst1q_f32(c + i, vaddq_f32(vld1q_f32(a + i), vld1q_f32(b + i)));
    }
    for (; i < n; i++) c[i] = a[i] + b[i];
}
#endif
```

### 阶段 3-4: 测试与验证
- 模板：[assets/gtest_template.cpp](assets/gtest_template.cpp)
- 基准：[assets/benchmark_template.cpp](assets/benchmark_template.cpp)

## 输出物
1. `func_neon.c/h` - SIMD 实现
2. `func_test.cpp` - GTest 测试
3. `simd_optimization_report.md` - 优化报告
SKILL_EOF

# NEON 模式
echo "  - 创建 NEON 模式参考..."
cat > "$SKILL_DIR/references/neon-patterns.md" << 'PATTERNS_EOF'
# NEON/SVE 优化模式

## 数据类型
- `float32x4_t` - 4 个 float (NEON)
- `int32x4_t` - 4 个 int32
- `uint8x16_t` - 16 个 uint8
- `svfloat32_t` - float 向量 (SVE)

## 常用模式

### 向量加法
```c
for (int i = 0; i + 4 <= n; i += 4) {
    vst1q_f32(c + i, vaddq_f32(vld1q_f32(a + i), vld1q_f32(b + i)));
}
```

### 点积
```c
float32x4_t vsum = vdupq_n_f32(0);
for (int i = 0; i + 4 <= n; i += 4) {
    vsum = vmlaq_f32(vsum, vld1q_f32(a + i), vld1q_f32(b + i));
}
return vaddvq_f32(vsum);
```

### L2 距离
```c
float32x4_t vdist = vdupq_n_f32(0);
for (int i = 0; i + 4 <= n; i += 4) {
    float32x4_t d = vsubq_f32(vld1q_f32(a + i), vld1q_f32(b + i));
    vdist = vmlaq_f32(vdist, d, d);
}
return vaddvq_f32(vdist);
```

### 最大值
```c
float32x4_t vmax = vld1q_f32(a);
for (int i = 4; i < n; i += 4) {
    vmax = vmaxq_f32(vmax, vld1q_f32(a + i));
}
return vmaxvq_f32(vmax);
```
PATTERNS_EOF

# GTest 模板
echo "  - 创建 GTest 模板..."
cat > "$SKILL_DIR/assets/gtest_template.cpp" << 'GTEST_EOF'
#include <gtest/gtest.h>
#include <cmath>
#include <vector>

extern "C" {
    void func_native(const float* a, const float* b, float* c, int n);
    void func_neon(const float* a, const float* b, float* c, int n);
}

class SIMDTest : public ::testing::Test {
protected:
    bool float_equal(float a, float b, float eps = 1e-6f) {
        return std::fabs(a - b) < eps;
    }
};

TEST_F(SIMDTest, Empty) {
    func_native(nullptr, nullptr, nullptr, 0);
    func_neon(nullptr, nullptr, nullptr, 0);
}

TEST_F(SIMDTest, BoundaryLengths) {
    for (int n : {1, 4, 8, 16, 32, 64, 128, 255}) {
        std::vector<float> a(n, 1.5f), b(n, 2.5f), exp(n), act(n);
        func_native(a.data(), b.data(), exp.data(), n);
        func_neon(a.data(), b.data(), act.data(), n);
        for (int i = 0; i < n; i++) {
            EXPECT_TRUE(float_equal(exp[i], act[i])) << "n=" << n << " i=" << i;
        }
    }
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
GTEST_EOF

# 基准模板
echo "  - 创建基准测试模板..."
cat > "$SKILL_DIR/assets/benchmark_template.cpp" << 'BENCH_EOF'
#include <chrono>
#include <iostream>
#include <vector>
#include <iomanip>

extern "C" {
    void func_native(const float* a, const float* b, float* c, int n);
    void func_neon(const float* a, const float* b, float* c, int n);
}

double bench(auto f, const float* a, const float* b, float* c, int n, int iters) {
    for (int i = 0; i < 10; i++) f(a, b, c, n);
    auto t0 = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iters; i++) f(a, b, c, n);
    auto t1 = std::chrono::high_resolution_clock::now();
    return std::chrono::duration<double, std::milli>(t1 - t0).count() / iters;
}

int main() {
    std::cout << "| Size | Native (ms) | NEON (ms) | Speedup |\n";
    std::cout << "|------|-------------|-----------|---------|\n";
    for (int n : {64, 256, 1024, 4096}) {
        std::vector<float> a(n, 1.5f), b(n, 2.5f), c(n);
        double t1 = bench(func_native, a.data(), b.data(), c.data(), n, 1000);
        double t2 = bench(func_neon, a.data(), b.data(), c.data(), n, 1000);
        std::cout << "| " << std::setw(4) << n 
                  << " | " << std::setw(11) << std::fixed << std::setprecision(3) << t1
                  << " | " << std::setw(9) << t2
                  << " | " << std::setw(7) << std::setprecision(2) << t1/t2 << "x |\n";
    }
}
BENCH_EOF

echo -e "${GREEN}[OK]${NC} Skill 已安装到: $SKILL_DIR"

# 步骤 4: 验证
echo ""
echo -e "${BLUE}[步骤 4/4]${NC} 验证安装..."

if [[ -f "$SKILL_DIR/SKILL.md" ]]; then
    echo -e "${GREEN}✓${NC} SKILL.md"
    echo -e "${GREEN}✓${NC} references/neon-patterns.md"
    echo -e "${GREEN}✓${NC} assets/gtest_template.cpp"
    echo -e "${GREEN}✓${NC} assets/benchmark_template.cpp"
else
    echo -e "${RED}[错误]${NC} 安装失败"
    exit 1
fi

# 完成
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  安装完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "使用方法:"
echo "  在 OpenClaw 中说:"
echo "    '用 NEON 优化这个循环'"
echo "    '帮我做 SIMD 优化'"
echo ""
echo "文件位置:"
echo "  $SKILL_DIR/"
echo ""
