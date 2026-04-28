# ⚠️ ImageBuilder 限制说明

## 问题分析

### 核心问题
`luci-app-homeproxy` 不在 OpenWrt 官方仓库中，它在以下位置：
- ImmortalWrt 官方仓库
- kenzok8 第三方仓库

### ImageBuilder 的工作原理
ImageBuilder **不编译包**，只是组装预编译的包。它需要：
1. 包已经在仓库中存在
2. 包的架构匹配
3. 包的依赖都满足

## 解决方案

### 方案 1: 使用第三方源（已尝试）✅

在 workflow 中添加了 kenzok8 的源：
```yaml
EXTRA_REPOS: >-
  https://op.dllkids.xyz/packages/x86_64/packages.adb
  https://op.dllkids.xyz/luci/x86_64/packages.adb
```

**优点**:
- 快速（5-10分钟）
- 简单

**缺点**:
- 依赖第三方源的稳定性
- 可能存在包版本不匹配

### 方案 2: 使用 ImmortalWrt ImageBuilder（推荐）⭐

ImmortalWrt 是 OpenWrt 的分支，内置了 homeproxy。

**优点**:
- 官方支持 homeproxy
- 包版本匹配
- 更稳定

**缺点**:
- 不是官方 OpenWrt

**实现方式**:
修改 workflow 使用 ImmortalWrt 的 ImageBuilder：
```yaml
FILE_HOST: https://downloads.immortalwrt.org
VERSION: 24.10.0  # ImmortalWrt 版本
```

### 方案 3: 从源码编译（最可靠）

保留原来的 `openwrt-builder.yml`，虽然慢但最可靠。

**优点**:
- 完全控制
- 可以添加任何包
- 不依赖第三方源

**缺点**:
- 慢（2-4小时）
- 可能失败

### 方案 4: 混合方案（推荐用于生产）

1. 使用 ImageBuilder 生成基础固件（不含 homeproxy）
2. 首次启动后手动安装 homeproxy

**步骤**:
```bash
# 1. 构建基础固件（使用 ImageBuilder，5-10分钟）
# 2. 启动路由器
# 3. 添加 kenzok8 源
echo "src/gz kenzo https://op.dllkids.xyz/packages/x86_64" >> /etc/opkg/customfeeds.conf
echo "src/gz kenzo_luci https://op.dllkids.xyz/luci/x86_64" >> /etc/opkg/customfeeds.conf

# 4. 更新并安装
opkg update
opkg install luci-app-homeproxy luci-i18n-homeproxy-zh-cn
```

## 推荐方案

### 对于你的需求，我推荐：

**方案 2: 使用 ImmortalWrt ImageBuilder**

原因：
1. ✅ ImmortalWrt 内置 homeproxy
2. ✅ 官方支持，稳定可靠
3. ✅ 快速（5-10分钟）
4. ✅ ImmortalWrt 与 OpenWrt 高度兼容

### 如何切换到 ImmortalWrt

我可以为你创建一个新的 workflow，使用 ImmortalWrt 的 ImageBuilder。

## 当前状态

### 已修复
- ✅ 添加了 kenzok8 第三方源
- ⏳ 等待测试结果

### 如果失败
如果添加第三方源后仍然失败，建议：
1. 切换到 ImmortalWrt ImageBuilder
2. 或使用源码编译方案

## 下一步

请告诉我：
1. 是否尝试使用 ImmortalWrt？
2. 还是继续使用当前的第三方源方案？
3. 或者回到源码编译方案？

我会根据你的选择调整 workflow。
