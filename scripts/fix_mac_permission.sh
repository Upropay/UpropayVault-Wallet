#!/bin/bash

# ==============================================================================
# UV Vault - macOS Permission & Signature Fixer (macOS 权限与签名修复脚本)
# ==============================================================================
# 
# Fixes "App is damaged" or "Unverified Developer" issues on macOS.
# (解决 macOS 上“App 已损坏”或“开发者无法验证”的问题。)
#
# Usage:
#   chmod +x fix_mac_permission.sh
#   ./fix_mac_permission.sh
# ==============================================================================

APP_NAME="UV Vault"
APP_PATH="/Applications/${APP_NAME}.app"

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run with sudo: (请使用 sudo 运行此脚本:)"
  echo "sudo $0"
  exit 1
fi

echo "----------------------------------------------------------"
echo "Fixing permissions for ${APP_NAME}... (正在为 ${APP_NAME} 修复权限...)"
echo "----------------------------------------------------------"

# 1. Check if app exists
if [ ! -d "$APP_PATH" ]; then
    echo "❌ Error: ${APP_NAME} not found in /Applications. Please install the app first."
    echo "❌ 错误: 未在 /Applications 中找到 ${APP_NAME}。请先安装应用。"
    exit 1
fi

# 2. Remove Quarantine Attribute (Gatekeeper)
echo "1. Removing macOS quarantine attribute... (移除 macOS 隔离属性...)"
xattr -rd com.apple.quarantine "$APP_PATH"
if [ $? -eq 0 ]; then
    echo "✅ Quarantine attribute removed successfully. (隔离属性已成功移除。)"
else
    echo "⚠️ Failed to remove quarantine attribute, it might not exist. (移除隔离属性失败，可能该属性已不存在。)"
fi

# 3. Grant Permissions Recursively
echo "2. Granting execution permissions... (授予执行权限...)"
chmod -R 755 "$APP_PATH"
echo "✅ Permissions updated. (权限已更新。)"

# 4. Perform Local Ad-hoc Signing
echo "3. Re-signing locally (this may take a few seconds)... (正在进行本地签名...)"
codesign --force --deep --sign - "$APP_PATH"
if [ $? -eq 0 ]; then
    echo "✅ Local signing completed successfully. (本地签名成功完成。)"
else
    echo "❌ Signing failed. Ensure Command Line Tools are installed (xcode-select --install)."
    echo "❌ 签名失败。请确保您已安装 Command Line Tools。"
fi

echo "----------------------------------------------------------"
echo "🎉 Fix complete! You can now try to open ${APP_NAME}."
echo "🎉 修复完成！您现在可以尝试打开 ${APP_NAME} 了。"
echo "----------------------------------------------------------"
