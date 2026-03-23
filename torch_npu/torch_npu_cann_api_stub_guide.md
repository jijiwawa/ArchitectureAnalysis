# torch_npu CANN API 打桩指南

## 快速开始

本指南专为需要对 torch_npu 算子下发过程中的 CANN API 调用进行打桩的开发者设计。

---

## 1. 算子下发关键路径

```
Python 调用
  ↓
NPUNativeOpApiFunctions::xxx()  [C++ ATen 层]
  ↓
EXEC_NPU_CMD(aclnnXxx, args...)  [宏展开]
  ↓
OpCommand::RunOpApiV3()  [框架层]
  ↓
aclnnXxxGetWorkspaceSize()  [CANN API]
aclnnXxx()                  [CANN API]
  ↓
NPU 硬件执行
```

---

## 2. 核心打桩点

### 打桩点 1: CANN API 封装层 (推荐)

**文件:** `torch_npu/csrc/core/npu/interface/AclInterface.h`  
**实现:** `torch_npu/csrc/core/npu/interface/AclInterface.cpp`

**优势:**
- 所有 CANN API 调用的统一入口
- 代码改动最小
- 捕获所有底层 API

**主要 API 列表:**

| API 类别 | 函数名 | 功能 |
|---------|-------|------|
| **运行时** | `AclrtCreateStreamWithConfig` | 创建 Stream |
| | `AclrtSynchronizeStreamWithTimeout` | 同步 Stream |
| | `AclrtCreateEventWithFlag` | 创建 Event |
| | `AclQueryEventWaitStatus` | 查询 Event 状态 |
| | `AclrtMallocAlign32` | 分配内存 |
| | `AclrtMemcpyBatchAsync` | 批量异步拷贝 |
| **设备** | `AclrtGetDeviceUtilizationRate` | 获取设备利用率 |
| | `AclrtGetSocName` | 获取 SoC 名称 |
| **Profile** | `AclProfilingInit` | 初始化 Profiling |
| | `start_deliver_op` | 开始算子下发 |
| | `stop_deliver_op` | 停止算子下发 |

### 打桩点 2: OpCommand 算子执行层

**文件:** `torch_npu/csrc/framework/OpCommand.cpp`

**关键方法:**
- `OpCommand::Run()` - 执行算子
- `OpCommand::RunOpApiV3()` - 执行 ACLNN API

**优势:**
- 捕获算子名称和参数
- 记录完整调用链

### 打桩点 3: ACLNN 算子调用点

**文件示例:**
- `torch_npu/csrc/aten/ops/op_api/CopyKernelOpApi.cpp`
- `torch_npu/csrc/custom_dtype/CastKernelTeOpApi.cpp`
- `torch_npu/csrc/aten/common/FormatCastKernelNpu.cpp`

**优势:**
- 精确捕获具体算子
- 记录算子参数详情

---

## 3. 打桩实现方案

### 方案 1: 简单日志打桩 (最简单)

#### 步骤 1: 创建打桩头文件

**文件:** `torch_npu/csrc/core/npu/stub/AclStub.h`

```cpp
#pragma once

#include <iostream>
#include <fstream>
#include <mutex>
#include <chrono>
#include <iomanip>
#include <sstream>

namespace c10_npu {
namespace stub {

class AclStubLogger {
public:
    static AclStubLogger& Instance() {
        static AclStubLogger instance;
        return instance;
    }

    void Log(const std::string& api_name, const std::string& params = "") {
        std::lock_guard<std::mutex> lock(mutex_);
        
        auto now = std::chrono::system_clock::now();
        auto timestamp = std::chrono::system_clock::to_time_t(now);
        auto ms = std::chrono::duration_cast<std::chrono::milliseconds>(
            now.time_since_epoch()) % 1000;

        std::stringstream ss;
        ss << std::put_time(std::localtime(&timestamp), "%Y-%m-%d %H:%M:%S");
        ss << '.' << std::setfill('0') << std::setw(3) << ms.count();

        log_file_ << "[" << ss.str() << "] "
                  << "[" << api_name << "] ";
        
        if (!params.empty()) {
            log_file_ << params;
        }
        
        log_file_ << std::endl;
        log_file_.flush();
    }

    void LogResult(const std::string& api_name, int result) {
        Log(api_name + "_RESULT", "return=" + std::to_string(result));
    }

private:
    AclStubLogger() {
        const char* log_file = std::getenv("ACL_STUB_LOG_FILE");
        std::string filename = log_file ? log_file : "/tmp/acl_stub.log";
        log_file_.open(filename, std::ios::app);
        log_file_ << "\n========== New Session ==========\n";
    }

    ~AclStubLogger() {
        if (log_file_.is_open()) {
            log_file_.close();
        }
    }

    std::ofstream log_file_;
    std::mutex mutex_;
};

} // namespace stub
} // namespace c10_npu

// 打桩宏
#define ACL_STUB_LOG(api, params) \
    c10_npu::stub::AclStubLogger::Instance().Log(api, params)

#define ACL_STUB_RESULT(api, result) \
    c10_npu::stub::AclStubLogger::Instance().LogResult(api, result)

// 简化宏
#define STUB_ENTER(api) ACL_STUB_LOG(api, "ENTER")
#define STUB_EXIT(api, result) ACL_STUB_RESULT(api, result)
```

#### 步骤 2: 在 AclInterface.cpp 中应用打桩

**文件:** `torch_npu/csrc/core/npu/interface/AclInterface.cpp`

```cpp
#include "torch_npu/csrc/core/npu/stub/AclStub.h"

namespace c10_npu {
namespace acl {

// Stream 相关 API 打桩
aclError AclrtCreateStreamWithConfig(aclrtStream *stream, 
                                      uint32_t priority, 
                                      uint32_t flag) {
    STUB_ENTER("AclrtCreateStreamWithConfig");
    ACL_STUB_LOG("AclrtCreateStreamWithConfig", 
                 "priority=" + std::to_string(priority) + 
                 ", flag=" + std::to_string(flag));
    
    aclError ret = ::aclrtCreateStreamWithConfig(stream, priority, flag);
    
    STUB_EXIT("AclrtCreateStreamWithConfig", ret);
    return ret;
}

aclError AclrtSynchronizeStreamWithTimeout(aclrtStream stream) {
    STUB_ENTER("AclrtSynchronizeStreamWithTimeout");
    ACL_STUB_LOG("AclrtSynchronizeStreamWithTimeout", 
                 "stream=" + std::to_string(reinterpret_cast<uintptr_t>(stream)));
    
    aclError ret = ::aclrtSynchronizeStream(stream);
    
    STUB_EXIT("AclrtSynchronizeStreamWithTimeout", ret);
    return ret;
}

// Event 相关 API 打桩
aclError AclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag) {
    STUB_ENTER("AclrtCreateEventWithFlag");
    ACL_STUB_LOG("AclrtCreateEventWithFlag", 
                 "flag=" + std::to_string(flag));
    
    aclError ret = ::aclrtCreateEventWithFlag(event, flag);
    
    STUB_EXIT("AclrtCreateEventWithFlag", ret);
    return ret;
}

aclError AclQueryEventWaitStatus(aclrtEvent event, 
                                  aclrtEventWaitStatus *waitStatus) {
    STUB_ENTER("AclQueryEventWaitStatus");
    
    aclError ret = ::aclrtQueryEventWaitStatus(event, waitStatus);
    
    ACL_STUB_LOG("AclQueryEventWaitStatus", 
                 "waitStatus=" + std::to_string(*waitStatus));
    STUB_EXIT("AclQueryEventWaitStatus", ret);
    return ret;
}

// 内存相关 API 打桩
aclError AclrtMallocAlign32(void **devPtr, 
                             size_t size, 
                             aclrtMemMallocPolicy policy) {
    STUB_ENTER("AclrtMallocAlign32");
    ACL_STUB_LOG("AclrtMallocAlign32", 
                 "size=" + std::to_string(size) + 
                 ", policy=" + std::to_string(static_cast<int>(policy)));
    
    aclError ret = ::aclrtMalloc(devPtr, size, policy);
    
    STUB_EXIT("AclrtMallocAlign32", ret);
    return ret;
}

// Profiling API 打桩
NpdStatus start_deliver_op(aclprofStepInfoPtr stepInfo, 
                           aclprofStepTag stepTag, 
                           aclrtStream stream) {
    STUB_ENTER("start_deliver_op");
    ACL_STUB_LOG("start_deliver_op", 
                 "stepTag=" + std::to_string(static_cast<int>(stepTag)));
    
    NpdStatus ret = ::aclprofStepStart(stepInfo, stepTag, stream);
    
    STUB_EXIT("start_deliver_op", ret);
    return ret;
}

NpdStatus stop_deliver_op(aclprofStepInfoPtr stepInfo, 
                          aclprofStepTag stepTag, 
                          aclrtStream stream) {
    STUB_ENTER("stop_deliver_op");
    ACL_STUB_LOG("stop_deliver_op", 
                 "stepTag=" + std::to_string(static_cast<int>(stepTag)));
    
    NpdStatus ret = ::aclprofStepStop(stepInfo, stepTag, stream);
    
    STUB_EXIT("stop_deliver_op", ret);
    return ret;
}

// ... 其他 API 类似添加

} // namespace acl
} // namespace c10_npu
```

#### 步骤 3: 编译和运行

```bash
# 编译 torch_npu
cd ~/projects/torch_npu
mkdir build && cd build
cmake ..
make -j8
make install

# 运行测试程序并记录日志
export ACL_STUB_LOG_FILE=/tmp/torch_npu_acl.log
python your_test_script.py

# 查看日志
cat /tmp/torch_npu_acl.log
```

### 方案 2: OpCommand 打桩 (详细)

#### 在 OpCommand.cpp 中添加打桩

**文件:** `torch_npu/csrc/framework/OpCommand.cpp`

```cpp
#include "torch_npu/csrc/core/npu/stub/AclStub.h"

namespace at_npu {
namespace native {

void OpCommand::Run() {
    // 打桩: 记录算子信息
    std::string op_info = "op_name=" + aclCmd->GetName() + 
                          ", inputs=" + std::to_string(inputTensor.size()) +
                          ", outputs=" + std::to_string(outputTensor.size());
    ACL_STUB_LOG("OpCommand::Run", op_info);
    
    // 执行真实逻辑
    aclCmd->Run();
    
    ACL_STUB_LOG("OpCommand::Run_COMPLETE", "");
}

// 静态方法打桩
void OpCommand::RunOpApiV3(const string &op_name, 
                           const PROC_FUNC &func, 
                           bool sync, 
                           c10_npu::NPUStream *task_stream) {
    std::string api_info = "op_name=" + op_name + 
                           ", sync=" + std::to_string(sync);
    ACL_STUB_LOG("RunOpApiV3", api_info);
    
    // 执行真实逻辑
    // ... 原有代码
    
    ACL_STUB_LOG("RunOpApiV3_COMPLETE", "");
}

} // namespace native
} // namespace at_npu
```

### 方案 3: 具体算子打桩 (精确)

#### 在算子实现文件中打桩

**示例:** `torch_npu/csrc/aten/ops/op_api/CopyKernelOpApi.cpp`

```cpp
#include "torch_npu/csrc/core/npu/stub/AclStub.h"

namespace at_npu {
namespace native {

void copy_d2d_baseformat_opapi(at::Tensor& dst, 
                                const at::Tensor& src, 
                                bool non_blocking) {
    // 打桩: 记录 Copy 算子信息
    std::stringstream ss;
    ss << "dst_shape=[";
    for (auto s : dst.sizes()) ss << s << ",";
    ss << "], src_shape=[";
    for (auto s : src.sizes()) ss << s << ",";
    ss << "], non_blocking=" << non_blocking;
    
    ACL_STUB_LOG("copy_d2d_baseformat_opapi", ss.str());
    
    // 执行 ACLNN 算子
    EXEC_NPU_CMD(aclnnInplaceCopy, dst, src);
    
    ACL_STUB_LOG("copy_d2d_baseformat_opapi_COMPLETE", "");
}

} // namespace native
} // namespace at_npu
```

---

## 4. 高级打桩技巧

### 4.1 条件打桩

```cpp
// 只打桩特定 API
#define ACL_STUB_CONDITIONAL(api, params) \
    do { \
        if (std::string(api).find("Stream") != std::string::npos) { \
            ACL_STUB_LOG(api, params); \
        } \
    } while(0)
```

### 4.2 性能统计

```cpp
class AclStubTimer {
public:
    AclStubTimer(const std::string& api) : api_(api), start_(std::chrono::high_resolution_clock::now()) {}
    
    ~AclStubTimer() {
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start_);
        ACL_STUB_LOG(api_ + "_DURATION", "duration_us=" + std::to_string(duration.count()));
    }

private:
    std::string api_;
    std::chrono::high_resolution_clock::point start_;
};

#define STUB_TIMER(api) AclStubTimer timer_##api(#api)
```

### 4.3 调用栈追踪

```cpp
#include <execinfo.h>

void PrintBacktrace() {
    void* buffer[100];
    int size = backtrace(buffer, 100);
    char** symbols = backtrace_symbols(buffer, size);
    
    ACL_STUB_LOG("BACKTRACE", "Call Stack:");
    for (int i = 0; i < size; ++i) {
        ACL_STUB_LOG("BACKTRACE_FRAME", std::to_string(i) + ": " + symbols[i]);
    }
    
    free(symbols);
}
```

---

## 5. 打桩数据分析

### 5.1 日志解析脚本

**文件:** `analyze_stub_log.py`

```python
#!/usr/bin/env python3
import re
from collections import defaultdict, Counter

def parse_log(log_file):
    """解析打桩日志"""
    pattern = r'\[(.*?)\] \[(.*?)\] (.*)'
    entries = []
    
    with open(log_file, 'r') as f:
        for line in f:
            match = re.match(pattern, line)
            if match:
                timestamp, api, params = match.groups()
                entries.append({
                    'timestamp': timestamp,
                    'api': api,
                    'params': params
                })
    
    return entries

def analyze_calls(entries):
    """分析 API 调用统计"""
    api_counter = Counter(entry['api'] for entry in entries)
    
    print("=== API 调用统计 ===")
    for api, count in api_counter.most_common(20):
        print(f"{api}: {count}")
    
    return api_counter

def analyze_call_chain(entries):
    """分析调用链"""
    print("\n=== 调用链示例 (前 10 个) ===")
    for i, entry in enumerate(entries[:10]):
        print(f"{i+1}. {entry['api']}: {entry['params']}")

def main():
    import sys
    log_file = sys.argv[1] if len(sys.argv) > 1 else '/tmp/acl_stub.log'
    
    entries = parse_log(log_file)
    print(f"总日志条目: {len(entries)}")
    
    api_counter = analyze_calls(entries)
    analyze_call_chain(entries)

if __name__ == '__main__':
    main()
```

**使用方法:**
```bash
python analyze_stub_log.py /tmp/torch_npu_acl.log
```

### 5.2 性能分析

```python
def analyze_performance(entries):
    """分析 API 调用性能"""
    api_durations = defaultdict(list)
    
    # 匹配 API 和对应的 _COMPLETE
    api_stacks = {}
    for entry in entries:
        api = entry['api']
        if api.endswith('_COMPLETE'):
            base_api = api.replace('_COMPLETE', '')
            if base_api in api_stacks:
                # 计算时间差 (简化，实际需要解析时间戳)
                duration = 10  # 示例
                api_durations[base_api].append(duration)
                del api_stacks[base_api]
        else:
            api_stacks[api] = entry['timestamp']
    
    print("\n=== API 性能统计 (平均耗时) ===")
    for api, durations in api_durations.items():
        avg_duration = sum(durations) / len(durations)
        print(f"{api}: avg={avg_duration:.2f}us, calls={len(durations)}")
```

---

## 6. 常见问题

### Q1: 打桩影响性能怎么办?

**解决方案:**
- 使用条件编译，只在调试时启用
- 使用采样打桩（只记录部分调用）
- 写入内存缓冲区，异步刷盘

### Q2: 如何只打桩特定算子?

**解决方案:**
```cpp
// 在打桩宏中添加过滤
#define ACL_STUB_FILTER(api, params) \
    do { \
        static const std::set<std::string> filter_apis = { \
            "AclrtCreateStreamWithConfig", \
            "start_deliver_op", \
            "copy_d2d_baseformat_opapi" \
        }; \
        if (filter_apis.count(api) > 0) { \
            ACL_STUB_LOG(api, params); \
        } \
    } while(0)
```

### Q3: 如何在运行时控制打桩?

**解决方案:**
```cpp
bool IsStubEnabled() {
    static bool enabled = std::getenv("ACL_STUB_ENABLE") != nullptr;
    return enabled;
}

#define ACL_STUB_RUNTIME(api, params) \
    do { \
        if (IsStubEnabled()) { \
            ACL_STUB_LOG(api, params); \
        } \
    } while(0)
```

---

## 7. 完整示例

### 示例: 打桩 Copy 算子的完整流程

#### 1. 修改 AclInterface.cpp

```cpp
#include "torch_npu/csrc/core/npu/stub/AclStub.h"

aclError AclrtMemcpyBatchAsync(void **dsts, size_t *destMax, void **srcs, 
                               size_t *sizes, size_t numBatches, 
                               aclrtMemcpyBatchAttr *attrs, 
                               size_t *attrsIndexes, size_t numAttrs, 
                               size_t *failIndex, aclrtStream stream) {
    STUB_ENTER("AclrtMemcpyBatchAsync");
    
    std::stringstream ss;
    ss << "numBatches=" << numBatches;
    for (size_t i = 0; i < numBatches; ++i) {
        ss << ", size[" << i << "]=" << sizes[i];
    }
    ACL_STUB_LOG("AclrtMemcpyBatchAsync", ss.str());
    
    aclError ret = ::aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, 
                                           numBatches, attrs, attrsIndexes, 
                                           numAttrs, failIndex, stream);
    
    STUB_EXIT("AclrtMemcpyBatchAsync", ret);
    return ret;
}
```

#### 2. 修改 CopyKernelOpApi.cpp

```cpp
#include "torch_npu/csrc/core/npu/stub/AclStub.h"

void copy_d2d_baseformat_opapi(at::Tensor& dst, 
                                const at::Tensor& src, 
                                bool non_blocking) {
    ACL_STUB_LOG("copy_d2d_baseformat_opapi", 
                 "dst_device=" + std::to_string(dst.device().index()) +
                 ", src_device=" + std::to_string(src.device().index()) +
                 ", size=" + std::to_string(dst.numel() * dst.element_size()));
    
    EXEC_NPU_CMD(aclnnInplaceCopy, dst, src);
    
    ACL_STUB_LOG("copy_d2d_baseformat_opapi_COMPLETE", "");
}
```

#### 3. 编译和测试

```bash
# 编译
cd ~/projects/torch_npu/build
cmake -DCMAKE_BUILD_TYPE=Debug ..
make -j8

# 运行测试
export ACL_STUB_ENABLE=1
export ACL_STUB_LOG_FILE=/tmp/copy_test.log
python test_copy.py

# 分析日志
python analyze_stub_log.py /tmp/copy_test.log
```

---

## 8. 总结

### 推荐打桩方案

**初学者:** 方案 1 (简单日志打桩)  
**进阶用户:** 方案 1 + 方案 2 (API + OpCommand)  
**专家用户:** 方案 1 + 2 + 3 (完整覆盖)

### 关键文件清单

| 文件 | 用途 | 优先级 |
|------|------|-------|
| `torch_npu/csrc/core/npu/interface/AclInterface.cpp` | CANN API 打桩 | ⭐⭐⭐⭐⭐ |
| `torch_npu/csrc/framework/OpCommand.cpp` | 算子执行打桩 | ⭐⭐⭐⭐ |
| `torch_npu/csrc/aten/ops/op_api/*.cpp` | 具体算子打桩 | ⭐⭐⭐ |

---

**生成时间:** 2026-03-22  
**文档路径:** `/home/node/.openclaw/workspace-coding/torch_npu_cann_api_stub_guide.md`
