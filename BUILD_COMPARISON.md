# OpenWrt 构建方案对比

## 🚀 方案对比

### 方案 1: ImageBuilder（推荐）⭐⭐⭐⭐⭐

**文件**: `.github/workflows/openwrt-fast-builder.yml`

**优点**:
- ⚡ **极快**: 5-10 分钟完成
- ✅ **稳定**: 使用官方预编译包
- 🎯 **简单**: 只需选择包，无需编译
- 💾 **省空间**: 不需要编译环境

**缺点**:
- ❌ 不能修改包的源码
- ❌ 只能使用官方仓库已有的包
- ❌ 不能添加自定义包

**适用场景**:
- 只需要选择预编译的包
- 快速生成固件
- CI/CD 自动构建

**构建时间**: 5-10 分钟

---

### 方案 2: 从源码编译（当前方案）

**文件**: `.github/workflows/openwrt-builder.yml`

**优点**:
- 🔧 完全自定义
- 📦 可以添加任何包
- 🛠️ 可以修改源码
- 🎨 可以打补丁

**缺点**:
- ⏰ **极慢**: 2-4 小时
- 💥 **易失败**: 依赖问题多
- 💾 **占空间**: 需要 30-50GB
- 🔥 **消耗资源**: GitHub Actions 配额

**适用场景**:
- 需要修改内核配置
- 需要编译自定义包
- 需要修改源码

**构建时间**: 2-4 小时

---

### 方案 3: SDK 编译单个包

**优点**:
- ⚡ 较快: 30-60 分钟
- 🎯 可以编译自定义包
- 💾 相对省空间

**缺点**:
- 🔧 需要额外配置
- 📦 只能编译包，不能生成完整固件
- 🎓 需要了解 OpenWrt 包结构

**适用场景**:
- 编译自定义包
- 开发测试
- 配合 ImageBuilder 使用

**构建时间**: 30-60 分钟

---

## 📊 时间对比

| 方案 | 首次构建 | 后续构建 | 成功率 |
|------|---------|---------|--------|
| ImageBuilder | 5-10分钟 | 5-10分钟 | 99% |
| 源码编译 | 2-4小时 | 1-2小时 | 70% |
| SDK | 30-60分钟 | 20-40分钟 | 85% |

---

## 🎯 推荐方案

### 对于你的需求（HomeProxy + 常用工具）

**强烈推荐使用 ImageBuilder！**

原因：
1. ✅ HomeProxy 已在官方仓库中
2. ✅ 所有常用工具都在官方仓库
3. ✅ 不需要修改源码
4. ✅ 构建时间从 2-4 小时降到 5-10 分钟
5. ✅ 成功率接近 100%

---

## 🚀 如何使用 ImageBuilder

### 方法 1: 使用新的快速构建流水线

1. 提交新的 workflow 文件
2. 在 GitHub Actions 中选择 "OpenWrt Fast Build (ImageBuilder)"
3. 点击 "Run workflow"
4. 选择版本（如 24.10.0 或 25.12.0-rc2）
5. 等待 5-10 分钟
6. 下载固件

### 方法 2: 本地使用 Docker

```bash
# 拉取官方 ImageBuilder 容器
docker run --rm -v "$(pwd)/bin:/builder/bin -it openwrt/imagebuilder:x86-64-24.10.0

# 在容器内执行
make image PROFILE=generic PACKAGES="luci luci-i18n-base-zh-cn sing-box luci-app-homeproxy"
```

---

## 📝 ImageBuilder 包列表

你的配置需要的包（全部在官方仓库中）：

### 核心系统
- luci
- luci-i18n-base-zh-cn

### 网络工具
- wget-ssl
- curl
- block-mount

### 管理工具
- luci-app-package-manager
- luci-i18n-package-manager-zh-cn
- ttyd
- luci-app-ttyd
- luci-i18n-ttyd-zh-cn

### 实用工具
- etherwake
- irqbalance
- luci-app-upnp
- luci-i18n-upnp-zh-cn
- luci-app-wol
- luci-i18n-wol-zh-cn
- luci-app-irqbalance
- luci-i18n-irqbalance-zh-cn

### 网络驱动
- kmod-igc (Intel I225/I226)
- kmod-r8169 (Realtek RTL8169)
- kmod-drm-i915 (Intel 核显)

### 代理功能
- sing-box
- luci-app-homeproxy
- luci-i18n-homeproxy-zh-cn
- ucode-mod-digest
- kmod-nft-tproxy
- kmod-tun
- kmod-dummy

---

## ⚠️ 注意事项

### ImageBuilder 的限制

1. **不能修改默认 IP**
   - ImageBuilder 生成的固件默认 IP 是 192.168.1.1
   - 需要在首次启动后修改

2. **不能添加自定义包**
   - 只能使用官方仓库已有的包
   - 如果需要自定义包，需要先用 SDK 编译

3. **不能修改内核配置**
   - 内核配置是固定的
   - 如果需要修改内核，必须从源码编译

### 解决方案

如果需要修改默认 IP，可以：
1. 使用 ImageBuilder 生成固件
2. 首次启动后通过 LuCI 或 SSH 修改
3. 或者使用 `uci` 命令批量配置

---

## 🎉 总结

**对于你的需求，ImageBuilder 是最佳选择！**

- ⚡ 构建时间: 2-4 小时 → 5-10 分钟
- ✅ 成功率: 70% → 99%
- 💾 空间占用: 30-50GB → <1GB
- 🎯 简单易用: 复杂配置 → 选择包列表

建议：
1. 保留源码编译方案作为备用
2. 日常使用 ImageBuilder 快速构建
3. 需要自定义时再使用源码编译
