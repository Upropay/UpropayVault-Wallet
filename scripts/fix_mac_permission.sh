#!/bin/bash

# ==============================================================================
# UV Vault - macOS 权限与签名修复脚本 (macOS Permission & Signature Fixer)
# ==============================================================================
# 
# 解决 macOS 上“App 已损坏”或“开发者无法验证”的问题。
# Fixes "App is damaged" or "Unverified Developer" issues on macOS.
#
# Usage:
#   chmod +x fix_mac_permission.sh
#   ./fix_mac_permission.sh
# ==============================================================================

APP_NAME="UV Vault"
APP_PATH="/Applications/${APP_NAME}.app"

# 检查是否以 sudo 运行
if [ "$EUID" -ne 0 ]; then
  echo "请使用 sudo 运行此脚本 / Please run with sudo:"
  echo "sudo $0"
  exit 1
fi

echo "----------------------------------------------------------"
echo "正在为 ${APP_NAME} 修复权限... (Fixing permissions for ${APP_NAME}...)"
echo "----------------------------------------------------------"

# 1. 检查应用是否存在
if [ ! -d "$APP_PATH" ]; then
    echo "❌ 错误: 未在 /Applications 中找到 ${APP_NAME}。请先安装应用。"
    echo "❌ Error: ${APP_NAME} not found in /Applications. Please install the app first."
    exit 1
fi

# 2. 移除隔离属性 (Gatekeeper)
echo "1. 移除 macOS 隔离属性... (Removing quarantine attribute...)"
xattr -rd com.apple.quarantine "$APP_PATH"
if [ $? -eq 0 ]; then
    echo "✅ 隔离属性已成功移除。"
else
    echo "⚠️ 移除隔离属性失败，可能该属性已不存在。"
fi

# 3. 递归授予权限
echo "2. 授予执行权限... (Granting execution permissions...)"
chmod -R 755 "$APP_PATH"
echo "✅ 权限已更新。"

# 4. 重新进行本地签名 (ad-hoc signing)
echo "3. 正在进行本地签名 (此步骤可能需要几秒钟)... (Re-signing locally...)"
codesign --force --deep --sign - "$APP_PATH"
if [ $? -eq 0 ]; then
    echo "✅ 本地签名成功完成。"
else
    echo "❌ 签名失败。请确保您已安装 Command Line Tools (xcode-select --install)。"
fi

echo "----------------------------------------------------------"
echo "🎉 修复完成！您现在可以尝试打开 ${APP_NAME} 了。"
echo "🎉 Fix complete! You can now try to open ${APP_NAME}."
echo "----------------------------------------------------------"
