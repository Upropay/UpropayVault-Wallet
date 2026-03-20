# 常见问题 (FAQ)

## 1. UV Vault 是开源的吗？
是的，UV Vault 核心代码采用 MIT 协议开源。

## 2. 如果我的电脑丢失了，我的资产还能找回吗？
只要您保存了助记词 (Mnemonic Phrase)，您的资产就安全。您可以在任何兼容 BIP-39 标准的钱包软件 (包括 UV Vault 的其他副本、MetaMask 等) 中导入您的助记词来找回资产。

## 3. 我的私钥存储在哪里？
您的私钥通过 AES-256 加密后，仅存储在您本地计算机的加密数据库中。它绝不会上传到我们的服务器或任何云端。

## 4. 为什么 UV Vault 需要密码？
该密码用于加密和解锁您的本地钱包数据库。如果您忘记了此密码，且没有备份助记词，您将永久失去对该钱包资产的访问权限。

## 5. UV Vault 支持哪些代币？
UV Vault 主要支持 Ethereum, BSC, TRON, Polygon 等主网的原生资产及其上的 ERC-20, BEP-20, TRC-20 代币 (如 USDT)。

## 6. 如何报告 Bug 或获取支持？
请在 [GitHub Issues](https://github.com/Upropay/UpropayVault-Wallet/issues) 中提交 Bug 报告，或加入我们的 Telegram 频道 [@upropay_wallet](https://t.me/upropay_wallet) 获取即时技术支持。
