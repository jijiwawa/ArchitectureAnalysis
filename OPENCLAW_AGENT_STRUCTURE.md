# OpenClaw Agent 目录结构说明

## 目录概览

```
workspace-coding/                  # Agent 工作区根目录
├── AGENTS.md                      # Agent 核心配置和行为准则
├── SOUL.md                        # Agent 人格和风格定义
├── IDENTITY.md                    # Agent 身份信息
├── USER.md                        # 用户信息
├── TOOLS.md                       # 工具配置和偏好
├── HEARTBEAT.md                   # 心跳任务配置
├── BOOTSTRAP.md                   # 首次运行初始化（可选）
├── MEMORY.md                      # 长期记忆（主会话专用）
├── memory/                        # 每日记忆目录
│   ├── YYYY-MM-DD.md              # 日期日志
│   └── *-state.json               # 状态追踪文件
└── skills/                        # 本地 Skills（可选）
```

---

## 核心文件说明

### 📋 AGENTS.md

**作用**: Agent 的核心配置文件，定义工作流程和行为准则

**内容**:
- 会话启动流程
- 记忆管理规则
- 工具使用规范
- 群聊行为准则
- 心跳任务说明
- 安全红线

**加载时机**: 作为系统提示词的一部分

---

### 🎭 SOUL.md

**作用**: 定义 Agent 的人格、语气和风格

**内容**:
- 核心价值观
- 行为风格
- 交流语气
- 人格特质

**加载时机**: 会话启动时第一步读取

**示例**:
```markdown
# SOUL.md - Who You Are

Be genuinely helpful, not performatively helpful.
Have opinions. Be resourceful before asking.
Earn trust through competence.
```

---

### 🆔 IDENTITY.md

**作用**: Agent 身份信息

**内容**:
- 名称
- 类型/角色
- 表情符号
- 职责描述

**示例**:
```markdown
# IDENTITY.md - Coding Agent

- **Name:** Codey
- **Creature:** AI 编程助手
- **Vibe:** 专业、高效、代码优先
- **Emoji:** 👨‍💻
- **Role:** BOSS 的编程助手
```

---

### 👤 USER.md

**作用**: 用户信息，帮助 Agent 理解服务对象

**内容**:
- 用户称呼
- 时区
- 位置
- 偏好和备注

**示例**:
```markdown
# USER.md - About Your Human

- **Name:** BOSS
- **Timezone:** Asia/Shanghai (GMT+8)
- **Location:** 深圳坂田
- **Notes:** 主 agent：克劳德（main）
```

---

### 🔧 TOOLS.md

**作用**: 工具和技能配置

**内容**:
- 环境配置
- 工具权限
- 已安装 Skills
- 当前项目信息
- 常用路径

---

### 💓 HEARTBEAT.md

**作用**: 心跳任务配置，定期汇报任务进度

**任务范围**:
- SIMD 优化开发
- 源码架构分析
- 代码开发与调试
- 性能优化
- Bug 修复
- 文档编写

**检查频率**: 每 30 分钟（有任务时）

**汇报内容**:
1. 当前任务名称和目标
2. 完成进度（百分比、当前阶段）
3. 已完成的工作
4. 遇到的问题
5. 需要的帮助（如有）
6. 下一步计划

**汇报格式**:
```
🔄 任务进度汇报 [YYYY-MM-DD HH:MM]

📋 当前任务: [任务名称]
📊 进度: [X]% - [当前阶段]

✅ 已完成:
- [已完成项1]
- [已完成项2]

🔄 进行中:
- [正在进行的项]

⚠️ 问题:
- [问题描述]

🆘 求助:
- [需要帮助的事项]（如有）

📅 下一步:
- [下一步计划]
```

**触发条件**:
- **启动**: 收到任务指令后开始心跳
- **停止**: 任务完成或无任务时不启动

**状态追踪**: `memory/task-state.json`

---

### 🚀 BOOTSTRAP.md

**作用**: 首次运行初始化文件

**行为**:
- 如果存在，首次会话时读取并执行
- 执行完成后应删除
- 用于一次性初始化任务

---

### 🧠 MEMORY.md

**作用**: Agent 的长期记忆

**重要规则**:
- **仅主会话加载** - 直接与用户聊天时
- **不在群聊加载** - 保护隐私
- 存储：重要决策、上下文、经验教训

**内容示例**:
```markdown
# MEMORY.md

## 项目
- pgvector NEON 优化已完成，4x 加速

## 偏好
- 代码简洁，避免过度分析
- 优先完成再汇报
```

---

## 📁 memory/ 目录

**作用**: 存储每日会话日志和状态

### YYYY-MM-DD.md

**作用**: 当日工作日志

**内容**:
- 会话记录
- 完成的任务
- 遇到的问题
- 重要决策

**示例**:
```markdown
# 2026-03-25

## 会话记录

### 16:32 - 阶段 1 完成
- 识别 10 个待优化接口
- BOSS 确认按优先级执行

### 20:15 - 测试通过
- float32 L2: 4x 加速
```

### *-state.json

**作用**: 任务状态追踪

**示例**:
```json
{
  "lastCheckTime": "2026-03-25T20:15:00+08:00",
  "currentPhase": 2,
  "completedTasks": ["half_distance", "bit_distance"],
  "issues": []
}
```

---

## 📁 skills/ 目录

**作用**: 存放本地自定义 Skills

**结构**:
```
skills/
└── skill-name/
    ├── SKILL.md          # Skill 主文件
    ├── scripts/          # 脚本文件
    ├── references/       # 参考文档
    └── assets/           # 资源文件
```

---

## 🔧 已安装 Skills 说明

### simd-optimizer

**位置**: `~/.openclaw/skills/simd-optimizer/`

**作用**: SIMD 优化开发工作流，用于将 C/C++ 原生代码优化为 NEON/SVE/SVE2 SIMD 版本

**触发场景**:
1. 用户要求进行 SIMD 优化
2. 将代码从 x86 移植到 ARM
3. 需要对比原生和 SIMD 版本的性能
4. 使用 gtest 测试 SIMD 实现

**目录结构**:
```
simd-optimizer/
├── SKILL.md                      # 主文档
├── references/
│   └── neon-patterns.md          # NEON/SVE 优化模式参考
└── assets/
    ├── gtest_template.cpp        # GTest 测试模板
    └── benchmark_template.cpp    # 性能基准测试模板
```

**工作流程（5 阶段）**:

| 阶段 | 任务 | 输出 |
|------|------|------|
| 1 | 识别待优化接口 | 接口清单、优化价值评估 |
| 2 | 实现 SIMD 版本 | `func_neon.c/h` |
| 3 | GTest 测试框架 | `func_test.cpp` |
| 4 | 功能正确性验证 | 测试通过报告 |
| 5 | 性能基准测试 | 性能对比数据、加速比 |

**使用示例**:
```
用户: 对 pgvector 的距离计算函数进行 NEON 优化

Agent 执行流程:
1. 扫描 src/vector.c，识别 VectorL2SquaredDistance 等 4 个接口
2. 实现 vector_distance_neon.c，包含 4 个 NEON 优化函数
3. 创建 test_all.cpp，构造测试数据
4. 运行测试，验证 native 和 neon 结果一致
5. 运行 benchmark，输出加速比（如 4.1x）
```

**输出物**:
1. **优化报告** (`simd_optimization_report.md`)
2. **SIMD 实现代码** (`func_neon.c/h`)
3. **测试代码** (`func_test.cpp`)

**性能预期**:
- float32 向量：3-6x 加速
- float16 向量（FP16 硬件）：7-14x 加速
- 位向量：1x（待优化）

---

### code-analysis（架构分析工具）

**说明**: 用于源码架构分析和 4+1 视图设计

**功能**:
1. 源码模块划分分析
2. 依赖关系梳理
3. 4+1 视图文档生成
4. SIMD 优化路径识别

**输出物**:
- `*_4plus1_view.md` - 架构分析文档
- `*_architecture_analysis.md` - 详细分析报告

**使用场景**:
- 分析开源项目架构
- 识别 SIMD 优化机会
- 生成设计文档

**示例输出**:
```
ArchitectureAnalysis/
├── pgvector/
│   ├── pgvector_4plus1_view.md          # 4+1 视图
│   └── pgvector-neon/                    # NEON 实现
│       └── docs/
│           ├── 4plus1_view.md
│           ├── interface_design.md
│           └── test_guide.md
├── sonic-cpp/
│   └── sonic_cpp_4plus1_view.md
└── uavs3e/
    └── uavs3e_realtime_4plus1_view.md
```

---

### auto-bind

**位置**: `ArchitectureAnalysis/skills/auto-bind/`

**作用**: 服务器应用自动绑核工具

**功能**:
- 网卡中断绑核
- 进程/线程 CPU 绑核
- NUMA 内存绑定

**使用场景**:
- 高性能计算优化
- 降低跨 NUMA 访问延迟
- 提升服务器应用性能

---

### cpu-bind

**位置**: `ArchitectureAnalysis/skills/cpu-bind/`

**作用**: AI 推理进程绑核工具

**功能**:
- 高 CPU 进程识别
- 线程分析
- 绑核建议

---

## 🔄 会话启动流程

```
1. 读取 SOUL.md      → 确定人格
2. 读取 USER.md      → 了解用户
3. 读取 memory/今日+yesterday.md → 获取近期上下文
4. 如果是主会话 → 读取 MEMORY.md
5. 如果存在 BOOTSTRAP.md → 执行并删除
6. 检查 HEARTBEAT.md → 如有任务，启动心跳汇报
```

---

## 📝 最佳实践

### 记忆管理
- 重要信息写入文件，不要"脑记"
- 每日日志记录关键事件
- 定期整理 MEMORY.md

### 文件命名
- 使用小写和连字符
- 日期格式：YYYY-MM-DD
- 状态文件：*-state.json

### 隐私保护
- MEMORY.md 仅主会话加载
- 敏感信息不写入群聊可见文件
- 遵守安全红线

### Skill 使用
1. 识别任务类型 → 匹配对应 Skill
2. 阅读 Skill 的 SKILL.md → 了解工作流程
3. 按阶段执行 → 生成输出物
4. 每 30 分钟汇报进度（长任务）

### 心跳汇报
- 有任务时每 30 分钟主动汇报
- 汇报内容：进度、问题、求助、下一步
- 无任务时不启动心跳

---

## 版本信息

- **文档版本**: v1.2
- **更新日期**: 2026-03-26
- **适用**: OpenClaw Agent 系统
