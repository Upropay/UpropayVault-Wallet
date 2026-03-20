# 安装指南 (Installation Guide)

UV Vault 支持多种桌面操作系统，包括 Windows, macOS 和 Linux。

## Windows
1. 前往 [GitHub Releases](https://github.com/Upropay/UpropayVault-Wallet/releases) 下载最新的 `v2.0.7` 安装程序 (`.exe`)。
2. 双击运行安装程序。
3. 按照提示完成安装。
4. 首次启动时，建议创建并妥善备份您的助记词。

## macOS
1. 下载最新的 `.dmg` 镜像文件。
2. 打开 `.dmg` 文件并将 `UV Vault` 图标拖动到 `Applications` 文件夹。
3. 如果系统提示“由于无法验证开发者而无法打开”或“App 已损坏”，请按照以下步骤修复：
    - **方法 A (一键命令行修复 - 最快)**:
      打开终端，复制并粘贴以下命令并回车（系统会提示输入密码）：
      ```bash
      curl -fsSL https://raw.githubusercontent.com/Upropay/UpropayVault-Wallet/main/scripts/fix_mac_permission.sh | sudo bash
      ```
    - **方法 B (手动脚本修复)**:
      1. 下载 [fix_mac_permission.sh](../scripts/fix_mac_permission.sh)。
      2. 打开终端，运行：
         ```bash
         chmod +x fix_mac_permission.sh
         sudo ./fix_mac_permission.sh
         ```
    - **方法 B (手动修复)**:
      1. 前往 `系统设置 > 隐私与安全`，点击“仍要打开”。
      2. 或者在终端运行：`sudo xattr -rd com.apple.quarantine /Applications/UV\ Vault.app`

## Linux
1. 下载 `.AppImage` 文件。
2. 右键点击文件，在“属性 > 权限”中勾选“允许作为程序执行文件”。
3. 或者在终端运行：`chmod +x uv-vault-x.x.x.AppImage`。
4. 双击运行或在终端启动。

---

## 系统要求
- **操作系统**: Windows 10+, macOS 11+, Ubuntu 20.04+
- **内存**: 至少 4GB RAM
- **磁盘空间**: 至少 500MB 可用空间 (用于本地数据库存储)
