#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
CPU-Bind: AI 机头场景专用绑核工具

功能:
1. 查看高 CPU 利用率进程
2. 分析进程线程和亲和性
3. 绑定高 CPU 线程到独立核心
4. 验证绑定结果
"""

import os
import sys
import subprocess
import argparse
import json
import time
import re
from collections import defaultdict


class CPUBinder:
    """CPU 绑核工具"""
    
    def __init__(self):
        self.cpu_count = os.cpu_count()
        
    def run_command(self, cmd, timeout=10):
        """执行命令"""
        try:
            result = subprocess.run(
                cmd, shell=True, capture_output=True, text=True, timeout=timeout
            )
            return result.stdout.strip(), result.returncode
        except subprocess.TimeoutExpired:
            return "", -1
        except Exception as e:
            return str(e), -1
    
    def get_top_processes(self, count=3, duration=3):
        """获取 top CPU 进程"""
        print(f"\n🔍 正在采样 {duration} 秒内的 CPU 使用率...\n")
        
        # 采样 3 秒
        samples = []
        for i in range(duration):
            output, rc = self.run_command("ps aux --sort=-%cpu")
            if rc == 0:
                lines = output.strip().split('\n')[1:]  # 跳过 header
                for line in lines:
                    parts = line.split(None, 10)  # 最多分成 11 部分
                    if len(parts) >= 11:
                        try:
                            pid = int(parts[1])
                            cpu = float(parts[2])
                            mem = float(parts[3])
                            cmd = parts[10][:50]
                            samples.append({
                                'pid': pid,
                                'cpu': cpu,
                                'mem': mem,
                                'command': cmd
                            })
                        except (ValueError, IndexError):
                            continue
            time.sleep(1)
        
        # 聚合统计
        process_stats = defaultdict(lambda: {'cpu_sum': 0, 'count': 0, 'mem': 0, 'command': ''})
        for s in samples:
            pid = s['pid']
            process_stats[pid]['cpu_sum'] += s['cpu']
            process_stats[pid]['count'] += 1
            process_stats[pid]['mem'] = s['mem']
            process_stats[pid]['command'] = s['command']
        
        # 计算平均 CPU
        top_processes = []
        for pid, stats in process_stats.items():
            avg_cpu = stats['cpu_sum'] / stats['count']
            top_processes.append({
                'pid': pid,
                'avg_cpu': avg_cpu,
                'mem': stats['mem'],
                'command': stats['command']
            })
        
        # 排序并取 top N
        top_processes.sort(key=lambda x: x['avg_cpu'], reverse=True)
        return top_processes[:count]
    
    def get_process_threads(self, pid):
        """获取进程的所有线程"""
        output, rc = self.run_command("ps -eLo pid,tid,%cpu,comm,psr")
        
        threads = []
        if rc == 0 and output:
            lines = output.strip().split('\n')[1:]  # 跳过 header
            for line in lines:
                parts = line.split()
                if len(parts) >= 5:
                    try:
                        line_pid = int(parts[0])
                        if line_pid == pid:
                            threads.append({
                                'pid': line_pid,
                                'tid': int(parts[1]),
                                'cpu': float(parts[2]),
                                'command': parts[3],
                                'processor': int(parts[4])
                            })
                    except (ValueError, IndexError):
                        continue
        
        return threads
    
    def get_thread_affinity(self, tid):
        """获取线程亲和性"""
        output, rc = self.run_command(f"taskset -pc {tid}")
        if rc == 0 and output:
            # 输出格式: pid X's current affinity list: 0-9
            match = re.search(r':\s*(.+)$', output)
            if match:
                return match.group(1).strip()
        return "unknown"
    
    def bind_thread_to_cpu(self, tid, cpu):
        """绑定线程到指定 CPU"""
        # 检查权限
        if os.geteuid() != 0:
            return False, "需要 root 权限"
        
        output, rc = self.run_command(f"taskset -pc {cpu} {tid}")
        if rc == 0:
            return True, output
        return False, output
    
    def unbind_thread(self, tid):
        """解除线程绑定"""
        if os.geteuid() != 0:
            return False
        
        # 绑定到所有 CPU
        mask = ','.join(map(str, range(self.cpu_count)))
        output, rc = self.run_command(f"taskset -pc {mask} {tid}")
        return rc == 0
    
    def mode_top(self, args):
        """查看 top 进程模式"""
        top_procs = self.get_top_processes(args.count, args.duration)
        
        print("📊 Top {} 进程 (按 CPU 使用率排序):\n".format(len(top_procs)))
        print(f"{'PID':<10} {'Avg CPU%':<12} {'MEM%':<10} {'Command'}")
        print("-" * 80)
        
        for proc in top_procs:
            print(f"{proc['pid']:<10} {proc['avg_cpu']:<12.1f} {proc['mem']:<10.1f} {proc['command']}")
        
        print("\n" + "=" * 80)
        print("💡 请选择需要绑核的进程 PID，然后运行:")
        print(f"   python3 scripts/cpu_bind.py --mode analyze --pid <PID>")
        
        return top_procs
    
    def mode_analyze(self, args):
        """分析进程模式"""
        pid = args.pid
        
        print(f"\n🔍 分析进程 {pid} 的线程信息...\n")
        
        # 获取线程信息
        threads = self.get_process_threads(pid)
        
        if not threads:
            print(f"❌ 进程 {pid} 没有活跃线程或进程不存在")
            return None
        
        print(f"进程 {pid} 共有 {len(threads)} 个线程:\n")
        print(f"{'TID':<10} {'CPU%':<10} {'CPU Core':<10} {'Affinity':<20} {'Command'}")
        print("-" * 80)
        
        for t in threads:
            affinity = self.get_thread_affinity(t['tid'])
            print(f"{t['tid']:<10} {t['cpu']:<10.1f} {t['processor']:<10} {affinity:<20} {t['command']}")
        
        # 找出高 CPU 线程
        high_cpu_threads = sorted(threads, key=lambda x: x['cpu'], reverse=True)
        
        print("\n" + "=" * 80)
        print("🔥 高 CPU 线程 (建议绑核):")
        for i, t in enumerate(high_cpu_threads[:5]):
            print(f"   #{i+1} TID={t['tid']}, CPU={t['cpu']:.1f}%")
        
        print("\n💡 绑定高 CPU 线程，运行:")
        print(f"   sudo python3 scripts/cpu_bind.py --mode bind --pid {pid} --top-threads 3")
        
        return threads
    
    def mode_bind(self, args):
        """绑定线程模式"""
        pid = args.pid
        top_n = args.top_threads
        
        print(f"\n🔧 绑定进程 {pid} 的 top {top_n} 高 CPU 线程...\n")
        
        # 获取线程
        threads = self.get_process_threads(pid)
        if not threads:
            print(f"❌ 进程 {pid} 没有活跃线程或进程不存在")
            return False
        
        # 排序取 top N
        high_cpu_threads = sorted(threads, key=lambda x: x['cpu'], reverse=True)[:top_n]
        
        if not high_cpu_threads:
            print(f"❌ 没有找到活跃线程")
            return False
        
        # 检查 CPU 核心数
        if len(high_cpu_threads) > self.cpu_count:
            print(f"⚠️  线程数 ({len(high_cpu_threads)}) 超过 CPU 核心数 ({self.cpu_count})")
            high_cpu_threads = high_cpu_threads[:self.cpu_count]
        
        # 为每个线程分配独立的核心
        used_cpus = set()
        bindings = []
        
        for i, t in enumerate(high_cpu_threads):
            # 找一个未使用的核心
            available_cpu = None
            for cpu in range(self.cpu_count):
                if cpu not in used_cpus:
                    available_cpu = cpu
                    used_cpus.add(cpu)
                    break
            
            if available_cpu is not None:
                bindings.append({
                    'tid': t['tid'],
                    'cpu': available_cpu,
                    'old_cpu': t['processor'],
                    'cpu_usage': t['cpu']
                })
        
        # 执行绑定
        success_count = 0
        print(f"{'TID':<10} {'CPU%':<10} {'绑定到':<10} {'状态'}")
        print("-" * 50)
        
        for b in bindings:
            success, msg = self.bind_thread_to_cpu(b['tid'], b['cpu'])
            status = "✅ 成功" if success else f"❌ 失败: {msg}"
            print(f"{b['tid']:<10} {b['cpu_usage']:<10.1f} CPU {b['cpu']:<6} {status}")
            if success:
                success_count += 1
        
        print(f"\n{'='*50}")
        print(f"✅ 成功绑定 {success_count}/{len(bindings)} 个线程")
        
        if success_count > 0:
            print(f"\n💡 验证绑定结果:")
            print(f"   python3 scripts/cpu_bind.py --mode verify --pid {pid}")
        
        return success_count > 0
    
    def mode_verify(self, args):
        """验证绑定模式"""
        pid = args.pid
        
        print(f"\n✅ 验证进程 {pid} 的绑定状态...\n")
        
        threads = self.get_process_threads(pid)
        if not threads:
            print(f"❌ 进程 {pid} 没有活跃线程或进程不存在")
            return None
        
        print(f"{'TID':<10} {'CPU%':<10} {'Current':<10} {'Affinity':<20} {'Status'}")
        print("-" * 70)
        
        bound_count = 0
        for t in threads:
            affinity = self.get_thread_affinity(t['tid'])
            # 检查是否绑定到单核
            try:
                if affinity.isdigit() or (len(affinity) <= 2 and '-' not in affinity and ',' not in affinity):
                    is_bound = True
                    bound_count += 1
                else:
                    is_bound = False
            except:
                is_bound = False
            
            status = "🔒 已绑定" if is_bound else "🔄 未绑定"
            print(f"{t['tid']:<10} {t['cpu']:<10.1f} {t['processor']:<10} {affinity:<20} {status}")
        
        print(f"\n{'='*70}")
        print(f"绑定状态: {bound_count}/{len(threads)} 个线程已绑定")
        
        return threads
    
    def mode_unbind(self, args):
        """解除绑定模式"""
        pid = args.pid
        
        print(f"\n🔓 解除进程 {pid} 所有线程的绑定...\n")
        
        threads = self.get_process_threads(pid)
        if not threads:
            print(f"❌ 进程 {pid} 没有活跃线程或进程不存在")
            return False
        
        success_count = 0
        for t in threads:
            if self.unbind_thread(t['tid']):
                success_count += 1
                print(f"   TID {t['tid']}: ✅ 已解除绑定")
        
        print(f"\n✅ 解除了 {success_count}/{len(threads)} 个线程的绑定")
        return True


def main():
    parser = argparse.ArgumentParser(
        description='CPU-Bind: AI 机头场景专用绑核工具',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  # 查看 top 3 高 CPU 进程
  python3 scripts/cpu_bind.py --mode top
  
  # 分析进程 12345 的线程
  python3 scripts/cpu_bind.py --mode analyze --pid 12345
  
  # 绑定进程的 top 3 高 CPU 线程
  sudo python3 scripts/cpu_bind.py --mode bind --pid 12345 --top-threads 3
  
  # 验证绑定结果
  python3 scripts/cpu_bind.py --mode verify --pid 12345
  
  # 解除绑定
  sudo python3 scripts/cpu_bind.py --mode unbind --pid 12345
"""
    )
    
    parser.add_argument('--mode', '-m', required=True,
                       choices=['top', 'analyze', 'bind', 'verify', 'unbind'],
                       help='运行模式')
    parser.add_argument('--pid', '-p', type=int,
                       help='进程 PID')
    parser.add_argument('--count', '-c', type=int, default=3,
                       help='显示 top N 进程 (默认: 3)')
    parser.add_argument('--top-threads', '-t', type=int, default=3,
                       help='绑定 top N 高 CPU 线程 (默认: 3)')
    parser.add_argument('--duration', '-d', type=int, default=3,
                       help='采样时长秒数 (默认: 3)')
    parser.add_argument('--output', '-o',
                       help='输出报告文件')
    
    args = parser.parse_args()
    
    # 检查必要参数
    if args.mode in ['analyze', 'bind', 'verify', 'unbind'] and not args.pid:
        print(f"❌ 错误: --mode {args.mode} 需要指定 --pid")
        sys.exit(1)
    
    binder = CPUBinder()
    
    # 执行对应模式
    mode_map = {
        'top': binder.mode_top,
        'analyze': binder.mode_analyze,
        'bind': binder.mode_bind,
        'verify': binder.mode_verify,
        'unbind': binder.mode_unbind
    }
    
    if args.mode in mode_map:
        result = mode_map[args.mode](args)
        
        # 如果需要输出报告
        if args.output and result:
            with open(args.output, 'w') as f:
                json.dump(result, f, indent=2, default=str)
            print(f"\n📄 报告已保存到: {args.output}")


if __name__ == '__main__':
    main()
