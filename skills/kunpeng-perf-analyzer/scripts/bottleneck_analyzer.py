#!/usr/bin/env python3
"""
瓶颈类型分析器
根据 perf 数据分析瓶颈类型并给出优化建议
"""

import re
import sys
import json
from dataclasses import dataclass
from typing import List, Dict, Optional
from enum import Enum


class BottleneckType(Enum):
    CPU_BOUND = "CPU密集型"
    MEMORY_BOUND = "内存密集型"
    BRANCH_BOUND = "分支密集型"
    MIXED = "混合型"
    UNKNOWN = "未知"


@dataclass
class HotspotFunction:
    name: str
    overhead: float
    samples: int
    dso: str = ""

    def to_dict(self):
        return {
            "name": self.name,
            "overhead": self.overhead,
            "samples": self.samples,
            "dso": self.dso
        }


@dataclass
class OptimizationSuggestion:
    priority: str  # high, medium, low
    category: str
    description: str
    expected_gain: str
    implementation: str

    def to_dict(self):
        return {
            "priority": self.priority,
            "category": self.category,
            "description": self.description,
            "expected_gain": self.expected_gain,
            "implementation": self.implementation
        }


class BottleneckAnalyzer:
    """瓶颈分析器"""

    def __init__(self):
        self.hotspots: List[HotspotFunction] = []
        self.hw_counters: Dict[str, float] = {}

    def parse_perf_report(self, report_path: str) -> List[HotspotFunction]:
        """解析 perf report 输出"""
        hotspots = []

        with open(report_path, 'r') as f:
            content = f.read()

        # 解析热点函数
        # 格式: "   12.34%  function_name  /path/to/binary"
        pattern = r'\s+(\d+\.\d+)%\s+(\S+)\s+(.*)'
        for match in re.finditer(pattern, content):
            overhead = float(match.group(1))
            name = match.group(2)
            dso = match.group(3).strip() if match.group(3) else ""

            # 过滤掉不需要的条目
            if name in ['[kernel]', '[unknown]']:
                continue

            hotspots.append(HotspotFunction(
                name=name,
                overhead=overhead,
                samples=int(overhead * 100),  # 估算
                dso=dso
            ))

        self.hotspots = sorted(hotspots, key=lambda x: x.overhead, reverse=True)[:20]
        return self.hotspots

    def parse_perf_stat(self, stat_output: str) -> Dict[str, float]:
        """解析 perf stat 输出"""
        counters = {}

        patterns = {
            'cycles': r'[\d,]+\s+cycles',
            'instructions': r'[\d,]+\s+instructions',
            'cache_misses': r'[\d,]+\s+cache-misses',
            'cache_references': r'[\d,]+\s+cache-references',
            'branch_misses': r'[\d,]+\s+branch-misses',
            'branches': r'[\d,]+\s+branches',
        }

        for key, pattern in patterns.items():
            match = re.search(pattern, stat_output)
            if match:
                value = match.group(0).split()[0].replace(',', '')
                counters[key] = float(value)

        self.hw_counters = counters
        return counters

    def analyze_bottleneck(self) -> BottleneckType:
        """分析瓶颈类型"""
        if not self.hw_counters:
            return BottleneckType.UNKNOWN

        cycles = self.hw_counters.get('cycles', 1)
        instructions = self.hw_counters.get('instructions', 1)
        cache_misses = self.hw_counters.get('cache_misses', 0)
        cache_references = self.hw_counters.get('cache_references', 1)
        branch_misses = self.hw_counters.get('branch_misses', 0)
        branches = self.hw_counters.get('branches', 1)

        # 计算 CPI (Cycles Per Instruction)
        cpi = cycles / instructions if instructions > 0 else 0

        # 计算缓存未命中率
        cache_miss_rate = cache_misses / cache_references if cache_references > 0 else 0

        # 计算分支预测失败率
        branch_miss_rate = branch_misses / branches if branches > 0 else 0

        # 判断瓶颈类型
        if cpi > 2.0 or cache_miss_rate > 0.15:
            return BottleneckType.MEMORY_BOUND
        elif branch_miss_rate > 0.10:
            return BottleneckType.BRANCH_BOUND
        elif cpi < 1.0:
            return BottleneckType.CPU_BOUND
        else:
            return BottleneckType.MIXED

    def generate_suggestions(self, bottleneck: BottleneckType) -> List[OptimizationSuggestion]:
        """根据瓶颈类型生成优化建议"""
        suggestions = []

        if bottleneck == BottleneckType.MEMORY_BOUND:
            suggestions.extend([
                OptimizationSuggestion(
                    priority="high",
                    category="内存优化",
                    description="数据预取优化",
                    expected_gain="10-30%",
                    implementation="使用 __builtin_prefetch 预取数据"
                ),
                OptimizationSuggestion(
                    priority="high",
                    category="内存优化",
                    description="缓存分块",
                    expected_gain="15-40%",
                    implementation="对大数组进行分块处理，提高缓存命中率"
                ),
                OptimizationSuggestion(
                    priority="medium",
                    category="数据布局",
                    description="AoS转SoA",
                    expected_gain="10-20%",
                    implementation="将结构体数组转为数组结构体"
                ),
            ])

        elif bottleneck == BottleneckType.CPU_BOUND:
            suggestions.extend([
                OptimizationSuggestion(
                    priority="high",
                    category="向量化",
                    description="SIMD向量化",
                    expected_gain="2-8x",
                    implementation="使用NEON/SVE指令进行向量化"
                ),
                OptimizationSuggestion(
                    priority="medium",
                    category="循环优化",
                    description="循环展开",
                    expected_gain="10-30%",
                    implementation="手动或编译器自动展开循环"
                ),
                OptimizationSuggestion(
                    priority="medium",
                    category="编译优化",
                    description="PGO优化",
                    expected_gain="10-25%",
                    implementation="使用-fprofile-generate/use进行Profile-Guided Optimization"
                ),
            ])

        elif bottleneck == BottleneckType.BRANCH_BOUND:
            suggestions.extend([
                OptimizationSuggestion(
                    priority="high",
                    category="分支优化",
                    description="减少分支",
                    expected_gain="15-30%",
                    implementation="使用条件传送指令或查表法替代分支"
                ),
                OptimizationSuggestion(
                    priority="medium",
                    category="分支优化",
                    description="分支预测提示",
                    expected_gain="5-15%",
                    implementation="使用 __builtin_expect 提示分支走向"
                ),
            ])

        # 根据热点函数添加特定建议
        for hotspot in self.hotspots[:5]:
            if 'memcpy' in hotspot.name.lower() or 'memset' in hotspot.name.lower():
                suggestions.append(OptimizationSuggestion(
                    priority="high",
                    category="库替换",
                    description=f"替换 {hotspot.name}",
                    expected_gain="20-50%",
                    implementation="使用鲲鹏优化的KML库替换标准库函数"
                ))

            if 'malloc' in hotspot.name.lower() or 'free' in hotspot.name.lower():
                suggestions.append(OptimizationSuggestion(
                    priority="medium",
                    category="内存管理",
                    description="优化内存分配",
                    expected_gain="10-20%",
                    implementation="使用内存池或对象池减少动态分配"
                ))

            if 'lock' in hotspot.name.lower() or 'mutex' in hotspot.name.lower():
                suggestions.append(OptimizationSuggestion(
                    priority="high",
                    category="并发优化",
                    description="减少锁竞争",
                    expected_gain="20-50%",
                    implementation="使用无锁数据结构或细粒度锁"
                ))

        return suggestions

    def generate_report(self) -> str:
        """生成分析报告"""
        bottleneck = self.analyze_bottleneck()
        suggestions = self.generate_suggestions(bottleneck)

        report = []
        report.append("# 性能分析报告")
        report.append("")
        report.append("## 1. 瓶颈类型")
        report.append(f"**{bottleneck.value}**")
        report.append("")

        report.append("## 2. 热点函数 Top 10")
        report.append("| 排名 | 函数名 | CPU% | DSO |")
        report.append("|------|--------|------|-----|")
        for i, h in enumerate(self.hotspots[:10], 1):
            report.append(f"| {i} | {h.name} | {h.overhead:.2f}% | {h.dso} |")
        report.append("")

        report.append("## 3. 优化建议")
        report.append("### 高优先级")
        for s in suggestions:
            if s.priority == "high":
                report.append(f"- **{s.category}**: {s.description}")
                report.append(f"  - 预期收益: {s.expected_gain}")
                report.append(f"  - 实现方法: {s.implementation}")
        report.append("")

        report.append("### 中优先级")
        for s in suggestions:
            if s.priority == "medium":
                report.append(f"- **{s.category}**: {s.description}")
                report.append(f"  - 预期收益: {s.expected_gain}")
                report.append(f"  - 实现方法: {s.implementation}")

        return "\n".join(report)

    def to_json(self) -> str:
        """导出为JSON"""
        bottleneck = self.analyze_bottleneck()
        suggestions = self.generate_suggestions(bottleneck)

        return json.dumps({
            "bottleneck_type": bottleneck.value,
            "hotspots": [h.to_dict() for h in self.hotspots],
            "hardware_counters": self.hw_counters,
            "suggestions": [s.to_dict() for s in suggestions]
        }, indent=2, ensure_ascii=False)


def main():
    if len(sys.argv) < 2:
        print("用法: python bottleneck_analyzer.py <perf_report.txt>")
        sys.exit(1)

    analyzer = BottleneckAnalyzer()
    analyzer.parse_perf_report(sys.argv[1])
    print(analyzer.generate_report())


if __name__ == '__main__':
    main()
