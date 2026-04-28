# 🚀 OpenWrt 快速构建指南

## 📋 方案选择

你现在有 **两个构建方案**：

### ⚡ 方案 1: 快速构建（推荐）

**文件**: `.github/workflows/openwrt-fast-builder.yml`

- **构建时间**: 5-10 分钟
- **成功率**: 99%
- **适用**: 日常使用、快速部署

### 🔧 方案 2: 完整编译（备用）

**文件**: `.github/workflows/openwrt-builder.yml`

- **构建时间**: 2-4 小时
- **成功率**: 70%
- **适用**: 需要深度自定义

---

## 🎯 快速开始

### 步骤 1: 提交代码

```bash
git add .
git commit -m "Add fast build workflow using ImageBuilder"
git push
```

### 步骤 2: 触发构建

1. 打开你的 GitHub 仓库
2. 点击 **Actions** 标签
3. 选择 **OpenWrt Fast Build (ImageBuilder)**
4. 点击 **Run workflow**
5. 选择版本：
   - `24.10.0` - 最新稳定版
   - `25.12.0-rc2` - 候选版本
   - `snapshots` - 开发版
6. 点击 **Run workflow**

### 步骤 3: 等待完成

- ⏱️ 预计时间: 5-10 分钟
- 📊 可以查看实时日志
- ✅ 完成后会收到通知

### 步骤 4: 下载固件

构建完成后，可以从以下位置下载：

1. **Artifacts** (保留 90 天)
   - 在 workflow 运行页面下载
   - 文件名: `OpenWrt-{version}-x86-64`

2. **Releases** (保留最新 3 个)
   - 在仓库的 Releases 页面下载
   - 包含详细的发布说明

---

## 📦 固件内容

### 核心功能
- ✅ LuCI Web 管理界面（中文）
- ✅ HomeProxy 代理平台（基于 sing-box）
- ✅ 防火墙（firewall4 + nftables）
- ✅ 透明代理支持

### 管理工具
- ✅ TTYD Web 终端
- ✅ 包管理器
- ✅ UPnP
- ✅ 网络唤醒（WOL）
- ✅ IRQ 负载均衡

### 网络驱动
- ✅ Intel I225/I226 (igc)
- ✅ Realtek RTL8169
- ✅ Intel 核显支持

---

## ⚙️ 自定义配置

### 修改包列表

编辑 `.github/workflows/openwrt-fast-builder.yml` 中的 `PACKAGES` 变量：

```yaml
PACKAGES: >-
  luci
  luci-i18n-base-zh-cn
  # 添加你需要的包
  vim
  htop
  tmux
```

### 查看可用包

访问 OpenWrt 官方包仓库：
- https://downloads.openwrt.org/releases/24.10.0/packages/x86_64/packages/

### 修改版本

在触发构建时选择不同版本，或修改默认值：

```yaml
default: '24.10.0'  # 改为你想要的版本
```

---

## 🔧 高级配置

### 使用第三方软件源

如果需要使用第三方包（如 kenzok8 的源），需要：

1. 添加 `EXTRA_REPOS` 环境变量
2. 添加 `PUBLIC_KEY_VERIFY` 用于验证

示例：
```yaml
EXTRA_REPOS: >-
  https://raw.githubusercontent.com/kenzok8/openwrt-packages/refs/heads/main/x86_64/packages/packages.adb
PUBLIC_KEY_VERIFY: "你的公钥（base64编码）"
```

### 修改根文件系统大小

```yaml
ROOTFS_SIZE: 4096  # 单位：MB，默认 4GB
```

---

## 📊 性能对比

### 构建时间

| 操作 | 源码编译 | ImageBuilder |
|------|---------|--------------|
| 初始化环境 | 5-10分钟 | 0分钟 |
| 下载源码 | 5-10分钟 | 0分钟 |
| 编译工具链 | 30-60分钟 | 0分钟 |
| 编译包 | 60-120分钟 | 0分钟 |
| 生成镜像 | 5-10分钟 | 5-10分钟 |
| **总计** | **2-4小时** | **5-10分钟** |

### 资源消耗

| 资源 | 源码编译 | ImageBuilder |
|------|---------|--------------|
| 磁盘空间 | 30-50GB | <1GB |
| 内存 | 4-8GB | <1GB |
| CPU | 高负载 | 低负载 |
| Actions 配额 | 大量消耗 | 极少消耗 |

---

## ❓ 常见问题

### Q: ImageBuilder 能修改默认 IP 吗？

A: 不能。ImageBuilder 生成的固件默认 IP 固定为 192.168.1.1。

**解决方案**:
1. 首次启动后通过 LuCI 修改
2. 使用 SSH 命令修改：
   ```bash
   uci set network.lan.ipaddr='192.168.21.1'
   uci commit network
   /etc/init.d/network restart
   ```

### Q: ImageBuilder 能添加自定义包吗？

A: 不能直接添加。需要先用 SDK 编译自定义包，然后添加到仓库。

**解决方案**:
1. 使用 SDK 编译自定义包
2. 托管到自己的软件源
3. 在 ImageBuilder 中添加 `EXTRA_REPOS`

### Q: 为什么选择 24.10.0 而不是 25.12？

A: 24.10.0 是当前稳定版，25.12 还是候选版本（RC）。

**建议**:
- 生产环境: 使用 24.10.0
- 测试环境: 可以尝试 25.12.0-rc2

### Q: 构建失败怎么办？

A: ImageBuilder 失败率极低，如果失败：

1. 检查包名是否正确
2. 检查版本是否存在
3. 查看 workflow 日志
4. 尝试使用稳定版本（24.10.0）

---

## 🎉 总结

### 推荐使用场景

| 场景 | 推荐方案 |
|------|---------|
| 日常使用 | ⚡ ImageBuilder |
| 快速部署 | ⚡ ImageBuilder |
| CI/CD 自动构建 | ⚡ ImageBuilder |
| 需要自定义包 | 🔧 SDK + ImageBuilder |
| 需要修改内核 | 🔧 源码编译 |
| 需要修改源码 | 🔧 源码编译 |

### 最佳实践

1. **日常使用 ImageBuilder** - 快速、稳定
2. **保留源码编译方案** - 作为备用
3. **需要自定义时再用源码编译** - 按需选择

---

## 📚 相关资源

- [OpenWrt 官方文档](https://openwrt.org/docs/guide-user)
- [ImageBuilder 文档](https://openwrt.org/docs/guide-user/additional-tools/imagebuilder)
- [OpenWrt Docker](https://github.com/openwrt/docker)
- [gh-action-imagebuilder](https://github.com/fantastic-packages/gh-action-imagebuilder)

---

## 🚀 立即开始

```bash
# 1. 提交代码
git add .
git commit -m "Add fast build workflow"
git push

# 2. 在 GitHub Actions 中触发构建
# 3. 等待 5-10 分钟
# 4. 下载固件
```

就是这么简单！🎉
