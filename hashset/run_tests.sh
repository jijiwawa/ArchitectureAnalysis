#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

BUILD_DIR="$SCRIPT_DIR/build"

SCALE=${SCALE:-1000000}
RUNS=${RUNS:-3}
BASELINE_FILE=""
for arg in "$@"; do
    if [[ "$arg" == --scale=* ]]; then
        SCALE="${arg#--scale=}"
    elif [[ "$arg" == --baseline=* ]]; then
        BASELINE_FILE="${arg#--baseline=}"
    elif [[ "$arg" == --runs=* ]]; then
        RUNS="${arg#--runs=}"
    elif [[ "$arg" == --help || "$arg" == -h ]]; then
        echo "用法: $0 [--scale=<n>] [--runs=<n>] [--baseline=<file>|-]"
        echo "  --scale=<n>     数据规模，默认 1000000"
        echo "  --runs=<n>      每次测试重复次数，默认 3"
        echo "  --baseline=<f> 基线文件，'-' 表示从 stdin 读取"
        exit 0
    else
        echo "错误: 未知参数 '$arg'" >&2
        echo "使用 --help 查看用法" >&2
        exit 1
    fi
done

# 默认加载 base 基线（不传 --baseline 时使用）
if [[ -z "$BASELINE_FILE" ]]; then
    BASELINE_FILE="result/base_${SCALE}.json"
fi

# 加载基线 JSON 到关联数组
declare -A baseline
if [[ "$BASELINE_FILE" == "-" ]]; then
    # 从 stdin 读取
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            t=$(echo "$line" | grep -o '"threads":[0-9]*' | cut -d: -f2)
            d=$(echo "$line" | grep -o '"distribution":"[^"]*"' | cut -d'"' -f4)
            v=$(echo "$line" | grep -o '"contains_ops_sec":[0-9]*' | cut -d: -f2)
            if [[ -n "$t" && -n "$d" && -n "$v" ]]; then
                baseline["$t,$d"]=$v
            fi
        fi
    done
    echo "基线: <stdin> (${#baseline[@]} 条记录)"
elif [[ -n "$BASELINE_FILE" ]]; then
    if [[ -f "$BASELINE_FILE" ]]; then
        # 从文件读取
        while IFS= read -r line; do
            if [[ -n "$line" ]]; then
                t=$(echo "$line" | grep -o '"threads":[0-9]*' | cut -d: -f2)
                d=$(echo "$line" | grep -o '"distribution":"[^"]*"' | cut -d'"' -f4)
                v=$(echo "$line" | grep -o '"contains_ops_sec":[0-9]*' | cut -d: -f2)
                if [[ -n "$t" && -n "$d" && -n "$v" ]]; then
                    baseline["$t,$d"]=$v
                fi
            fi
        done < "$BASELINE_FILE"
        echo "基线: $BASELINE_FILE (${#baseline[@]} 条记录)"
    else
        echo "警告: 基线文件不存在: $BASELINE_FILE，将重新运行 base 测试对比" >&2
    fi
fi

START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "========================================"
echo "  HashSet 测试框架"
echo "========================================"
echo "Scale: $SCALE"
echo "Runs: $RUNS"
echo "开始时间: $START_TIME"
echo ""

# 创建 build 目录
echo "[1/4] 创建 build 目录..."
mkdir -p "$BUILD_DIR"
echo "      完成"
echo ""

# 编译测试程序
echo "[2/4] 编译测试程序..."
cd tests

echo "      编译 test_functional_opt..."
g++ -std=c++17 -O3 -march=native -mtune=native -pthread -I.. -DVERSION_optimize ../std/hash_set.cpp ../optimize/hash_set.cpp \
    test_functional.cpp -o "$BUILD_DIR/test_functional_opt"
echo "      完成"

echo "      编译 test_single_version_optimize..."
g++ -std=c++17 -O3 -march=native -mtune=native -pthread -I.. -DUSE_OPTIMIZE ../optimize/hash_set.cpp \
    test_single_version.cpp -o "$BUILD_DIR/test_single_version_optimize"
echo "      完成"

echo "      编译 test_performance (含 base 对比)..."
g++ -std=c++17 -O3 -march=native -mtune=native -pthread -I.. ../std/hash_set.cpp ../base/hash_set.cpp ../optimize/hash_set.cpp \
    test_performance.cpp -o "$BUILD_DIR/test_performance"
echo "      完成"

cd ..
echo ""

# 运行功能测试
echo "[3/4] 运行 optimize 功能测试..."
echo ""
if ! "$BUILD_DIR/test_functional_opt"; then
    echo ""
    echo "========================================"
    echo "  FAILED: 功能测试未通过"
    echo "========================================"
    exit 1
fi
echo ""

# 运行线程安全测试
echo "[4/4] 运行 optimize 线程安全测试..."
echo ""
if ! "$BUILD_DIR/test_single_version_optimize" 8 10000; then
    echo ""
    echo "========================================"
    echo "  FAILED: 线程安全测试未通过"
    echo "========================================"
    exit 1
fi
echo ""

# 性能对比（不阻塞退出码）
echo "========================================"
echo "  Base vs Optimize 性能对比"
echo "========================================"
printf "%-10s %-10s %-12s %-12s %-10s\n" "Threads" "Dist" "Base(M/s)" "Optimize(M/s)" "提升%"
echo "----------------------------------------"

mkdir -p result report
RESULT_FILE="result/optimize_${SCALE}.json"
> "$RESULT_FILE"  # 清空文件

declare -A dist_weighted_avg
total_weighted_avg=0
dist_count=0

for dist in uniform gaussian localized; do
    declare -A improvements
    all_valid=true

    for threads in 1 2 4 8 16 32; do
        key="${threads},${dist}"
        if [[ -n "${baseline[$key]}" ]]; then
            contains_base="${baseline[$key]}"
        else
            result_base=$("$BUILD_DIR/test_performance" --impl=base --threads=$threads --scale=$SCALE --distribution=$dist --runs=$RUNS 2>/dev/null | tail -1)
            echo "$result_base" >> "$BASELINE_FILE"
            contains_base=$(echo "$result_base" | grep -o '"contains_ops_sec":[0-9]*' | cut -d: -f2)
        fi

        result_opt=$("$BUILD_DIR/test_performance" --impl=optimize --threads=$threads --scale=$SCALE --distribution=$dist --runs=$RUNS 2>/dev/null | tail -1)
        echo "$result_opt" >> "$RESULT_FILE"
        contains_opt=$(echo "$result_opt" | grep -o '"contains_ops_sec":[0-9]*' | cut -d: -f2)

        if [ -n "$contains_base" ] && [ -n "$contains_opt" ] && [ "$contains_base" -gt 0 ]; then
            improvement=$(echo "scale=2; ($contains_opt - $contains_base) * 100 / $contains_base" | bc)
            base_mops=$(echo "scale=2; $contains_base / 1000000" | bc)
            opt_mops=$(echo "scale=2; $contains_opt / 1000000" | bc)
            printf "%-10s %-10s %-12s %-12s %-10s%%\n" "$threads" "$dist" "$base_mops" "$opt_mops" "$improvement"
            improvements[$threads]=$improvement
        else
            printf "%-10s %-10s %-12s %-12s %-10s%%\n" "$threads" "$dist" "N/A" "N/A" "N/A"
            all_valid=false
        fi
    done

    if $all_valid; then
        weighted_avg=$(awk -v i1="${improvements[1]}" -v i2="${improvements[2]}" \
            -v i4="${improvements[4]}" -v i8="${improvements[8]}" \
            -v i16="${improvements[16]}" -v i32="${improvements[32]}" \
            'BEGIN {
                w1=0.40; w=0.12
                printf "%.2f", w1*i1 + w*i2 + w*i4 + w*i8 + w*i16 + w*i32
            }')
        dist_weighted_avg[$dist]=$weighted_avg
        total_weighted_avg=$(echo "$total_weighted_avg + $weighted_avg" | bc)
        dist_count=$((dist_count + 1))
        echo "---- [$dist] 加权平均: ${weighted_avg}% ----"
    else
        dist_weighted_avg[$dist]="N/A"
    fi
    echo ""
done

overall_avg=$(echo "scale=2; $total_weighted_avg / $dist_count" | bc)
END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "----------------------------------------"
echo "总加权平均: ${overall_avg}%"
echo "结束时间: $END_TIME"
# 写入提升百分比到 JSON 文件
REPORT_FILE="report/result.json"
echo "[{\"x1\": 22, \"performance\": ${overall_avg}}]" > "$REPORT_FILE"
echo "结果已写入 $REPORT_FILE"
echo "========================================"
echo ""

echo "========================================"
echo "  PASSED: 所有测试通过!"
echo "========================================"
