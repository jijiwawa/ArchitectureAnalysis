#!/bin/bash

# Usage: ./run_version_test.sh <version_dir> <test_name>
# Example: ./run_version_test.sh std test_lockfree_vs_locked

if [ $# -ne 2 ]; then
    echo "Usage: $0 <version_dir> <test_name>"
    echo "Example: $0 std test_lockfree_vs_locked"
    exit 1
fi

VERSION_DIR=$1
TEST_NAME=$2
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 根据版本目录确定头文件
case "$VERSION_DIR" in
    std)
        HEADER_FILE="$PROJECT_ROOT/std/hash_set.h"
        IMPL_FILE="$PROJECT_ROOT/std/hash_set.cpp"
        CLASS_NAME="StdHashSet"
        ;;
    base)
        HEADER_FILE="$PROJECT_ROOT/base/hash_set.h"
        IMPL_FILE="$PROJECT_ROOT/base/hash_set.cpp"
        CLASS_NAME="BaseHashSet"
        ;;
    crash)
        HEADER_FILE="$PROJECT_ROOT/crash/hash_set.h"
        IMPL_FILE="$PROJECT_ROOT/crash/hash_set.cpp"
        CLASS_NAME="CrashHashSet"
        ;;
    optimize)
        HEADER_FILE="$PROJECT_ROOT/optimize/hash_set.h"
        IMPL_FILE="$PROJECT_ROOT/optimize/hash_set.cpp"
        CLASS_NAME="OptimizeHashSet"
        ;;
    *)
        echo "Unknown version: $VERSION_DIR"
        echo "Available: std, base, crash, optimize"
        exit 1
        ;;
esac

# 创建临时测试文件
TEMP_TEST="/tmp/test_${VERSION_DIR}_${TEST_NAME}.cpp"
cat > "$TEMP_TEST" << 'TEMPLATE'
#include <thread>
#include <vector>
#include <iostream>
#include <random>
#include <cstdlib>
#include "HEADER_FILE"
#include "COMMON_DIR/i_hash_set.h"

template<typename HashSetType>
void runTest(const std::string& name, int threadCount, int opsPerThread) {
    std::cout << "\n=== Testing " << name << " ===" << std::endl;

    HashSetType set;
    set.init();

    std::vector<std::thread> threads;

    for (int t = 0; t < threadCount; ++t) {
        threads.emplace_back([&, t]() {
            std::mt19937 rng(t * 12345);
            std::uniform_int_distribution<int> dist(0, opsPerThread * 2);

            for (int i = 0; i < opsPerThread; ++i) {
                int val = dist(rng);
                set.insert(val);
                set.contains(val);
                set.remove(val);
                set.size();
            }
        });
    }

    for (auto& t : threads) {
        t.join();
    }

    std::cout << name << " completed without crash, final size=" << set.size() << std::endl;
}

int main(int argc, char* argv[]) {
    int threadCount = 32;
    int opsPerThread = 10000;

    if (argc >= 3) {
        threadCount = atoi(argv[1]);
        opsPerThread = atoi(argv[2]);
    }

    std::cout << "========================================" << std::endl;
    std::cout << "  Thread Safety Test" << std::endl;
    std::cout << "  Threads: " << threadCount << ", Ops/Thread: " << opsPerThread << std::endl;
    std::cout << "========================================" << std::endl;

    runTest<CLASS_NAME>("CLASS_NAME", threadCount, opsPerThread);

    return 0;
}
TEMPLATE

# 替换占位符
sed -i "s|HEADER_FILE|$HEADER_FILE|g" "$TEMP_TEST"
sed -i "s|COMMON_DIR|$PROJECT_ROOT/common|g" "$TEMP_TEST"
sed -i "s|CLASS_NAME|$CLASS_NAME|g" "$TEMP_TEST"

OUTPUT="$PROJECT_ROOT/test_${VERSION_DIR}_${TEST_NAME}"

echo "========================================"
echo "  Testing $VERSION_DIR ($CLASS_NAME) with $TEST_NAME"
echo "========================================"

# 编译 (optimize 需要 C++17 和 numa)
if [ "$VERSION_DIR" = "optimize" ]; then
    g++ -std=c++17 -O2 -pthread -I"$PROJECT_ROOT" "$TEMP_TEST" "$IMPL_FILE" -lnuma -o "$OUTPUT" 2>&1
else
    g++ -std=c++17 -O2 -pthread -I"$PROJECT_ROOT" "$TEMP_TEST" "$IMPL_FILE" -o "$OUTPUT" 2>&1
fi

if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    rm -f "$TEMP_TEST"
    exit 1
fi

# 运行
echo "Running..."
"$OUTPUT"
RESULT=$?

rm -f "$TEMP_TEST"

echo ""
if [ $RESULT -eq 0 ]; then
    echo "Test PASSED (exit code: $RESULT)"
else
    echo "Test FAILED or CRASHED (exit code: $RESULT)"
fi

exit $RESULT
