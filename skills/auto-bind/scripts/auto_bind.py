#!/usr/bin/env python3
"""
Auto Bind - Server CPU/NUMA Binding Tool
Automates: interrupt binding, process CPU affinity, NUMA memory binding
"""

import os
import sys
import re
import json
import argparse
import subprocess
from pathlib import Path
from typing import Dict, List, Tuple, Optional, Any
from dataclasses import dataclass, field
from collections import defaultdict
from datetime import datetime


# ============================================================================
# Data Models
# ============================================================================

@dataclass
class CPUInfo:
    """CPU topology information"""
    total_cpus: int
    numa_nodes: int
    cpus_per_node: Dict[int, List[int]] = field(default_factory=dict)


@dataclass
class InterruptInfo:
    """Interrupt information"""
    irq: str
    name: str
    cpu_mask: str
    nic: str = ""
    bound_cpus: List[int] = field(default_factory=list)


@dataclass
class ProcessInfo:
    """Process information"""
    pid: int
    name: str
    cpu_percent: float
    mem_mb: float
    tid: int = 0
    current_cpus: List[int] = field(default_factory=list)
    numa_memory: Dict[int, int] = field(default_factory=dict)  # node -> MB


@dataclass
class NumaStats:
    """NUMA memory access statistics"""
    node: int
    local_access: int
    remote_access: int
    total_memory_mb: int = 0


@dataclass
class BindingResult:
    """Binding operation result"""
    target: str  # process name or interrupt name
    binding_type: str  # cpu, numa, interrupt
    cpus: List[int]
    numa_node: Optional[int]
    success: bool
    message: str


@dataclass
class BindReport:
    """Complete binding report"""
    timestamp: str
    hostname: str
    cpu_info: CPUInfo
    
    # Analysis results
    interrupts: List[InterruptInfo] = field(default_factory=list)
    processes: List[ProcessInfo] = field(default_factory=list)
    numa_stats: List[NumaStats] = field(default_factory=list)
    
    # Binding operations
    bindings: List[BindingResult] = field(default_factory=list)
    
    # Recommendations
    recommendations: List[str] = field(default_factory=list)


# ============================================================================
# System Analysis
# ============================================================================

class SystemAnalyzer:
    """Analyze system CPU/NUMA topology"""
    
    def __init__(self):
        self.cpu_info = self._detect_cpu_topology()
    
    def _detect_cpu_topology(self) -> CPUInfo:
        """Detect CPU and NUMA topology"""
        total_cpus = os.cpu_count() or 1
        
        # Detect NUMA nodes
        numa_nodes = set()
        cpus_per_node = defaultdict(list)
        
        try:
            # Parse /sys/devices/system/node/nodeX/cpulist
            node_path = Path("/sys/devices/system/node")
            if node_path.exists():
                for node_dir in node_path.iterdir():
                    if node_dir.name.startswith("node"):
                        node_id = int(node_dir.name.replace("node", ""))
                        numa_nodes.add(node_id)
                        
                        cpulist_file = node_dir / "cpulist"
                        if cpulist_file.exists():
                            cpulist = cpulist_file.read_text().strip()
                            cpus = self._parse_cpulist(cpulist)
                            cpus_per_node[node_id] = cpus
        except Exception as e:
            print(f"⚠️  Failed to detect NUMA topology: {e}")
        
        if not numa_nodes:
            numa_nodes = {0}
            cpus_per_node[0] = list(range(total_cpus))
        
        return CPUInfo(
            total_cpus=total_cpus,
            numa_nodes=len(numa_nodes),
            cpus_per_node=dict(cpus_per_node)
        )
    
    def _parse_cpulist(self, cpulist: str) -> List[int]:
        """Parse CPU list like '0-3,5,7-9'"""
        cpus = []
        for part in cpulist.split(','):
            if '-' in part:
                start, end = part.split('-')
                cpus.extend(range(int(start), int(end) + 1))
            else:
                cpus.append(int(part))
        return cpus


# ============================================================================
# Interrupt Analyzer
# ============================================================================

class InterruptAnalyzer:
    """Analyze and bind network interrupts"""
    
    def __init__(self, cpu_info: CPUInfo):
        self.cpu_info = cpu_info
    
    def list_interrupts(self, nic_filter: str = None) -> List[InterruptInfo]:
        """List all interrupts, optionally filter by NIC"""
        interrupts = []
        
        try:
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
                
                # Parse CPU mask from counts
                cpu_counts = parts[1:cpu_count + 1]
                bound_cpus = [i for i, c in enumerate(cpu_counts) if int(c) > 0]
                
                # Detect NIC name
                nic = ""
                if nic_filter and nic_filter in name:
                    nic = nic_filter
                elif 'eth' in name or 'ens' in name or 'enp' in name:
                    nic = name.split('-')[0] if '-' in name else name
                
                if nic_filter and nic != nic_filter:
                    continue
                
                # Read smp_affinity
                try:
                    affinity_path = f"/proc/irq/{irq}/smp_affinity"
                    if Path(affinity_path).exists():
                        with open(affinity_path, 'r') as f:
                            cpu_mask = f.read().strip()
                    else:
                        cpu_mask = ""
                except:
                    cpu_mask = ""
                
                interrupts.append(InterruptInfo(
                    irq=irq,
                    name=name,
                    cpu_mask=cpu_mask,
                    nic=nic,
                    bound_cpus=bound_cpus
                ))
        
        except Exception as e:
            print(f"⚠️  Failed to read /proc/interrupts: {e}")
        
        return interrupts
    
    def bind_interrupt(self, irq: str, cpus: List[int]) -> Tuple[bool, str]:
        """Bind interrupt to specific CPUs"""
        try:
            # Convert CPU list to hex mask
            mask = 0
            for cpu in cpus:
                if cpu < self.cpu_info.total_cpus:
                    mask |= (1 << cpu)
            
            hex_mask = format(mask, 'x')
            
            # Write to smp_affinity
            affinity_path = f"/proc/irq/{irq}/smp_affinity"
            with open(affinity_path, 'w') as f:
                f.write(hex_mask)
            
            return True, f"Bound IRQ {irq} to CPUs {cpus} (mask: {hex_mask})"
        except PermissionError:
            return False, "Permission denied. Run with sudo."
        except Exception as e:
            return False, f"Failed to bind: {e}"


# ============================================================================
# Process Analyzer
# ============================================================================

class ProcessAnalyzer:
    """Analyze process CPU and memory usage"""
    
    def __init__(self, cpu_info: CPUInfo):
        self.cpu_info = cpu_info
    
    def list_top_processes(self, limit: int = 20) -> List[ProcessInfo]:
        """List top processes by CPU usage"""
        processes = []
        
        try:
            # Use ps to get process info
            cmd = f"ps -eo pid,tid,%cpu,%mem,comm --sort=-%cpu | head -{limit + 1}"
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            
            lines = result.stdout.strip().split('\n')[1:]  # Skip header
            
            for line in lines:
                parts = line.split()
                if len(parts) >= 5:
                    pid = int(parts[0])
                    tid = int(parts[1])
                    cpu_percent = float(parts[2])
                    mem_percent = float(parts[3])
                    name = parts[4]
                    
                    # Get memory in MB
                    mem_mb = self._get_process_memory(pid)
                    
                    # Get current CPU affinity
                    current_cpus = self._get_cpu_affinity(pid)
                    
                    # Get NUMA memory distribution
                    numa_memory = self._get_numa_memory(pid)
                    
                    processes.append(ProcessInfo(
                        pid=pid,
                        name=name,
                        cpu_percent=cpu_percent,
                        mem_mb=mem_mb,
                        tid=tid,
                        current_cpus=current_cpus,
                        numa_memory=numa_memory
                    ))
        
        except Exception as e:
            print(f"⚠️  Failed to list processes: {e}")
        
        return processes
    
    def _get_process_memory(self, pid: int) -> float:
        """Get process memory in MB"""
        try:
            with open(f'/proc/{pid}/status', 'r') as f:
                for line in f:
                    if line.startswith('VmRSS:'):
                        return float(line.split()[1]) / 1024  # KB to MB
        except:
            pass
        return 0.0
    
    def _get_cpu_affinity(self, pid: int) -> List[int]:
        """Get current CPU affinity for process"""
        try:
            result = subprocess.run(
                f"taskset -pc {pid}",
                shell=True,
                capture_output=True,
                text=True
            )
            # Parse output like "pid 1234's current affinity mask: f"
            match = re.search(r'current affinity list:\s*(.+)', result.stdout)
            if match:
                cpulist = match.group(1).strip()
                return self._parse_cpulist(cpulist)
        except:
            pass
        return []
    
    def _get_numa_memory(self, pid: int) -> Dict[int, int]:
        """Get NUMA memory distribution for process"""
        numa_memory = {}
        try:
            result = subprocess.run(
                f"numastat -p {pid}",
                shell=True,
                capture_output=True,
                text=True
            )
            # Parse numastat output
            for line in result.stdout.split('\n'):
                parts = line.split()
                if len(parts) >= 2 and parts[0].startswith('Node'):
                    try:
                        node = int(parts[0].replace('Node', ''))
                        mem = int(parts[-1])
                        numa_memory[node] = mem
                    except:
                        pass
        except:
            pass
        return numa_memory
    
    def _parse_cpulist(self, cpulist: str) -> List[int]:
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
    
    def bind_process(self, pid: int, cpus: List[int], use_numactl: bool = False) -> Tuple[bool, str]:
        """Bind process to specific CPUs"""
        try:
            cpulist = ','.join(map(str, cpus))
            
            if use_numactl:
                # Note: numactl only works at process start
                return False, "numactl requires process restart. Use taskset for running processes."
            else:
                # Use taskset
                result = subprocess.run(
                    f"taskset -pc {cpulist} {pid}",
                    shell=True,
                    capture_output=True,
                    text=True
                )
                
                if result.returncode == 0:
                    return True, f"Bound PID {pid} to CPUs {cpus}"
                else:
                    return False, f"taskset failed: {result.stderr}"
        
        except Exception as e:
            return False, f"Failed to bind: {e}"


# ============================================================================
# NUMA Analyzer
# ============================================================================

class NumaAnalyzer:
    """Analyze NUMA memory access patterns"""
    
    def __init__(self, cpu_info: CPUInfo):
        self.cpu_info = cpu_info
    
    def check_numa_access(self, pid: int, duration: int = 5) -> NumaStats:
        """Check NUMA memory access for a process using perf"""
        local_access = 0
        remote_access = 0
        node = 0
        
        try:
            # Use perf to count local/remote node accesses
            cmd = f"perf stat -e local_node_loads,remote_node_loads -p {pid} sleep {duration} 2>&1"
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            
            # Parse perf output
            for line in result.stdout.split('\n'):
                if 'local_node_loads' in line:
                    match = re.search(r'(\d+)', line)
                    if match:
                        local_access = int(match.group(1))
                elif 'remote_node_loads' in line:
                    match = re.search(r'(\d+)', line)
                    if match:
                        remote_access = int(match.group(1))
        
        except Exception as e:
            print(f"⚠️  perf analysis failed: {e}")
        
        # Get memory info
        total_memory = self._get_process_numa_memory(pid)
        for n, mem in total_memory.items():
            if mem == max(total_memory.values()) if total_memory else 0:
                node = n
                break
        
        return NumaStats(
            node=node,
            local_access=local_access,
            remote_access=remote_access,
            total_memory_mb=sum(total_memory.values())
        )
    
    def _get_process_numa_memory(self, pid: int) -> Dict[int, int]:
        """Get NUMA memory distribution"""
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
    
    def get_numa_recommended_node(self, pid: int) -> int:
        """Get recommended NUMA node for a process"""
        memory = self._get_process_numa_memory(pid)
        if memory:
            return max(memory.items(), key=lambda x: x[1])[0]
        return 0


# ============================================================================
# Binding Verifier
# ============================================================================

class BindingVerifier:
    """Verify binding configurations"""
    
    def __init__(self, cpu_info: CPUInfo):
        self.cpu_info = cpu_info
        self.process_analyzer = ProcessAnalyzer(cpu_info)
        self.interrupt_analyzer = InterruptAnalyzer(cpu_info)
    
    def verify_all(self) -> Dict[str, Any]:
        """Verify all bindings"""
        results = {
            'processes': [],
            'interrupts': [],
            'warnings': []
        }
        
        # Verify process bindings
        for proc in self.process_analyzer.list_top_processes(50):
            if proc.current_cpus:
                results['processes'].append({
                    'pid': proc.pid,
                    'name': proc.name,
                    'cpus': proc.current_cpus,
                    'cpu_percent': proc.cpu_percent
                })
                
                # Check if bound to single NUMA node
                if len(proc.numa_memory) > 1:
                    results['warnings'].append(
                        f"Process {proc.name} (PID {proc.pid}) has memory on multiple NUMA nodes"
                    )
        
        # Verify interrupt bindings
        for irq in self.interrupt_analyzer.list_interrupts():
            if irq.nic:  # Only check NIC interrupts
                results['interrupts'].append({
                    'irq': irq.irq,
                    'nic': irq.nic,
                    'cpus': irq.bound_cpus,
                    'mask': irq.cpu_mask
                })
        
        return results


# ============================================================================
# Main Controller
# ============================================================================

class AutoBindController:
    """Main controller for auto-binding"""
    
    def __init__(self):
        self.system = SystemAnalyzer()
        self.interrupts = InterruptAnalyzer(self.system.cpu_info)
        self.processes = ProcessAnalyzer(self.system.cpu_info)
        self.numa = NumaAnalyzer(self.system.cpu_info)
        self.verifier = BindingVerifier(self.system.cpu_info)
        self.report = BindReport(
            timestamp=datetime.now().isoformat(),
            hostname=os.uname().nodename,
            cpu_info=self.system.cpu_info
        )
    
    def check(self) -> BindReport:
        """Check current system status"""
        print("🔍 Checking system status...")
        
        # Get interrupt info
        self.report.interrupts = self.interrupts.list_interrupts()
        nic_interrupts = [i for i in self.report.interrupts if i.nic]
        print(f"  📡 Found {len(nic_interrupts)} NIC interrupts")
        
        # Get process info
        self.report.processes = self.processes.list_top_processes(20)
        print(f"  📊 Found {len(self.report.processes)} top processes")
        
        # Generate recommendations
        self._generate_recommendations()
        
        return self.report
    
    def bind_interrupts(self, nic: str, cpus: List[int]) -> List[BindingResult]:
        """Bind NIC interrupts to CPUs"""
        results = []
        print(f"🔗 Binding {nic} interrupts to CPUs {cpus}...")
        
        interrupts = self.interrupts.list_interrupts(nic_filter=nic)
        
        for irq in interrupts:
            success, msg = self.interrupts.bind_interrupt(irq.irq, cpus)
            result = BindingResult(
                target=f"IRQ {irq.irq} ({irq.name})",
                binding_type='interrupt',
                cpus=cpus,
                numa_node=None,
                success=success,
                message=msg
            )
            results.append(result)
            self.report.bindings.append(result)
            
            status = "✅" if success else "❌"
            print(f"  {status} {msg}")
        
        return results
    
    def bind_processes(self, process_names: List[str], 
                       cpu_allocation: Dict[str, List[int]] = None) -> List[BindingResult]:
        """Bind processes to CPUs"""
        results = []
        print(f"🔗 Binding processes...")
        
        for proc in self.report.processes:
            if proc.name in process_names:
                cpus = cpu_allocation.get(proc.name, [0]) if cpu_allocation else [0]
                
                success, msg = self.processes.bind_process(proc.pid, cpus)
                result = BindingResult(
                    target=f"{proc.name} (PID {proc.pid})",
                    binding_type='cpu',
                    cpus=cpus,
                    numa_node=None,
                    success=success,
                    message=msg
                )
                results.append(result)
                self.report.bindings.append(result)
                
                status = "✅" if success else "❌"
                print(f"  {status} {msg}")
        
        return results
    
    def verify(self) -> Dict:
        """Verify all bindings"""
        print("✅ Verifying bindings...")
        return self.verifier.verify_all()
    
    def _generate_recommendations(self):
        """Generate binding recommendations"""
        recommendations = []
        
        # Check for processes with high memory on multiple NUMA nodes
        for proc in self.report.processes:
            if proc.mem_mb > 100 and len(proc.numa_memory) > 1:
                recommendations.append(
                    f"Process {proc.name} (PID {proc.pid}) uses {proc.mem_mb:.0f}MB "
                    f"across {len(proc.numa_memory)} NUMA nodes. Consider NUMA binding."
                )
        
        # Check for NIC interrupts spread across CPUs
        nic_irqs = [i for i in self.report.interrupts if i.nic]
        if nic_irqs:
            for irq in nic_irqs:
                if len(irq.bound_cpus) > 4:
                    recommendations.append(
                        f"NIC interrupt {irq.irq} is spread across {len(irq.bound_cpus)} CPUs. "
                        f"Consider consolidating to fewer CPUs."
                    )
        
        # Check CPU affinity
        for proc in self.report.processes[:5]:
            if proc.cpu_percent > 10 and len(proc.current_cpus) == self.system.cpu_info.total_cpus:
                recommendations.append(
                    f"High CPU process {proc.name} ({proc.cpu_percent:.1f}%) is not bound. "
                    f"Consider CPU pinning."
                )
        
        self.report.recommendations = recommendations
    
    def export_report(self, output_path: str):
        """Export binding report as Markdown"""
        md = []
        
        md.append("# 🔗 Auto-Bind Report\n")
        md.append(f"**Generated:** {self.report.timestamp}\n")
        md.append(f"**Host:** {self.report.hostname}\n")
        
        # CPU Topology
        md.append("\n## 🖥️ CPU Topology\n")
        md.append(f"- **Total CPUs:** {self.report.cpu_info.total_cpus}")
        md.append(f"- **NUMA Nodes:** {self.report.cpu_info.numa_nodes}")
        for node, cpus in self.report.cpu_info.cpus_per_node.items():
            md.append(f"- **Node {node}:** CPUs {cpus}")
        
        # Top Processes
        md.append("\n## 📊 Top Processes\n")
        md.append("| PID | Name | CPU% | Memory (MB) | Current CPUs | NUMA Nodes |")
        md.append("|-----|------|------|-------------|--------------|------------|")
        for proc in self.report.processes[:15]:
            numa_nodes = list(proc.numa_memory.keys()) if proc.numa_memory else ['-']
            md.append(f"| {proc.pid} | {proc.name} | {proc.cpu_percent:.1f} | {proc.mem_mb:.0f} | {proc.current_cpus[:5]}... | {numa_nodes} |")
        
        # NIC Interrupts
        nic_irqs = [i for i in self.report.interrupts if i.nic]
        if nic_irqs:
            md.append("\n## 📡 NIC Interrupts\n")
            md.append("| IRQ | NIC | CPU Mask | Bound CPUs |")
            md.append("|-----|-----|----------|------------|")
            for irq in nic_irqs:
                md.append(f"| {irq.irq} | {irq.nic} | {irq.cpu_mask} | {irq.bound_cpus} |")
        
        # Binding Operations
        if self.report.bindings:
            md.append("\n## 🔗 Binding Operations\n")
            md.append("| Target | Type | CPUs | Status | Message |")
            md.append("|--------|------|------|--------|---------|")
            for b in self.report.bindings:
                status = "✅" if b.success else "❌"
                md.append(f"| {b.target} | {b.binding_type} | {b.cpus} | {status} | {b.message} |")
        
        # Recommendations
        if self.report.recommendations:
            md.append("\n## 💡 Recommendations\n")
            for i, rec in enumerate(self.report.recommendations, 1):
                md.append(f"{i}. {rec}")
        
        # Write file
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write('\n'.join(md))
        
        print(f"📝 Report saved to: {output_path}")


# ============================================================================
# CLI
# ============================================================================

def main():
    parser = argparse.ArgumentParser(
        description='Auto-Bind: Server CPU/NUMA Binding Tool',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Check current status
  sudo python3 auto_bind.py --mode check

  # Bind NIC interrupts to CPUs 0-3
  sudo python3 auto_bind.py --mode interrupt --nic eth0 --cpus 0-3

  # Bind processes
  sudo python3 auto_bind.py --mode process --processes nginx,mysql --cpus 0-7

  # Full auto-binding
  sudo python3 auto_bind.py --mode full --output report.md
        """
    )
    
    parser.add_argument('--mode', '-m',
                       choices=['check', 'interrupt', 'process', 'numa', 'verify', 'full'],
                       default='check',
                       help='Operation mode')
    parser.add_argument('--nic', '-n',
                       help='NIC name for interrupt binding (e.g., eth0)')
    parser.add_argument('--cpus', '-c',
                       help='CPU list (e.g., 0-3 or 0,1,2,3)')
    parser.add_argument('--processes', '-p',
                       help='Process names to bind (comma-separated)')
    parser.add_argument('--node', type=int,
                       help='NUMA node for memory binding')
    parser.add_argument('--output', '-o',
                       help='Output report file')
    parser.add_argument('--dry-run', action='store_true',
                       help='Show what would be done without executing')
    
    args = parser.parse_args()
    
    # Check root permissions for binding operations
    if args.mode in ['interrupt', 'process', 'numa', 'full'] and os.geteuid() != 0:
        print("⚠️  Warning: Binding operations require root privileges.")
        print("   Run with sudo for actual binding, or use --mode check to view status.\n")
    
    # Parse CPU list
    cpus = []
    if args.cpus:
        for part in args.cpus.split(','):
            if '-' in part:
                start, end = part.split('-')
                cpus.extend(range(int(start), int(end) + 1))
            else:
                cpus.append(int(part))
    
    # Parse process names
    process_names = []
    if args.processes:
        process_names = [p.strip() for p in args.processes.split(',')]
    
    # Create controller
    controller = AutoBindController()
    
    # Execute based on mode
    if args.mode == 'check':
        controller.check()
        if args.output:
            controller.export_report(args.output)
    
    elif args.mode == 'interrupt':
        if not args.nic:
            print("❌ --nic is required for interrupt mode")
            sys.exit(1)
        if not cpus:
            print("❌ --cpus is required for interrupt mode")
            sys.exit(1)
        
        controller.check()
        if not args.dry_run:
            controller.bind_interrupts(args.nic, cpus)
        else:
            print(f"🔍 [DRY RUN] Would bind {args.nic} interrupts to CPUs {cpus}")
        
        if args.output:
            controller.export_report(args.output)
    
    elif args.mode == 'process':
        if not process_names:
            print("❌ --processes is required for process mode")
            sys.exit(1)
        
        controller.check()
        cpu_alloc = {name: cpus for name in process_names} if cpus else None
        
        if not args.dry_run:
            controller.bind_processes(process_names, cpu_alloc)
        else:
            print(f"🔍 [DRY RUN] Would bind {process_names} to CPUs {cpus}")
        
        if args.output:
            controller.export_report(args.output)
    
    elif args.mode == 'verify':
        results = controller.verify()
        print("\n📋 Verification Results:")
        print(f"  Processes checked: {len(results['processes'])}")
        print(f"  Interrupts checked: {len(results['interrupts'])}")
        if results['warnings']:
            print(f"\n⚠️  Warnings ({len(results['warnings'])}):")
            for w in results['warnings']:
                print(f"    - {w}")
    
    elif args.mode == 'full':
        print("🚀 Running full auto-binding...\n")
        
        # Step 1: Check
        controller.check()
        
        # Step 2: Bind high-CPU processes
        high_cpu_procs = [p for p in controller.report.processes if p.cpu_percent > 10]
        if high_cpu_procs and not args.dry_run:
            print(f"\n📊 Binding {len(high_cpu_procs)} high-CPU processes...")
            # Simple round-robin CPU allocation
            for i, proc in enumerate(high_cpu_procs[:5]):
                node = i % controller.report.cpu_info.numa_nodes
                node_cpus = controller.report.cpu_info.cpus_per_node.get(node, [0])
                if node_cpus:
                    controller.processes.bind_process(proc.pid, [node_cpus[i % len(node_cpus)]])
        
        # Step 3: Bind NIC interrupts
        nic_irqs = [i for i in controller.report.interrupts if i.nic]
        if nic_irqs and not args.dry_run:
            print(f"\n📡 Binding {len(nic_irqs)} NIC interrupts...")
            # Bind to first NUMA node CPUs
            node_0_cpus = controller.report.cpu_info.cpus_per_node.get(0, [0])[:4]
            for irq in nic_irqs:
                controller.interrupts.bind_interrupt(irq.irq, node_0_cpus)
        
        # Step 4: Verify
        print("\n")
        controller.verify()
        
        if args.output:
            controller.export_report(args.output)
    
    print("\n✅ Done!")


if __name__ == '__main__':
    main()
