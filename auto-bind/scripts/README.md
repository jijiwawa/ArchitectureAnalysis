# Auto-Bind Scripts 使用说明

## 环境要求

### 必需命令
- `taskset` - 进程 CPU 绑核（大多数系统默认安装）
- `lscpu` - CPU 拓扑信息

### 可选命令（用于高级功能）
- `numactl` / `numastat` - NUMA 内存绑定（NUMA 系统）
- `perf` - 性能分析和跨 NUMA 访问检测

### 权限要求
- **检查模式** - 普通用户即可
- **绑核操作** - 需要 root 权限（sudo）

## 当前环境检测结果

### ✅ 可用功能
- CPU 拓扑检测
- 进程 CPU 占用分析
- taskset 进程绑核（需要 sudo）
- 中断检查（如果有硬件中断）

### ⚠️  限制
- **无 NUMA 支持** - 当前系统不支持 NUMA 或未安装 numactl
- **无 perf 支持** - 未安装 perf，无法检测跨 NUMA 访问

## 快速测试

```bash
# 1. 检查系统状态（不需要 sudo）
python3 auto_bind.py --mode check

# 2. 生成报告
python3 auto_bind.py --mode check --output report.md

# 3. 模拟绑核（dry-run）
python3 auto_bind.py --mode process --processes python3 --cpus 0-2 --dry-run

# 4. 实际绑核（需要 sudo）
sudo python3 auto_bind.py --mode process --processes python3 --cpus 0-2

# 5. 验证绑定
python3 verify_binding.py --process python3
```

## 在无 NUMA 环境下的使用

当前环境是单 NUMA 节点（或容器环境），主要使用：
- **进程绑核** - 将高 CPU 进程绑定到特定 CPU
- **中断绑核** - 如果有网卡中断，绑定到指定 CPU

NUMA 相关功能（numactl、numastat、perf）在多 NUMA 节点服务器上使用。

## 故障排查

### "Permission denied"
**原因：** 绑核操作需要 root 权限  
**解决：** 使用 `sudo` 运行命令

### "NUMA not supported"
**原因：** 系统不支持 NUMA 或未安装 numactl  
**解决：** 在单 NUMA 系统上，使用 taskset 进行 CPU 绑核即可

### "perf: command not found"
**原因：** 未安装 perf 工具  
**解决：** 
```bash
# Debian/Ubuntu
sudo apt-get install linux-perf

# CentOS/RHEL
sudo yum install perf
```

### "No NIC interrupts found"
**原因：** 容器环境通常没有硬件中断  
**解决：** 这是正常的，在物理服务器上会有网卡中断

## 目录结构

```
auto-bind/
├── SKILL.md                    # Skill 主文档
├── scripts/
│   ├── auto_bind.py           # 主脚本（整合所有功能）
│   ├── check_interrupts.py    # 检查网卡中断
│   ├── check_numa.py          # 检查 NUMA 内存分布
│   ├── verify_binding.py      # 验证绑定结果
│   └── README.md              # 本文档
└── references/
    ├── numa-guide.md          # NUMA 绑定指南
    └── best-practices.md      # 最佳实践
```
