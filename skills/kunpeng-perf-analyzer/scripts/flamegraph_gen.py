#!/usr/bin/env python3
"""
火焰图生成器
用于从 perf 数据生成火焰图
"""

import subprocess
import sys
import os
import argparse
from pathlib import Path


def check_flamegraph_tools():
    """检查 FlameGraph 工具是否可用"""
    tools = ['stackcollapse-perf.pl', 'flamegraph.pl']
    for tool in tools:
        try:
            subprocess.run(['which', tool], check=True, capture_output=True)
        except subprocess.CalledProcessError:
            return False
    return True


def generate_flamegraph(perf_data: str, output: str, title: str = "Flame Graph"):
    """
    从 perf.data 生成火焰图

    Args:
        perf_data: perf.data 文件路径
        output: 输出 SVG 文件路径
        title: 火焰图标题
    """
    if not os.path.exists(perf_data):
        print(f"错误: 文件 {perf_data} 不存在")
        sys.exit(1)

    if not check_flamegraph_tools():
        print("错误: FlameGraph 工具未安装")
        print("安装方法: git clone https://github.com/brendangregg/FlameGraph")
        sys.exit(1)

    # 步骤1: perf script
    print("[1/3] 运行 perf script...")
    try:
        perf_script = subprocess.run(
            ['perf', 'script', '-i', perf_data],
            capture_output=True,
            text=True,
            check=True
        )
    except subprocess.CalledProcessError as e:
        print(f"错误: perf script 失败: {e}")
        sys.exit(1)

    # 步骤2: stackcollapse
    print("[2/3] 处理调用栈...")
    try:
        collapse = subprocess.run(
            ['stackcollapse-perf.pl'],
            input=perf_script.stdout,
            capture_output=True,
            text=True,
            check=True
        )
    except subprocess.CalledProcessError as e:
        print(f"错误: stackcollapse-perf.pl 失败: {e}")
        sys.exit(1)

    # 步骤3: flamegraph
    print("[3/3] 生成火焰图...")
    try:
        flame = subprocess.run(
            ['flamegraph.pl', '--title', title, '--colors', 'aqua'],
            input=collapse.stdout,
            capture_output=True,
            text=True,
            check=True
        )
    except subprocess.CalledProcessError as e:
        print(f"错误: flamegraph.pl 失败: {e}")
        sys.exit(1)

    # 写入文件
    with open(output, 'w') as f:
        f.write(flame.stdout)

    print(f"火焰图已生成: {output}")


def generate_icicle_graph(perf_data: str, output: str, title: str = "Icicle Graph"):
    """生成冰柱图（倒置火焰图）"""
    # 与火焰图相同，但使用 --reverse 参数
    pass


def generate_differential_graph(before_data: str, after_data: str, output: str):
    """生成差异火焰图，比较优化前后"""
    # 需要使用 difffolded.pl 和 flamegraph.pl
    pass


def main():
    parser = argparse.ArgumentParser(description='火焰图生成器')
    parser.add_argument('-i', '--input', required=True, help='perf.data 文件路径')
    parser.add_argument('-o', '--output', required=True, help='输出 SVG 文件路径')
    parser.add_argument('-t', '--title', default='Flame Graph', help='火焰图标题')

    args = parser.parse_args()

    generate_flamegraph(args.input, args.output, args.title)


if __name__ == '__main__':
    main()
