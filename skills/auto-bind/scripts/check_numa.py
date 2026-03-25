#!/usr/bin/env python3
"""
Check NUMA - Analyze NUMA topology and memory distribution
"""

import os
import re
import argparse
import subprocess
from pathlib import Path
from collections import defaultdict
from typing import Dict, List, Tuple


def get_numa_topology() -> Dict:
    """Get NUMA topology information"""
    topology = {
        'nodes': {},
        'total_memory': 0
    }
    
    node_path = Path("/sys/devices/system/node")
    if not node_path.exists():
        print("⚠️  NUMA not supported on this system")
        return topology
    
    for node_dir in sorted(node_path.iterdir()):
        if node_dir.name.startswith("node"):
            node_id = int(node_dir.name.replace("node", ""))
            
            # Get CPU list
            cpulist_file = node_dir / "cpulist"
            cpus = []
            if cpulist_file.exists():
                cpus = parse_cpulist(cpulist_file.read_text().strip())
            
            # Get memory info
            meminfo_file = node_dir / "meminfo"
            total_mem = 0
            free_mem = 0
            if meminfo_file.exists():
                for line in meminfo_file.read_text().split('\n'):
                    if 'MemTotal' in line:
                        total_mem = int(line.split()[3]) // 1024  # KB to MB
                    elif 'MemFree' in line:
                        free_mem = int(line.split()[3]) // 1024
            
            topology['nodes'][node_id] = {
                'cpus': cpus,
                'total_memory_mb': total_mem,
                'free_memory_mb': free_mem
            }
            topology['total_memory'] += total_mem
    
    return topology


def parse_cpulist(cpulist: str) -> List[int]:
    """Parse CPU list like '0-3,5,7-9'"""
    cpus = []
    for part in cpulist.split(','):
        if '-' in part:
            start, end = part.split('-')
            cpus.extend(range(int(start), int(end) + 1))
        else:
            cpus.append(int(part))
    return cpus


def get_process_numa_memory(pid: int) -> Dict[int, int]:
    """Get NUMA memory distribution for a process"""
    memory = {}
    try:
        result = subprocess.run(
            f"numastat -p {pid}",
            shell=True,
            capture_output=True,
            text=True
        )
        
        for line in result.stdout.split('\n'):
            parts = line.split()
            if len(parts) >= 2 and parts[0].startswith('Node'):
                try:
                    node = int(parts[0].replace('Node', ''))
                    mem = int(parts[-1])
                    memory[node] = mem
                except:
                    pass
    except:
        pass
    
    return memory


def check_cross_numa_access(pid: int, duration: int = 5) -> Tuple[int, int]:
    """Check cross-NUMA memory access using perf"""
    local = 0
    remote = 0
    
    try:
        cmd = f"perf stat -e local_node_loads,remote_node_loads -p {pid} sleep {duration} 2>&1"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        
        for line in result.stdout.split('\n'):
            if 'local_node_loads' in line:
                match = re.search(r'(\d+)', line)
                if match:
                    local = int(match.group(1))
            elif 'remote_node_loads' in line:
                match = re.search(r'(\d+)', line)
                if match:
                    remote = int(match.group(1))
    except Exception as e:
        print(f"⚠️  perf analysis failed: {e}")
    
    return local, remote


def analyze_process_numa(pid: int, perf_duration: int = 0):
    """Analyze NUMA behavior of a process"""
    print(f"\n🔍 Analyzing PID {pid}...\n")
    
    # Get process name
    try:
        with open(f'/proc/{pid}/comm', 'r') as f:
            proc_name = f.read().strip()
    except:
        proc_name = "Unknown"
    
    print(f"Process: {proc_name}")
    
    # Get NUMA memory distribution
    numa_memory = get_process_numa_memory(pid)
    
    if numa_memory:
        total_mem = sum(numa_memory.values())
        print(f"\n📊 Memory Distribution ({total_mem} MB total):\n")
        print(f"{'Node':<8} {'Memory (MB)':<15} {'Percentage':<12}")
        print("-" * 35)
        for node, mem in sorted(numa_memory.items()):
            pct = (mem / total_mem * 100) if total_mem > 0 else 0
            bar = '█' * int(pct / 5)
            print(f"{node:<8} {mem:<15} {pct:>8.1f}% {bar}")
        
        # Check if memory is spread across nodes
        if len(numa_memory) > 1:
            print(f"\n⚠️  Memory spread across {len(numa_memory)} NUMA nodes!")
            print(f"   Consider binding to a single NUMA node for better performance.")
    else:
        print("\n⚠️  No NUMA memory data available")
    
    # Check cross-NUMA access with perf
    if perf_duration > 0:
        print(f"\n🔬 Perf Analysis ({perf_duration}s)...\n")
        local, remote = check_cross_numa_access(pid, perf_duration)
        
        total = local + remote
        if total > 0:
            local_pct = (local / total) * 100
            remote_pct = (remote / total) * 100
            
            print(f"Local node accesses:  {local:>10} ({local_pct:.1f}%)")
            print(f"Remote node accesses: {remote:>10} ({remote_pct:.1f}%)")
            
            if remote_pct > 20:
                print(f"\n⚠️  High cross-NUMA access ({remote_pct:.1f}%)!")
                print(f"   Recommend: numactl --cpunodebind=N --membind=N <command>")
            else:
                print(f"\n✅ Cross-NUMA access within acceptable range.")
        else:
            print("No NUMA access data collected.")


def show_numa_topology():
    """Display NUMA topology"""
    topology = get_numa_topology()
    
    print("\n🖥️  NUMA Topology\n")
    print("=" * 60)
    
    if not topology['nodes']:
        print("NUMA not available on this system.")
        return
    
    for node_id, node_info in sorted(topology['nodes'].items()):
        print(f"\nNode {node_id}:")
        print(f"  CPUs:          {node_info['cpus']}")
        print(f"  Total Memory:  {node_info['total_memory_mb']} MB")
        print(f"  Free Memory:   {node_info['free_memory_mb']} MB")
    
    print(f"\nTotal Memory: {topology['total_memory']} MB")


def show_system_numastat():
    """Show system-wide NUMA statistics"""
    try:
        result = subprocess.run(
            "numastat",
            shell=True,
            capture_output=True,
            text=True
        )
        print("\n📈 System NUMA Statistics\n")
        print(result.stdout)
    except:
        print("⚠️  numastat not available")


def main():
    parser = argparse.ArgumentParser(description='Check NUMA topology and memory distribution')
    parser.add_argument('--pid', '-p', type=int, help='Process ID to analyze')
    parser.add_argument('--perf', type=int, default=0,
                       help='Run perf analysis for N seconds')
    parser.add_argument('--topology', '-t', action='store_true',
                       help='Show NUMA topology only')
    parser.add_argument('--system', '-s', action='store_true',
                       help='Show system-wide NUMA statistics')
    
    args = parser.parse_args()
    
    if args.topology:
        show_numa_topology()
    elif args.system:
        show_system_numastat()
    elif args.pid:
        analyze_process_numa(args.pid, args.perf)
    else:
        # Default: show topology
        show_numa_topology()
        print("\n" + "=" * 60)
        print("\n💡 Use --pid <PID> to analyze a specific process")
        print("   Use --perf 5 to run 5-second perf analysis")


if __name__ == '__main__':
    main()
