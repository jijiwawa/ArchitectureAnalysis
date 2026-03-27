#!/bin/bash
#
# kunpeng-perf-analyzer - 热点数据采集脚本
# 用于鲲鹏CPU性能分析
#

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 默认参数
DURATION=30
PID=""
OUTPUT_DIR="./perf_data"
KERNEL_SYMBOLS=0
HARDWARE_COUNTERS=0

usage() {
    cat << EOF
用法: $0 [选项]

选项:
    -p <pid>        目标进程PID（必需）
    -d <seconds>    采集时长，默认30秒
    -o <dir>        输出目录，默认 ./perf_data
    -k              采集内核符号
    -H              采集硬件计数器
    -h              显示帮助信息

示例:
    $0 -p 12345 -d 60 -o ./my_perf_data -H
    $0 -p $(pgrep myapp) -d 30
EOF
    exit 1
}

# 解析参数
while getopts "p:d:o:kHh" opt; do
    case $opt in
        p) PID=$OPTARG ;;
        d) DURATION=$OPTARG ;;
        o) OUTPUT_DIR=$OPTARG ;;
        k) KERNEL_SYMBOLS=1 ;;
        H) HARDWARE_COUNTERS=1 ;;
        h) usage ;;
        *) usage ;;
    esac
done

# 检查必需参数
if [ -z "$PID" ]; then
    echo -e "${RED}错误: 必须指定目标进程PID${NC}"
    usage
fi

# 检查进程是否存在
if ! kill -0 $PID 2>/dev/null; then
    echo -e "${RED}错误: 进程 $PID 不存在${NC}"
    exit 1
fi

# 检查 perf 是否可用
if ! command -v perf &> /dev/null; then
    echo -e "${RED}错误: perf 命令未找到，请安装 linux-tools${NC}"
    exit 1
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULT_FILE="$OUTPUT_DIR/perf_report_${TIMESTAMP}.txt"
DATA_FILE="$OUTPUT_DIR/perf_data_${TIMESTAMP}.data"

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}  鲲鹏 CPU 性能分析 - 热点采集${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo -e "目标PID:      ${YELLOW}$PID${NC}"
echo -e "进程名:       ${YELLOW}$(cat /proc/$PID/comm 2>/dev/null || echo 'N/A')${NC}"
echo -e "采集时长:     ${YELLOW}${DURATION}秒${NC}"
echo -e "输出目录:     ${YELLOW}$OUTPUT_DIR${NC}"
echo -e "硬件计数器:   ${YELLOW}$([ $HARDWARE_COUNTERS -eq 1 ] && echo '是' || echo '否')${NC}"
echo ""

# 构建采集命令
if [ $HARDWARE_COUNTERS -eq 1 ]; then
    PERF_EVENT="-e cycles,instructions,cache-misses,cache-references,branch-misses,branches"
else
    PERF_EVENT=""
fi

echo -e "${GREEN}[1/4] 开始采集性能数据...${NC}"

# 执行 perf 采集
perf record $PERF_EVENT -g -p $PID -o "$DATA_FILE" -- sleep $DURATION 2>/dev/null

if [ $? -ne 0 ]; then
    echo -e "${RED}错误: perf 采集失败${NC}"
    exit 1
fi

echo -e "${GREEN}[2/4] 生成文本报告...${NC}"

# 生成报告
{
    echo "========================================"
    echo "  鲲鹏 CPU 性能分析报告"
    echo "  时间: $(date)"
    echo "  目标PID: $PID"
    echo "  进程名: $(cat /proc/$PID/comm 2>/dev/null || echo 'N/A')"
    echo "  采集时长: ${DURATION}秒"
    echo "========================================"
    echo ""
    echo "=== 热点函数 Top 20 ==="
    echo ""
    perf report --stdio -i "$DATA_FILE" --sort symbol --percent-limit 0.5 2>/dev/null | head -80

    echo ""
    echo "=== 调用链分析 ==="
    echo ""
    perf report --stdio -i "$DATA_FILE" -g graph,0.5,caller 2>/dev/null | head -100

    if [ $HARDWARE_COUNTERS -eq 1 ]; then
        echo ""
        echo "=== 硬件计数器统计 ==="
        echo ""
        perf stat -p $PID -- sleep 5 2>&1 || true
    fi

} > "$RESULT_FILE"

echo -e "${GREEN}[3/4] 生成火焰图数据...${NC}"

# 生成火焰图数据
FLAMEGRAPH_DATA="$OUTPUT_DIR/flamegraph_${TIMESTAMP}.svg"
if command -v stackcollapse-perf.pl &> /dev/null && command -v flamegraph.pl &> /dev/null; then
    perf script -i "$DATA_FILE" | stackcollapse-perf.pl | flamegraph.pl > "$FLAMEGRAPH_DATA"
    echo -e "火焰图已保存: ${YELLOW}$FLAMEGRAPH_DATA${NC}"
else
    echo -e "${YELLOW}提示: 未安装 FlameGraph 工具，跳过火焰图生成${NC}"
    echo -e "${YELLOW}安装方法: git clone https://github.com/brendangregg/FlameGraph${NC}"
fi

echo -e "${GREEN}[4/4] 分析完成${NC}"
echo ""
echo -e "报告文件:     ${GREEN}$RESULT_FILE${NC}"
echo -e "原始数据:     ${GREEN}$DATA_FILE${NC}"
echo ""

# 显示 Top 5 热点
echo -e "${GREEN}=== 热点函数 Top 5 ===${NC}"
perf report --stdio -i "$DATA_FILE" --sort symbol --percent-limit 1 2>/dev/null | grep -A 20 "Overhead" | head -25

echo ""
echo -e "${GREEN}提示: 使用 'perf report -i $DATA_FILE' 查看详细报告${NC}"
