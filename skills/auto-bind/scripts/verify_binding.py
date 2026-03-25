#!/usr/bin/env python3
"""
Verify Binding - Check CPU and NUMA binding configuration
"""

import os
import re
import argparse
import subprocess
from pathlib import Path
from typing import Dict, List, Tuple
from dataclasses import dataclass


@dataclass
class ProcessBinding:
    pid: int
    name: str
    cpus: List[int]
    numa_nodes: List[int]
    memory_mb: float
    cpu_percent: float


@dataclass
class InterruptBinding:
    irq: str
    name: str
    cpu_mask: str
    cpus: List[int]


def get_process_affinity(pid: int) -> List[int]:
    """Get CPU affinity for a process"""
    try:
        result = subprocess.run(
            f"taskset -pc {pid}",
            shell=True,
            capture_output=True,
            text=True
        )
        
        # Parse "pid 1234's current affinity list: 0-3"
        match = re.search(r'current affinity list:\s*(.+)', result.stdout)
        if match:
            return parse_cpulist(match.group(1).strip())
    except:
        pass
    return []


def parse_cpulist(cpulist: str) -> List[int]:
    """Parse CPU list like '0-3,5,7-9'"""
    cpus = []
    for part in cpulist.split(','):
        part = part.strip()
        if '-' in part:
            try:
                start, end = part.split('-')
                cpus.extend(range(int(start), int(end) + 1))
            except:
                pass
        else:
            try:
                cpus.append(int(part))
            except:
                pass
    return cpus


def get_process_numa_nodes(pid: int) -> List[int]:
    """Get NUMA nodes where process has memory"""
    nodes = []
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
                    if mem > 0:
                        nodes.append(node)
                except:
                    pass
    except:
        pass
    return nodes


def get_process_memory(pid: int) -> float:
    """Get process memory in MB"""
    try:
        with open(f'/proc/{pid}/status', 'r') as f:
            for line in f:
                if line.startswith('VmRSS:'):
                    return float(line.split()[1]) / 1024
    except:
        pass
    return 0.0


def get_interrupt_bindings() -> List[InterruptBinding]:
    """Get interrupt CPU bindings"""
    bindings = []
    
    try:
        with open('/proc/interrupts', 'r') as f:
            lines = f.readlines()
        
        if not lines:
            return bindings
        
        cpu_count = len(lines[0].split())
        
        for line in lines[1:]:
            parts = line.split()
            if len(parts) < 2:
                continue
            
            irq = parts[0].rstrip(':')
            name = ' '.join(parts[cpu_count + 1:])
            
            # Get affinity mask
            try:
                with open(f"/proc/irq/{irq}/smp_affinity", 'r') as f:
                    cpu_mask = f.read().strip()
            except:
                cpu_mask = "N/A"
            
            # Parse CPU counts
            cpu_counts = []
            for i in range(1, min(cpu_count + 1, len(parts))):
                try:
                    cpu_counts.append(int(parts[i]))
                except:
                    cpu_counts.append(0)
            
            bound_cpus = [i for i, c in enumerate(cpu_counts) if c > 0]
            
            bindings.append(InterruptBinding(
                irq=irq,
                name=name,
                cpu_mask=cpu_mask,
                cpus=bound_cpus
            ))
    except:
        pass
    
    return bindings


def verify_processes(filter_name: str = None) -> List[ProcessBinding]:
    """Verify process bindings"""
    bindings = []
    
    # Get top processes
    try:
        cmd = "ps -eo pid,%cpu,comm --sort=-%cpu | head -50"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        
        lines = result.stdout.strip().split('\n')[1:]
        
        for line in lines:
            parts = line.split()
            if len(parts) >= 3:
                try:
                    pid = int(parts[0])
                    cpu_pct = float(parts[1])
                    name = parts[2]
                    
                    if filter_name and filter_name not in name:
                        continue
                    
                    cpus = get_process_affinity(pid)
                    numa_nodes = get_process_numa_nodes(pid)
                    mem_mb = get_process_memory(pid)
                    
                    bindings.append(ProcessBinding(
                        pid=pid,
                        name=name,
                        cpus=cpus,
                        numa_nodes=numa_nodes,
                        memory_mb=mem_mb,
                        cpu_percent=cpu_pct
                    ))
                except:
                    pass
    except:
        pass
    
    return bindings


def check_binding_issues(bindings: List[ProcessBinding], 
                        total_cpus: int) -> List[str]:
    """Check for binding issues"""
    issues = []
    
    for b in bindings:
        # Check if process is unbound (uses all CPUs)
        if len(b.cpus) == total_cpus:
            if b.cpu_percent > 10:
                issues.append(
                    f"⚠️  {b.name} (PID {b.pid}): High CPU ({b.cpu_percent:.1f}%) "
                    f"but unbound (uses all {total_cpus} CPUs)"
                )
        
        # Check cross-NUMA memory
        if len(b.numa_nodes) > 1 and b.memory_mb > 100:
            issues.append(
                f"⚠️  {b.name} (PID {b.pid}): Memory ({b.memory_mb:.0f}MB) "
                f"spread across {len(b.numa_nodes)} NUMA nodes {b.numa_nodes}"
            )
        
        # Check if CPU binding crosses NUMA boundary
        # (simplified check - assumes sequential CPU numbering per node)
        if b.cpus and len(b.cpus) > 8:
            issues.append(
                f"ℹ️  {b.name} (PID {b.pid}): Bound to {len(b.cpus)} CPUs - "
                f"consider reducing for better cache locality"
            )
    
    return issues


def print_process_report(bindings: List[ProcessBinding], 
                        issues: List[str],
                        verbose: bool = False):
    """Print process binding report"""
    print("\n📊 Process Binding Report\n")
    print("=" * 80)
    print(f"{'PID':<8} {'Name':<20} {'CPUs':<15} {'NUMA':<10} {'Mem(MB)':<10} {'CPU%':<8}")
    print("-" * 80)
    
    for b in bindings[:20]:
        cpu_str = f"{len(b.cpus)} cpus" if b.cpus else "all"
        numa_str = str(b.numa_nodes) if b.numa_nodes else "-"
        print(f"{b.pid:<8} {b.name[:18]:<20} {cpu_str:<15} {numa_str:<10} "
              f"{b.memory_mb:<10.0f} {b.cpu_percent:<8.1f}")
    
    if issues:
        print(f"\n⚠️  Issues Found ({len(issues)}):\n")
        for issue in issues:
            print(f"  {issue}")
    else:
        print("\n✅ No binding issues detected!")


def print_interrupt_report(bindings: List[InterruptBinding], 
                          nic_only: bool = True):
    """Print interrupt binding report"""
    
    if nic_only:
        bindings = [b for b in bindings if 'eth' in b.name or 'ens' in b.name]
    
    if not bindings:
        return
    
    print("\n📡 Interrupt Binding Report\n")
    print("=" * 80)
    print(f"{'IRQ':<10} {'Name':<40} {'CPU Mask':<15} {'CPUs':<10}")
    print("-" * 80)
    
    for b in bindings:
        print(f"{b.irq:<10} {b.name[:38]:<40} {b.cpu_mask:<15} {len(b.cpus)}")


def main():
    parser = argparse.ArgumentParser(description='Verify CPU and NUMA bindings')
    parser.add_argument('--process', '-p', help='Filter by process name')
    parser.add_argument('--verbose', '-v', action='store_true',
                       help='Show more details')
    parser.add_argument('--interrupts', '-i', action='store_true',
                       help='Show interrupt bindings')
    parser.add_argument('--all', '-a', action='store_true',
                       help='Show all interrupts (not just NIC)')
    
    args = parser.parse_args()
    
    total_cpus = os.cpu_count() or 1
    
    # Verify processes
    bindings = verify_processes(args.process)
    issues = check_binding_issues(bindings, total_cpus)
    print_process_report(bindings, issues, args.verbose)
    
    # Verify interrupts
    if args.interrupts:
        irq_bindings = get_interrupt_bindings()
        print_interrupt_report(irq_bindings, nic_only=not args.all)
    
    # Summary
    print("\n" + "=" * 80)
    print(f"\n📋 Summary:")
    print(f"   Processes checked: {len(bindings)}")
    print(f"   Issues found:      {len(issues)}")
    
    if issues:
        print(f"\n💡 Recommendations:")
        print(f"   1. Bind high-CPU processes with: taskset -pc <cpus> <pid>")
        print(f"   2. Bind NUMA memory with: numactl --membind=<node> <command>")
        print(f"   3. Check cross-NUMA access: python3 check_numa.py --pid <pid> --perf 5")


if __name__ == '__main__':
    main()
