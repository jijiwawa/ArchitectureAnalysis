#!/usr/bin/env python3
"""
Environment Check - 检测 auto-bind 运行环境
"""

import os
import sys
import subprocess
from pathlib import Path


def check_command(cmd: str) -> bool:
    """检查命令是否可用"""
    try:
        result = subprocess.run(
            f"which {cmd}",
            shell=True,
            capture_output=True,
            text=True
        )
        return result.returncode == 0
    except:
        return False


def check_permission() -> bool:
    """检查是否有 root 权限"""
    return os.geteuid() == 0


def check_numa_support() -> bool:
    """检查系统是否支持 NUMA"""
    node_path = Path("/sys/devices/system/node")
    if not node_path.exists():
        return False
    
    nodes = list(node_path.glob("node*"))
    return len(nodes) > 1


def check_perf_support() -> bool:
    """检查 perf 是否可用"""
    try:
        result = subprocess.run(
            "perf --version",
            shell=True,
            capture_output=True,
            text=True,
            timeout=2
        )
        return result.returncode == 0
    except:
        return False


def check_interrupts() -> bool:
    """检查是否有硬件中断"""
    try:
        with open('/proc/interrupts', 'r') as f:
            content = f.read()
        # 检查是否有网卡中断
        return 'eth' in content or 'ens' in content or 'enp' in content
    except:
        return False


def get_cpu_info():
    """获取 CPU 信息"""
    info = {
        'total_cpus': os.cpu_count() or 1,
        'numa_nodes': 0,
        'architecture': 'unknown'
    }
    
    try:
        result = subprocess.run(
            "lscpu",
            shell=True,
            capture_output=True,
            text=True
        )
        
        for line in result.stdout.split('\n'):
            if line.startswith('Architecture:'):
                info['architecture'] = line.split(':')[1].strip()
            elif line.startswith('CPU(s):'):
                info['total_cpus'] = int(line.split(':')[1].strip())
            elif line.startswith('NUMA node(s):'):
                info['numa_nodes'] = int(line.split(':')[1].strip())
    except:
        pass
    
    return info


def main():
    print("🔍 Auto-Bind Environment Check\n")
    print("=" * 60)
    
    # 1. 基础命令检查
    print("\n📦 Command Availability:")
    commands = {
        'taskset': 'CPU 绑核',
        'numactl': 'NUMA 绑定',
        'numastat': 'NUMA 统计',
        'perf': '性能分析',
        'lscpu': 'CPU 信息',
        'ps': '进程列表',
        'top': '系统监控'
    }
    
    for cmd, desc in commands.items():
        available = check_command(cmd)
        status = "✅" if available else "❌"
        print(f"  {status} {cmd:12} - {desc}")
    
    # 2. 权限检查
    print("\n🔐 Permissions:")
    has_root = check_permission()
    status = "✅" if has_root else "⚠️ "
    print(f"  {status} Root privileges: {'Yes' if has_root else 'No (bind operations will require sudo)'}")
    
    # 3. 系统特性检查
    print("\n🖥️  System Features:")
    
    numa_supported = check_numa_support()
    status = "✅" if numa_supported else "⚠️ "
    print(f"  {status} NUMA support: {'Yes' if numa_supported else 'No (single NUMA node or container)'}")
    
    perf_supported = check_perf_support()
    status = "✅" if perf_supported else "⚠️ "
    print(f"  {status} Perf support: {'Yes' if perf_supported else 'No (cannot detect cross-NUMA access)'}")
    
    has_interrupts = check_interrupts()
    status = "✅" if has_interrupts else "ℹ️ "
    print(f"  {status} Hardware interrupts: {'Yes' if has_interrupts else 'No (container environment)'}")
    
    # 4. CPU 信息
    print("\n💻 CPU Information:")
    cpu_info = get_cpu_info()
    print(f"  • Total CPUs: {cpu_info['total_cpus']}")
    print(f"  • NUMA Nodes: {cpu_info['numa_nodes']}")
    print(f"  • Architecture: {cpu_info['architecture']}")
    
    # 5. 功能可用性总结
    print("\n" + "=" * 60)
    print("📋 Feature Availability:\n")
    
    features = []
    
    if check_command('taskset'):
        features.append("✅ CPU binding with taskset")
    else:
        features.append("❌ CPU binding not available (install taskset)")
    
    if numa_supported and check_command('numactl'):
        features.append("✅ NUMA binding with numactl")
    else:
        features.append("⚠️  NUMA binding limited (single node or numactl not installed)")
    
    if numa_supported and check_command('numastat'):
        features.append("✅ NUMA memory analysis with numastat")
    else:
        features.append("⚠️  NUMA memory analysis not available")
    
    if perf_supported:
        features.append("✅ Cross-NUMA access detection with perf")
    else:
        features.append("⚠️  Cross-NUMA detection not available (install perf)")
    
    if has_interrupts:
        features.append("✅ Interrupt binding available")
    else:
        features.append("ℹ️  No hardware interrupts (container environment)")
    
    for feature in features:
        print(f"  {feature}")
    
    # 6. 推荐操作
    print("\n" + "=" * 60)
    print("💡 Recommended Actions:\n")
    
    if not has_root:
        print("  • Use 'sudo' for binding operations:")
        print("    sudo python3 auto_bind.py --mode process --processes <name> --cpus 0-3\n")
    
    if not numa_supported:
        print("  • In single NUMA environment, focus on:")
        print("    - CPU binding with taskset")
        print("    - Process isolation")
        print("    - Cache optimization\n")
    
    if not perf_supported:
        print("  • Install perf for advanced analysis:")
        print("    Debian/Ubuntu: sudo apt-get install linux-perf")
        print("    CentOS/RHEL: sudo yum install perf\n")
    
    print("  • Quick start commands:")
    print("    # Check system status")
    print("    python3 auto_bind.py --mode check\n")
    print("    # Bind processes (dry-run first)")
    print("    python3 auto_bind.py --mode process --processes <name> --cpus 0-3 --dry-run")
    
    print("\n✅ Environment check complete!")


if __name__ == '__main__':
    main()
