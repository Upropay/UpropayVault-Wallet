#!/bin/bash

# ==============================================================================
# UV Vault - macOS Automatic Installer & Fixer (macOS 自动安装与修复脚本)
# ==============================================================================
# 
# 1. Automatically detects system architecture (Intel/Apple Silicon).
#    (自动检测系统架构：Intel/Apple Silicon。)
# 2. Downloads the latest version from GitHub.
#    (从 GitHub 下载最新版本。)
# 3. Installs to /Applications.
#    (安装到 /Applications 目录。)
# 4. Fixes "App is damaged" or "Unverified Developer" issues.
#    (解决 macOS 上“App 已损坏”或“开发者无法验证”的问题。)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Upropay/UpropayVault-Wallet/main/scripts/install_mac.sh | sudo bash
# ==============================================================================

APP_NAME="UV Vault"
VERSION="2.0.7"
REPO="Upropay/UpropayVault-Wallet"
INSTALL_PATH="/Applications/${APP_NAME}.app"

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run with sudo: (请使用 sudo 运行此脚本:)"
  echo "sudo bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/${REPO}/main/scripts/install_mac.sh)\""
  exit 1
fi

echo "----------------------------------------------------------"
echo "Starting ${APP_NAME} Installation... (正在开始 ${APP_NAME} 安装...)"
echo "----------------------------------------------------------"

# 1. Architecture Detection
ARCH=$(uname -m)
echo "System Architecture detected: ${ARCH} (系统架构检测结果: ${ARCH})"

if [ "${ARCH}" == "arm64" ]; then
    # Apple Silicon (M1/M2/M3)
    FILENAME="UV-Vault-${VERSION}-mac-arm64.dmg"
elif [ "${ARCH}" == "x86_64" ]; then
    # Intel
    FILENAME="UV-Vault-${VERSION}-mac-x64.dmg"
else
    echo "❌ Error: Unsupported architecture ${ARCH}. (错误: 不支持的架构 ${ARCH}。)"
    exit 1
fi

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/v${VERSION}/${FILENAME}"
TMP_DMG="/tmp/${FILENAME}"

# 2. Download DMG
echo "1. Downloading ${FILENAME}... (正在下载 ${FILENAME}...)"
curl -L "${DOWNLOAD_URL}" -o "${TMP_DMG}"

if [ ! -f "${TMP_DMG}" ]; then
    echo "❌ Error: Download failed. Please check your network. (错误: 下载失败，请检查网络。)"
    exit 1
fi
echo "✅ Download complete. (下载完成。)"

# 3. Mount and Install
echo "2. Installing to /Applications... (正在安装到 /Applications...)"
MOUNT_POINT="/Volumes/${APP_NAME}_Installer"
hdiutil attach "${TMP_DMG}" -mountpoint "${MOUNT_POINT}" -quiet

if [ -d "${MOUNT_POINT}/${APP_NAME}.app" ]; then
    cp -R "${MOUNT_POINT}/${APP_NAME}.app" /Applications/
    echo "✅ Copy complete. (复制完成。)"
else
    echo "❌ Error: Could not find ${APP_NAME}.app in DMG. (错误: DMG 中找不到 ${APP_NAME}.app。)"
    hdiutil detach "${MOUNT_POINT}" -quiet
    rm "${TMP_DMG}"
    exit 1
fi

hdiutil detach "${MOUNT_POINT}" -quiet
rm "${TMP_DMG}"

# 4. Fix Permissions (Quarantine & Signature)
echo "3. Fixing permissions & Gatekeeper... (正在修复权限与 Gatekeeper...)"

if [ -d "${INSTALL_PATH}" ]; then
    # Remove Quarantine
    xattr -rd com.apple.quarantine "${INSTALL_PATH}" 2>/dev/null
    # Grant Execution Permissions
    chmod -R 755 "${INSTALL_PATH}"
    # Ad-hoc Sign
    codesign --force --deep --sign - "${INSTALL_PATH}" 2>/dev/null
    echo "✅ Permissions & local signature fixed. (权限与本地签名修复完成。)"
else
    echo "❌ Error: ${INSTALL_PATH} not found after copy. (错误: 复制后未找到 ${INSTALL_PATH}。)"
    exit 1
fi

echo "----------------------------------------------------------"
echo "🎉 Installation & Fix Complete! (安装与修复已完成！)"
echo "You can now open ${APP_NAME} from your Applications folder."
echo "(您现在可以从“应用程序”文件夹中打开 ${APP_NAME}。)"
echo "----------------------------------------------------------"
