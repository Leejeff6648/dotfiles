# 🍎 dotfiles for iOS + Frontend Dev

這是一套專為 iOS / 前端開發者設計的 dotfiles，內容包括：
- Zsh + Oh My Zsh + Powerlevel10k 美化
- SwiftLint / XcodeGen / VSCode / NVM / Node
- 一鍵部署腳本 bootstrap.sh

## 🚀 快速安裝

```bash
git clone https://github.com/Leejeff6648/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup-dev-env.sh
./setup-dev-env.sh
---

## 📦 內容包含

```
dotfiles/
├── .zshrc.template         # zsh 終端設定模板
├── .gitconfig              # Git 使用者資訊與 alias 設定
├── .swiftlint.yml          # SwiftLint 設定檔
├── Brewfile                # 常用套件安裝清單（Homebrew）
├── bootstrap.sh            # 一鍵快速部署腳本
├── setup-dev-env.sh        # 安裝與環境配置主程式
├── vscode/
│   ├── settings.json       # VSCode 編輯器設定
│   └── keybindings.json    # VSCode 快捷鍵設定
├── fastlane/
│   └── Fastfile            # Fastlane 部署與自動化腳本
```

---

## 🚀 快速使用方式（適用於新機）

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/your-username/dotfiles/main/bootstrap.sh)
```

---

## 🔧 安裝內容說明

### Shell 與 CLI 工具

* 安裝 Homebrew
* 安裝 Zsh + Oh My Zsh + Powerlevel10k 主題
* 常用 CLI 工具：git, fzf, nvm, node, yarn, pnpm, swiftlint...
* 自動設定 `.zshrc` 與插件

### iOS 工程師工具

* 安裝 fastlane, xcodegen, swiftlint
* SwiftLint 預設遵循 Apple Swift Style Guide
* Fastlane 可自動化建構、打包、上傳 TestFlight 或 Deploy
* CocoaPods 可手動加入安裝

### VSCode 開發環境

* 自動安裝 VSCode Extensions（如 Prettier, 中文語言包, icon theme）
* 同步設定與快捷鍵

---

## 🧰 開發者可自訂內容

### 1. `.zshrc.template`

可自訂 alias、plugin、主題、環境變數等。

### 2. `Brewfile`

新增或刪除常用 CLI 工具、app，例如：

```bash
brew "httpie"
cask "postman"
```

### 3. `vscode/`

可擴充設定如 formatter、theme、tabSize、eslint/prettier...

### 4. `.swiftlint.yml`

```yaml
opt_in_rules:
  - empty_count
  - redundant_optional_initialization
  - force_unwrapping

excluded:
  - Carthage
  - Pods

line_length:
  warning: 120
  error: 150
  ignores_comments: true
  ignores_urls: true

force_cast:
  severity: warning

force_unwrapping:
  severity: warning

identifier_name:
  allowed_symbols: ["_"]
  excluded:
    - id
    - URL
```

### 5. `fastlane/Fastfile`

```ruby
default_platform(:ios)

platform :ios do
  desc "Build and upload to TestFlight"
  lane :beta do
    build_app(scheme: "YourApp")
    upload_to_testflight
  end

  desc "Submit to App Store"
  lane :release do
    capture_screenshots
    build_app(scheme: "YourApp")
    upload_to_app_store
  end
end
```

---

## 📝 建議補充

* 可搭配 GitHub 私有儲存 SSH/GPG 設定
* 可加入 `.npmrc`, `.tool-versions`, `.swiftlint.yml` 等其他工具設定
* 可結合 GitHub Actions 測試是否能正確佈署
* 建議搭配 Apple Code Signing 與 Keychain 自動解鎖腳本

---

## 📚 參考

* [https://dotfiles.github.io](https://dotfiles.github.io)
* [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [https://github.com/holman/dotfiles](https://github.com/holman/dotfiles)

---

> 本專案由你自己 fork 或客製，歡迎持續擴充！
