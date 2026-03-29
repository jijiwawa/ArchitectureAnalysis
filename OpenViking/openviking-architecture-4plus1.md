# OpenViking 软件架构分析（4+1 视图）

> 版本：v0.2（补充性能/过程视图/优化点）
> 目标：在 v0.1 基础上补齐性能线索、过程视图细节与可执行优化点。

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

当前文档可引用的性能线索（定性）：
- **毫秒级延迟** 支持高并发检索（团队能力描述）。
- `binding-client` 模式：AGFS 在 Python 进程内运行，**极高性能、零网络延迟**。
- FAQ 建议：批量导入比单次导入更高效；本地存储/异步客户端降低延迟。

当前文档可用于量化性能的“指标来源”：
- **Operation Telemetry** 可返回结构化耗时指标：
  - `summary.duration_ms`
  - `summary.vector.scanned/scored/returned`
  - `summary.resource.process.parse/summarize/finalize.duration_ms`
  - `summary.memory.extract.*`（分阶段耗时）
- 这些字段可直接形成性能报告（QPS/Latency/阶段耗时对比）。

缺失：
- 公开的 QPS/延迟/吞吐 benchmark（目前无官方公开数据）。

建议后续补充：
- 用 telemetry 做基准实验：资源导入、检索、session.commit 端到端耗时曲线。
- 对比不同存储后端（local / s3 / remote agfs）性能差异。

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
  - 目录递归检索算法（递归搜索 + rerank + hotness）

- `openviking/session/*`
  - session 压缩、记忆抽取、去重逻辑

---

## 4. 过程视图（Process View）

### 4.1 运行时组件

- **OpenViking Server**（FastAPI）
- **AGFS**（本地或远程 / binding-client / http-client）
- **VectorDB**（本地或远程）
- **QueueFS + Semantic Processor**（异步语义处理）
- **Rerank 服务（可选）**
- **TaskTracker**（异步任务跟踪，内存态）

### 4.2 核心处理链路（细化）

#### A. add_resource（资源导入）

```
HTTP/SDK → ResourceService → ResourceProcessor
    → Parser（No LLM）
    → TreeBuilder（move temp → AGFS）
    → SemanticQueue（L0/L1 异步生成）
    → EmbeddingQueue / Vector Index
```

- Parser 与 LLM 解耦，LLM 仅在语义摘要阶段调用。
- SemanticQueue 为底向上处理（Leaf → Parent）。
- Telemetry 可直接记录解析/摘要/向量化耗时。

#### B. search/find（检索链路）

```
Query → IntentAnalyzer(可选)
      → Global Vector Search
      → Hierarchical Recursive Search
      → (Optional) Rerank
      → MatchedContext
```

- `search()` 使用 LLM 生成多 TypedQuery；`find()` 低延迟直查。
- HierarchicalRetriever 具备收敛机制、候选 score 传播、topk 控制。

#### C. session.commit（记忆提交流程）

```
Phase1: Archive (sync) → Phase2: Memory Extract (async) → SemanticQueue
```

- Phase1: 归档消息 + 清理当前消息（无锁，快速返回）
- Phase2: RedoLog + 记忆抽取 + 写入 + enqueue（支持 crash recovery）

### 4.3 一致性/容错机制

- **Path Lock**：POINT / SUBTREE / MV 锁（保证路径级一致性）
- **RedoLog**：仅用于 session.commit 的 crash recovery（幂等恢复）
- **QueueFS**：语义生成任务持久化，重启可恢复
- **TaskTracker**：后台任务状态可查询（内存态，TTL 清理）

### 4.4 可观测性（性能/链路）

- Telemetry：`duration_ms` + `vector` + `resource` + `memory` 分阶段指标
- Prometheus：`/metrics` 导出，便于 Grafana
- 可基于 Telemetry 做性能评估基线

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

### 5.3 配置与性能模式（补充）

- **AGFS 模式**：
  - `http-client`（默认，连接外部 AGFS 服务）
  - `binding-client`（高性能，AGFS 直接在进程内运行）
- **Storage Backend**：local / s3 / memory

---

## 6. 服务器侧潜在优化点（增强版）

### 6.1 性能与可扩展性

1. **Rerank 触发策略优化**
   - 现状：`search()` 默认 THINKING 会触发 rerank
   - 风险：高并发下 rerank 延迟放大
   - 优化：引入 **基于置信度/候选数的动态 rerank**（低置信度才触发）

2. **QueueFS 处理瓶颈（语义生成）**
   - 现状：异步队列处理，单一队列粒度
   - 优化：
     - 分级队列（资源/记忆/技能）
     - 优先级调度（用户请求优先，后台 watch 次之）
     - 结合 telemetry 进行队列拥塞自适应

3. **Embedding/LLM 并发上限**
   - 现状：max_concurrent_llm / embedding 固定
   - 优化：通过 Telemetry 动态调整并发（峰值时降级）

4. **Storage Backend 性能基线**
   - 现状：缺少本地/远端/s3 系统对比基准
   - 优化：基于 Telemetry 出具基准报告

### 6.2 稳定性与隔离

5. **TaskTracker 持久化**
   - 现状：内存态任务跟踪，重启丢失
   - 优化：落盘（轻量化本地 KV / QueueFS 持久化）

6. **多租户限流与资源配额**
   - 现状：基于 account/user/agent 隔离，但无配额
   - 优化：
     - tenant 级 QPS/并发限制
     - 资源占用配额（storage/embedding token）

### 6.3 可观测性与诊断

7. **Retrieval Trace 输出标准化**
   - 现状：轨迹日志存在，但缺统一格式
   - 优化：标准 JSON Trace（可视化 UI 展示）

8. **Telemetry + Prometheus 联动**
   - 现状：有 telemetry 字段，但缺可视化模板
   - 优化：提供 Grafana dashboard + PromQL 示例

---

## 7. 后续补充计划

- 补齐 **性能基准数据**（QPS/Latency/Throughput）。
- 补充 **社区真实案例**（GitHub / Discord / 公开客户）。
- 细化 **进程/线程模型** 与 **资源生命周期**。

---

## 8. 参考来源

- README.md
- docs/en/concepts/01-architecture.md
- docs/en/concepts/06-extraction.md
- docs/en/concepts/07-retrieval.md
- docs/en/concepts/08-session.md
- docs/en/concepts/09-transaction.md
- docs/en/concepts/11-multi-tenant.md
- docs/en/guides/03-deployment.md
- docs/en/guides/07-operation-telemetry.md
- openviking/server/app.py
- openviking/service/core.py
- openviking/service/resource_service.py
- openviking/retrieve/hierarchical_retriever.py
- openviking/session/session.py
- openviking/service/task_tracker.py
