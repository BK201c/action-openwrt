# 🚀 OpenWrt 快速构建指南

## 📋 方案选择

`main` 分支默认仅保留 **ImageBuilder 快速构建方案**。

### ⚡ 方案: 快速构建（推荐）

**文件**: `.github/workflows/openwrt-fast-imagebuilder.yml`

- **构建时间**: 5-10 分钟
- **成功率**: 高
- **适用**: 日常使用、快速部署

### 🔧 源码编译说明

源码编译工作流和相关文件已迁移到 `source` 分支。

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

编辑仓库根目录的 `imagebuilder-packages.txt`：

```text
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

如需第三方仓库，请在 workflow 中修改 ImageBuilder 的仓库配置步骤。

### 修改根文件系统大小

```yaml
ROOTFS_SIZE: 4096  # 单位：MB，默认 4GB
```

---

## 📊 性能对比

### 构建时间

| 操作 | ImageBuilder |
|------|--------------|
| 下载构建器 | 1-2分钟 |
| 解析包与组装镜像 | 4-8分钟 |
| **总计** | **5-10分钟** |

### 资源消耗

| 资源 | ImageBuilder |
|------|--------------|
| 磁盘空间 | <1GB |
| 内存 | <1GB |
| CPU | 低负载 |
| Actions 配额 | 极少消耗 |

---

## ❓ 常见问题

### Q: ImageBuilder 能修改默认 IP 吗？

A: 可以。通过 `files/etc/uci-defaults/` 脚本在首次启动时自动修改。

### Q: ImageBuilder 能添加自定义包吗？

A: 可以添加仓库中已存在的包。直接修改 `imagebuilder-packages.txt`。

如果仓库没有该包，先用 SDK/源码编译并放到可访问的软件源。

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
| 需要修改内核/源码 | 🔧 使用 `source` 分支 |

### 最佳实践

1. **日常使用 ImageBuilder** - 快速、稳定
2. **包管理放到 `imagebuilder-packages.txt`** - 维护简单
3. **需要源码级修改时切换 `source` 分支**

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
