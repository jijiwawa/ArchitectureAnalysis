# OpenViking 软件架构分析（4+1 视图）

> 版本：v0.1（快速交付版）
> 目标：基于仓库 README + docs + 代码结构，输出可交付的 4+1 视图初稿，并列出服务器侧潜在优化点。

---

## 0. 背景与范围

**OpenViking** 是面向 AI Agents 的开源 Context Database（上下文数据库），提供统一的“文件系统式”上下文管理范式，将 **Memory / Resource / Skill** 统一到虚拟文件系统中，并提供 **分层语义摘要（L0/L1/L2）**、**递归检索**、**会话记忆压缩** 等核心能力。

本文档覆盖：
- 4+1 视图：用例视图、逻辑视图、开发视图、过程视图、物理视图。
- 重点强调 **OpenViking Server** 端架构（服务端能力、依赖、部署）。
- 识别 **服务器侧潜在优化点**。

---

## 1. 用例视图（+1 View）

### 1.1 典型使用方式（Use Cases）

1. **Agent 记忆托管**
   - 场景：对话型 Agent 长期运行，记忆快速膨胀。
   - 使用：`session.add_message()` + `session.commit()` 触发异步压缩、抽取记忆。
   - 价值：避免上下文爆炸，实现记忆自迭代。

2. **知识/资源统一管理**
   - 场景：业务文档、代码仓库、FAQ 分散在不同系统。
   - 使用：`add_resource()` 导入本地/远程资源，统一到 `viking://resources/`。
   - 价值：让 Agent 像管理文件一样管理上下文。

3. **技能/工具索引与使用**
   - 场景：Agent 有多种工具/能力，难以统一管理。
   - 使用：将工具/技能组织在 `viking://agent/skills/`。
   - 价值：统一技能组织与检索。

4. **可观察的检索路径**
   - 场景：RAG 结果不稳定，难以解释检索过程。
   - 使用：目录递归检索 + 可视化轨迹。
   - 价值：提升检索透明度和可调试性。

### 1.2 典型客户/采用情况（可获取信息）

> 当前仓库公开文档未披露具体企业客户清单；但在 **团队/历史** 描述中提及：
- VikingDB 在 ByteDance 内部被广泛使用（2019–2023）。
- 2024 年 Viking 产品矩阵已支持 **“成千上万企业客户”**（Volcano Engine 公有云）。
- OpenViking 作为 2026 年新开源项目，处于社区发展早期阶段。

建议后续补充：
- 社区真实案例（GitHub Issues / Discussions / 社区分享）。
- 企业白皮书或公开案例（如有）。

### 1.3 性能相关数据（当前可获取）

文档中提到：
- **毫秒级延迟** 支持高并发检索（团队能力描述）。
- `binding-client` 模式：AGFS 在 Python 进程内运行，**极高性能、零网络延迟**。

缺失：
- 公开的 QPS/延迟/吞吐 benchmark。
- 服务器端在不同存储后端的性能对比。

建议后续补充：
- 通过 `docs/en/guides/07-operation-telemetry.md` 中的指标字段构建性能报告。

---

## 2. 逻辑视图（Logical View）

### 2.1 核心模块划分

来自 `docs/en/concepts/01-architecture.md`：

- **Client**：统一入口，封装操作接口。
- **Service Layer**：业务逻辑聚合（FSService / SearchService / SessionService / ResourceService 等）。
- **Retrieve**：意图分析 + 层级检索 + rerank。
- **Session**：会话管理，消息记录/压缩/记忆抽取。
- **Parse**：内容解析 + 语义摘要构建。
- **Compressor**：记忆压缩与去重。
- **Storage**：AGFS + Vector Index（双层存储）。

### 2.2 关键逻辑流程

#### 1) 资源导入流程

```
Input → Parser → TreeBuilder → AGFS → SemanticQueue → Vector Index
```

- Parser：构建目录结构（不调用 LLM）
- TreeBuilder：将临时目录写入 AGFS
- SemanticQueue：异步生成 L0/L1
- Vector Index：存向量索引

#### 2) 检索流程

```
Query → IntentAnalysis → HierarchicalRetrieval → Rerank → Results
```

- search(): LLM 生成 TypedQuery
- find(): 轻量查询，无意图分析
- 目录递归：逐层深入，保留轨迹

#### 3) 会话记忆流

```
Messages → Compress → Archive → Memory Extract → Storage
```

- commit() 分两阶段（同步归档 + 异步记忆抽取）

---

## 3. 开发视图（Development View）

### 3.1 代码结构（Top-level）

- `openviking/`：核心 Python SDK + 服务端实现
- `openviking/server/`：FastAPI Server
- `openviking/service/`：业务服务层
- `openviking/retrieve/`：检索相关
- `openviking/session/`：会话压缩与记忆抽取
- `openviking/storage/`：VikingFS / VectorDB 管理
- `src/`：C++ 核心扩展（向量索引相关）
- `crates/ov_cli/`：Rust CLI

### 3.2 关键类与模块

- `OpenVikingService`：服务端核心聚合类
  - 内部组合 FS / Search / Session / Resource / Pack / Debug 等子服务
  - 初始化 AGFS / VectorDB / Queue / LockManager

- `openviking/server/app.py`
  - FastAPI 应用入口
  - 注册 routers（resources / search / sessions / filesystem / admin / debug...）

- `openviking/retrieve/hierarchical_retriever.py`
  - 目录递归检索算法

- `openviking/session/*`
  - session 压缩、记忆抽取、去重逻辑

---

## 4. 过程视图（Process View）

### 4.1 运行时组件

- **OpenViking Server**（FastAPI）
- **AGFS**（本地或远程）
- **VectorDB**（本地或远程）
- **QueueFS + Semantic Processor**（异步语义处理）
- **Rerank 服务（可选）**

### 4.2 关键并发/异步机制

- `QueueManager` 管理语义生成队列
- `Session.commit()` 后台异步生成 L0/L1 + 记忆抽取
- Retrieval 流程：vector recall + rerank

### 4.3 可观测性

- `/metrics` 支持 Prometheus 指标
- `telemetry` 指标记录资源处理、记忆抽取延迟等

---

## 5. 物理视图（Physical/Deployment View）

### 5.1 部署模式

1. **Embedded Mode**
   - 本地单进程，快速开发

2. **HTTP Server Mode**
   - `openviking-server` 独立服务
   - 多客户端连接

3. **Docker / Docker Compose**
   - `docker run` / `docker compose up`

4. **K8s / Helm**
   - `examples/k8s-helm/`

### 5.2 运行组件部署拓扑（简化）

```
[Client SDK/CLI]
        |
        v
[OpenViking Server]
   |         |
[AGFS]   [VectorDB]
   |
[Storage Workspace]
```

---

## 6. 服务器侧潜在优化点（初版）

### 6.1 性能与可扩展性

1. **Rerank 调用策略优化**
   - 当前 search 默认 THINKING 时触发 rerank，可能增加延迟
   - 优化：加入动态阈值或采样 rerank

2. **QueueFS 处理瓶颈**
   - 异步语义生成依赖队列
   - 优化：分级队列 + 并发控制 + 优先级调度

3. **AGFS 存储后端**
   - 本地模式性能高，但扩展性弱
   - 优化：提供标准化 benchmark，对比 remote AGFS

### 6.2 稳定性与隔离

4. **多租户隔离加强**
   - 目前依赖 account/user/agent 逻辑隔离
   - 优化：更严格的 tenant-aware ACL / token

5. **请求级限流与隔离**
   - 现有服务无明显限流逻辑
   - 优化：引入速率限制 / tenant quota

### 6.3 可观测性与诊断

6. **Retrieval Trace 可视化增强**
   - 已保留轨迹，但缺可视化工具集成
   - 优化：输出 JSON trace + UI 展示

7. **Telemetry 数据统一导出**
   - 现有 telemetry 指标丰富，但缺统一分析面板
   - 优化：提供 Grafana 模板

---

## 7. 后续补充计划

- 补齐 **性能基准数据**（QPS/Latency/Throughput）。
- 补充 **社区真实案例**（GitHub / Discord / 公开客户）。
- 细化 **进程/线程模型** 与 **资源生命周期**。

---

## 8. 参考来源

- README.md
- docs/en/concepts/01-architecture.md
- docs/en/concepts/07-retrieval.md
- docs/en/concepts/08-session.md
- docs/en/guides/03-deployment.md
- openviking/server/app.py
- openviking/service/core.py
