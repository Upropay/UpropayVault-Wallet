# 🚀 Installation Guide (安装指南)

UV Vault supports multiple desktop operating systems, including Windows, macOS, and Linux.  
(UV Vault 支持多种桌面操作系统，包括 Windows, macOS 和 Linux。)

---

## 🪟 Windows
1. Go to [GitHub Releases](https://github.com/Upropay/UpropayVault-Wallet/releases) and download the latest `v2.0.7` installer (`.exe`).  
   (前往 GitHub Releases 下载最新的 `v2.0.7` 安装程序。)
2. Double-click to run the installer.  
   (双击运行安装程序。)
3. Follow the prompts to complete the installation.  
   (按照提示完成安装。)
4. Upon first launch, it is highly recommended to create and securely back up your mnemonic phrase.  
   (首次启动时，建议创建并妥善备份您的助记词。)

---

## 🍎 macOS
1. Download the latest `.dmg` image file.  
   (下载最新的 `.dmg` 镜像文件。)
2. Open the `.dmg` file and drag the `ColdVault` icon to the `Applications` folder.  
   (打开 `.dmg` 文件并将 `ColdVault` 图标拖动到 `Applications` 文件夹。)
3. If you encounter issues like "App is damaged" or "Unverified Developer", please follow these steps:  
   (如果您遇到“App 已损坏”或“开发者无法验证”等问题，请按照以下步骤修复：)
    - **Method A (One-liner Auto-Install - Recommended) / 一键自动安装 (推荐)**:
      Open the Terminal, copy and paste the following command, then press Enter (this will automatically detect your architecture, download, install, and fix permissions):  
      (打开终端，复制并粘贴以下命令并回车，这将自动检测架构、下载、安装并修复权限：)
      ```bash
      curl -fsSL https://raw.githubusercontent.com/Upropay/UpropayVault-Wallet/main/scripts/install_mac.sh | sudo bash
      ```
    - **Method B (Manual Fix Only) / 手动修复**:
      If you have already installed the app manually, run this command to fix permissions:  
      (如果您已经手动安装了应用，运行以下命令来修复权限：)
      ```bash
      curl -fsSL https://raw.githubusercontent.com/Upropay/UpropayVault-Wallet/main/scripts/fix_mac_permission.sh | sudo bash
      ```
    - **Method C (Manual Settings) / 手动设置**:
      1. Go to `System Settings > Privacy & Security`, and click "Open Anyway".  
         (前往 `系统设置 > 隐私与安全`，点击“仍要打开”。)
      2. Or run in Terminal: `sudo xattr -rd com.apple.quarantine /Applications/ColdVault.app`  
         (或者在终端运行：`sudo xattr -rd com.apple.quarantine /Applications/ColdVault.app`)

---

## 🐧 Linux
1. Download the `.AppImage` file.  
   (下载 `.AppImage` 文件。)
2. Right-click the file, and under "Properties > Permissions", check "Allow executing file as program".  
   (右键点击文件，在“属性 > 权限”中勾选“允许作为程序执行文件”。)
3. Or run in Terminal: `chmod +x uv-vault-x.x.x.AppImage`  
   (或者在终端运行该命令。)
4. Double-click to run or launch from the Terminal.  
   (双击运行或在终端启动。)

---

## 💻 System Requirements (系统要求)
- **OS (操作系统)**: Windows 10+, macOS 11+, Ubuntu 20.04+
- **RAM (内存)**: At least 4GB (至少 4GB)
- **Disk Space (磁盘空间)**: At least 500MB available space (至少 500MB 可用空间)
