#!/usr/bin/env python3
"""
Check Interrupts - Analyze interrupt distribution
"""

import os
import re
import argparse
from pathlib import Path
from collections import defaultdict
from typing import List, Dict


def read_interrupts() -> List[Dict]:
    """Read and parse /proc/interrupts"""
    interrupts = []
    
    with open('/proc/interrupts', 'r') as f:
        lines = f.readlines()
    
    if not lines:
        return interrupts
    
    # Parse header to get CPU count
    cpu_count = len(lines[0].split())
    
    for line in lines[1:]:
        parts = line.split()
        if len(parts) < 2:
            continue
        
        irq = parts[0].rstrip(':')
        name = ' '.join(parts[cpu_count + 1:])
        
        # Parse CPU counts
        cpu_counts = []
        for i in range(1, cpu_count + 1):
            try:
                cpu_counts.append(int(parts[i]))
            except:
                cpu_counts.append(0)
        
        # Detect type
        irq_type = 'other'
        if 'eth' in name or 'ens' in name or 'enp' in name:
            irq_type = 'network'
        elif 'timer' in name.lower():
            irq_type = 'timer'
        elif 'keyboard' in name.lower():
            irq_type = 'keyboard'
        
        interrupts.append({
            'irq': irq,
            'name': name,
            'cpu_counts': cpu_counts,
            'total': sum(cpu_counts),
            'type': irq_type
        })
    
    return interrupts


def get_irq_affinity(irq: str) -> str:
    """Get current CPU affinity for an IRQ"""
    try:
        affinity_path = f"/proc/irq/{irq}/smp_affinity"
        with open(affinity_path, 'r') as f:
            return f.read().strip()
    except:
        return "N/A"


def analyze_nic_interrupts(nic_filter: str = None):
    """Analyze network interface card interrupts"""
    interrupts = read_interrupts()
    
    # Filter NIC interrupts
    nic_irqs = [i for i in interrupts if i['type'] == 'network']
    
    if nic_filter:
        nic_irqs = [i for i in nic_irqs if nic_filter in i['name']]
    
    if not nic_irqs:
        print("No NIC interrupts found.")
        return
    
    print("\n📡 NIC Interrupt Analysis\n")
    print("=" * 80)
    print(f"{'IRQ':<10} {'Name':<30} {'CPU Mask':<12} {'Total':>10}")
    print("-" * 80)
    
    for irq in nic_irqs:
        affinity = get_irq_affinity(irq['irq'])
        print(f"{irq['irq']:<10} {irq['name'][:28]:<30} {affinity:<12} {irq['total']:>10}")
    
    # Show CPU distribution
    print("\n📊 CPU Distribution:\n")
    
    cpu_total = defaultdict(int)
    for irq in nic_irqs:
        for cpu, count in enumerate(irq['cpu_counts']):
            cpu_total[cpu] += count
    
    total = sum(cpu_total.values()) or 1
    print(f"{'CPU':<6} {'Count':>12} {'Percentage':>12}")
    print("-" * 32)
    for cpu in sorted(cpu_total.keys()):
        pct = (cpu_total[cpu] / total) * 100
        bar = '█' * int(pct / 2)
        print(f"{cpu:<6} {cpu_total[cpu]:>12} {pct:>10.1f}% {bar}")
    
    # Recommendations
    print("\n💡 Recommendations:\n")
    
    spread_cpus = [cpu for cpu, count in cpu_total.items() if count > 0]
    if len(spread_cpus) > 4:
        print(f"  ⚠️  NIC interrupts spread across {len(spread_cpus)} CPUs.")
        print(f"     Consider consolidating to fewer CPUs for better cache locality.")
    else:
        print(f"  ✅ NIC interrupts well consolidated on {len(spread_cpus)} CPUs.")


def main():
    parser = argparse.ArgumentParser(description='Check interrupt distribution')
    parser.add_argument('--nic', '-n', help='Filter by NIC name (e.g., eth0)')
    parser.add_argument('--type', '-t', choices=['network', 'timer', 'all'],
                       default='network', help='Interrupt type to analyze')
    
    args = parser.parse_args()
    
    if args.type == 'network' or args.nic:
        analyze_nic_interrupts(args.nic)
    else:
        # Show all interrupts
        interrupts = read_interrupts()
        print("\n📋 All Interrupts\n")
        print(f"{'IRQ':<10} {'Type':<10} {'Name':<40} {'Total':>10}")
        print("-" * 75)
        for irq in interrupts[:30]:
            print(f"{irq['irq']:<10} {irq['type']:<10} {irq['name'][:38]:<40} {irq['total']:>10}")


if __name__ == '__main__':
    main()
