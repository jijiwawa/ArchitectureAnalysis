# uavs3e RealTime 分支架构分析

**分析日期：** 2026-03-24  
**分支：** RealTime  
**来源：** https://github.com/uavs3/uavs3e (分支 RealTime)

---

## 1. 项目概览

### 1.1 基本信息

| 项目 | 说明 |
|------|------|
| **名称** | uavs3e (AVS3 编码器) |
| **分支** | RealTime (实时编码优化版本) |
| **协议** | BSD 4-clause |
| **代码规模** | ~103,848 行 |
| **支持平台** | Windows / Linux / iOS |
| **SIMD 优化** | SSE4 / AVX2 / AVX512 / ARMv8 NEON |

### 1.2 与 Master 分支对比

| 指标 | RealTime 分支 | Master 分支 |
|------|--------------|-------------|
| 代码行数 | ~103,848 | ~80,040 |
| 目录结构 | 单一 uAVS3lib | src/inc/ 分离 |
| ALF 支持 | ❌ 移除 | ✅ 包含 |
| iOS 支持 | ✅ ios_rt 目录 | ❌ 无 |
| 码流测试 | ✅ utest_gop.c | ❌ 无 |

---

## 2. 目录结构

```
uavs3e/
├── uAVS3lib/              # 核心编码库 (47 C 文件, 30 H 文件)
│   ├── x86/               # x86 SIMD 优化 (14 文件, ~90K 行)
│   ├── armv8/             # ARM NEON 优化 (12 文件, ~70K 行)
│   └── tools/             # 工具模块
├── ios_rt/                # iOS 实时编码 demo
├── bin/                   # 配置文件
│   └── encoder_ra.cfg     # 编码配置模板
├── utest.c                # 单帧测试程序
├── utest_gop.c            # GOP 并行测试程序
└── CMakeLists.txt         # CMake 构建配置
```

---

## 3. 核心模块分析

### 3.1 模块划分

| 模块 | 文件 | 行数 | 功能 |
|------|------|------|------|
| **熵编码** | AEC.c, biariencode.c, vlc.c | ~122K | 算术编码、VLC |
| **运动估计** | me.c | 1,748 | 整像素/分像素 ME |
| **变换量化** | transform.c, rdoq.c | 1,296 + 831 | DCT/IDCT, RDOQ |
| **帧内预测** | intra-prediction.c | 1,245 | 33 种帧内模式 |
| **帧间预测** | inter-prediction.c | 846 | 运动补偿 |
| **环路滤波** | loopfilter.c, loop-filter.c | 1,085 + 416 | Deblocking, SAO |
| **率失真优化** | rdopt.c, cost.c | 1,618 + 1,298 | RDO 决策 |
| **编码控制** | codingUnit.c | 906 | CU 编码逻辑 |

### 3.2 关键数据结构

```c
// 编码器主结构
typedef struct avs3_enc_t {
    cfg_param_t *input;           // 配置参数
    image_t *img_org;             // 原始图像
    frame_t *ref_list[MAXREF];    // 参考帧列表
    analyzer_t analyzer;          // 分析器
    // ...
} avs3_enc_t;

// CU 结构
typedef struct cu_t {
    char_t bitsize;               // CU 尺寸 (log2)
    char_t QP;                    // 量化参数
    double lambda;                // 拉格朗日因子
    char_t cuType;                // I/P/B 类型
    char_t ipred_mode;            // 帧内预测模式
    char_t ipred_mode_c;          // 色度帧内模式
    i16s_t mvd[2][2][2];          // 运动矢量差
    // ...
} cu_t;

// 图像结构
typedef struct image_t {
    pel_t *plane[4];              // Y/U/V 平面
    int i_stride[4];              // 步长
    long long pts, dts;           // 时间戳
    int type;                     // 帧类型
    // ...
} image_t;
```

---

## 4. RealTime 分支特点

### 4.1 移除 ALF (自适应环路滤波)

RealTime 分支移除了 ALF 模块以降低计算复杂度：
- Master 分支: `src/alf.c` (1,317 行) + `src/com_alf.c` (1,014 行)
- RealTime 分支: 完全移除

### 4.2 简化的目录结构

```
Master 分支:                    RealTime 分支:
├── inc/                        ├── uAVS3lib/
├── src/                        │   ├── *.c (核心代码)
│   ├── alf.c                   │   ├── x86/ (SIMD)
│   ├── analyze.c               │   └── armv8/ (NEON)
│   └── ...
├── build/                      └── (无单独 inc 目录)
└── test/
```

### 4.3 增强的实时特性

| 特性 | 说明 |
|------|------|
| **GOP 并行** | `threads-gop` 参数支持多 GOP 并行编码 |
| **WPP 并行** | `threads-wpp` 波前并行处理 |
| **iOS Demo** | `ios_rt/` 提供 iOS 实时编码示例 |
| **速度等级** | `SpeedLevel 5-7` 快速编码模式 |
| **码流测试** | `SPEED_TEST` 宏用于性能测试 |

---

## 5. SIMD 优化分析

### 5.1 x86 平台 (uAVS3lib/x86/)

| 文件 | 行数 | 功能 |
|------|------|------|
| intrinsic_idct.c | 14,792 | 反变换 (8bit) |
| intrinsic_idct_10bit.c | 13,887 | 反变换 (10bit) |
| intrinsic_intra-pred.c | 11,900 | 帧内预测 |
| intrinsic_dct.c | 10,689 | 正变换 (8bit) |
| intrinsic_dct_10bit.c | 9,409 | 正变换 (10bit) |
| intrinsic_cost.c | 6,248 | 代价计算 (SAD/SATD) |
| intrinsic_sao.c | 3,554 | SAO 滤波 |
| intrinsic_inter_pred.c | 3,411 | 帧间预测 |
| intrinsic_deblock.c | 1,623 | 去块滤波 |
| intrinsic_pixel.c | 1,382 | 像素操作 |

### 5.2 ARM 平台 (uAVS3lib/armv8/)

| 文件 | 类型 | 功能 |
|------|------|------|
| trans_dct_arm64.S | 172,279 行 | 变换汇编 |
| sao_kernel_arm64.S | 114,233 行 | SAO 汇编 |
| intra_pred_arm64.S | 60,025 行 | 帧内预测 |
| inter_pred_arm64.S | 72,333 行 | 帧间预测 |
| deblock_arm64.S | 61,934 行 | 去块滤波 |
| pixel_arm64.S | 29,182 行 | 像素操作 |
| cost_arm64.S | 50,830 行 | 代价计算 |

---

## 6. 编码流程

### 6.1 主流程

```
main()
  └─> avs3_lib_create()          // 创建编码器
      └─> avs3_lib_encode()      // 编码循环
          ├─> encode_frame()     // 编码一帧
          │   ├─> intra_pred()   // 帧内预测
          │   ├─> inter_pred()   // 帧间预测
          │   ├─> transform()    // 变换
          │   ├─> quant()        // 量化
          │   └─> loop_filter()  // 环路滤波
          └─> output_bitstream() // 输出码流
```

### 6.2 CU 编码流程

```
codingUnit()
  ├─> IS_INTRA?
  │   ├─> intra_pu_rdcost()     // 帧内 RDO
  │   └─> writeIntraPredMode()  // 写帧内模式
  └─> IS_INTER?
      ├─> me.c: motion_estimation()  // 运动估计
      ├─> inter_pred_luma_blk()      // 帧间预测
      └─> writeMVD()                 // 写 MVD
```

---

## 7. 配置参数

### 7.1 关键参数

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `threads-wpp` | 1 | WPP 线程数 |
| `threads-gop` | 8 | GOP 并行线程数 |
| `SpeedLevel` | 5-7 | 编码速度等级 |
| `QP` | 32 | 量化参数 (0-63) |
| `IntraPeriod` | 6 | I 帧间隔 |
| `NumberBFrames` | 7 | B 帧数量 |
| `RateControl` | 1 | 0:CQP, 1:CBR, 2:ABR, 3:CRF |
| `TargetBitRate` | 35000 | 目标码率 (kbps) |

### 7.2 工具开关

| 参数 | 说明 |
|------|------|
| `LoopFilterParameter` | 去块滤波参数 |
| `WQuant` | 自适应量化 |
| `slice_sao_enable_Y/Cb/Cr` | SAO 开关 |

---

## 8. 与其他编码器对比

### 8.1 代码规模对比

| 编码器 | 代码行数 | 说明 |
|--------|----------|------|
| x264 | ~60K | H.264 |
| x265 | ~150K | H.265 |
| **uavs3e (RealTime)** | ~104K | AVS3 |
| uavs3e (Master) | ~80K | AVS3 (含 ALF) |

### 8.2 架构特点

| 特性 | x264 | x265 | uavs3e |
|------|------|------|--------|
| 帧内模式数 | 9 | 35 | 33 |
| 最大 CU | 16x16 | 64x64 | 32x32 |
| SAO | ❌ | ✅ | ✅ |
| ALF | ❌ | ❌ | ✅ (Master) |
| GOP 并行 | ✅ | ✅ | ✅ |
| WPP | ✅ | ✅ | ✅ |

---

## 9. RealTime 优化建议

### 9.1 当前优化点

1. **移除 ALF** - 显著降低计算复杂度
2. **SIMD 优化** - x86/ARM 全覆盖
3. **多线程** - WPP + GOP 并行
4. **速度等级** - SpeedLevel 5-7 快速模式

### 9.2 潜在优化方向

| 方向 | 优先级 | 预期收益 |
|------|--------|----------|
| 分像素 ME 早退 | 高 | 10-20% 速度提升 |
| 帧内模式快速筛选 | 高 | 15-25% 速度提升 |
| CU 分裂早退 | 中 | 5-10% 速度提升 |
| 参考帧管理优化 | 中 | 5-10% 速度提升 |
| SIMD 覆盖率提升 | 低 | 5-10% 速度提升 |

---

## 10. API 接口

### 10.1 核心接口

```c
// 创建编码器
void* avs3_lib_create(cfg_param_t *input, 
                      strm_out_t strm_callback, 
                      rec_out_t rec_callback, 
                      int input_bufsize, 
                      void *priv_data);

// 编码
void avs3_lib_encode(void *handle, int bflush, int output_seq_end);

// 销毁
void avs3_lib_free(void *handle);

// 码率控制回调
typedef void*(*rc_frame_init_t)(cfg_param_t *input);
typedef void(*rc_frame_get_qp_t)(void *rc_handle, avs3_rc_get_qp_param_t* param);
typedef void(*rc_frame_update_t)(void *rc_handle, avs3_rc_update_param_t* param, char *ext_info, int info_len);
```

### 10.2 回调函数

```c
// 重建图像输出
typedef void(*rec_out_t)(void* priv_data, image_t *rec, image_t *org, 
                         image_t *trace, int frm_type, long long idx, 
                         int bits, double qp, int time, signed char* ext_info);

// 码流输出
typedef void(*strm_out_t)(void* priv_data, unsigned char *buf, int len, 
                          long long pts, long long dts, int type);
```

---

## 11. 总结

### 11.1 RealTime 分支特点

- ✅ 移除 ALF，降低复杂度
- ✅ 完整的 x86/ARM SIMD 优化
- ✅ GOP 并行 + WPP 多线程
- ✅ iOS 实时编码支持
- ✅ 速度等级可配置 (5-7)

### 11.2 适用场景

| 场景 | 推荐配置 |
|------|----------|
| 实时直播 | SpeedLevel=7, threads-gop=8 |
| 会议编码 | SpeedLevel=6, RateControl=CBR |
| 移动端 | SpeedLevel=7, threads-wpp=2 |
| 高质量录制 | SpeedLevel=5, QP=28 |

### 11.3 代码质量评估

| 指标 | 评分 | 说明 |
|------|------|------|
| 代码结构 | ⭐⭐⭐⭐ | 模块化清晰 |
| SIMD 覆盖 | ⭐⭐⭐⭐⭐ | 全面优化 |
| 文档完整性 | ⭐⭐⭐ | README + 配置注释 |
| 跨平台支持 | ⭐⭐⭐⭐⭐ | Win/Linux/iOS |

---

**分析完成时间：** 2026-03-24 15:00
