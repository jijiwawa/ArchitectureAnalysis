#!/usr/bin/env python3
"""
Test Suite - Auto-Bind 功能测试
"""

import os
import sys
import subprocess
from pathlib import Path


def run_test(name: str, cmd: str, expect_success: bool = True) -> bool:
    """运行测试"""
    print(f"\n🧪 Test: {name}")
    print(f"   Command: {cmd}")
    
    try:
        result = subprocess.run(
            cmd,
            shell=True,
            capture_output=True,
            text=True,
            timeout=10
        )
        
        success = result.returncode == 0 if expect_success else result.returncode != 0
        
        if success:
            print(f"   ✅ PASSED")
            if result.stdout:
                # 只显示前 5 行输出
                lines = result.stdout.strip().split('\n')[:5]
                for line in lines:
                    print(f"      {line}")
        else:
            print(f"   ❌ FAILED")
            if result.stderr:
                print(f"      Error: {result.stderr[:200]}")
        
        return success
    except Exception as e:
        print(f"   ❌ FAILED: {e}")
        return False


def main():
    print("🚀 Auto-Bind Test Suite")
    print("=" * 60)
    
    script_dir = Path(__file__).parent
    
    tests = [
        # 环境检测
        ("Environment Check", f"python3 {script_dir}/check_environment.py"),
        
        # 基础功能
        ("Check Mode", f"python3 {script_dir}/auto_bind.py --mode check"),
        ("Check with Report", f"python3 {script_dir}/auto_bind.py --mode check --output /tmp/test-report.md"),
        
        # 中断检查
        ("Interrupt Check", f"python3 {script_dir}/check_interrupts.py"),
        
        # NUMA 检查
        ("NUMA Topology", f"python3 {script_dir}/check_numa.py --topology"),
        
        # 绑定验证
        ("Binding Verification", f"python3 {script_dir}/verify_binding.py"),
        
        # Dry-run 测试
        ("Process Bind (Dry-run)", f"python3 {script_dir}/auto_bind.py --mode process --processes python3 --cpus 0-2 --dry-run"),
        
        # 帮助信息
        ("Help Message", f"python3 {script_dir}/auto_bind.py --help"),
    ]
    
    results = []
    for name, cmd in tests:
        success = run_test(name, cmd)
        results.append((name, success))
    
    # 总结
    print("\n" + "=" * 60)
    print("📊 Test Summary:\n")
    
    passed = sum(1 for _, success in results if success)
    total = len(results)
    
    for name, success in results:
        status = "✅" if success else "❌"
        print(f"  {status} {name}")
    
    print(f"\n总计: {passed}/{total} 测试通过")
    
    if passed == total:
        print("\n🎉 所有测试通过！Auto-Bind skill 工作正常。")
    else:
        print(f"\n⚠️  有 {total - passed} 个测试失败，请检查环境配置。")
    
    # 验证生成的报告
    report_path = Path("/tmp/test-report.md")
    if report_path.exists():
        print(f"\n📝 测试报告已生成: {report_path}")
        print(f"   大小: {report_path.stat().st_size} bytes")
    
    return passed == total


if __name__ == '__main__':
    success = main()
    sys.exit(0 if success else 1)
