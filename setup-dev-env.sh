#!/bin/bash

set -e

echo "🔧 安裝 Xcode Command Line Tools..."
xcode-select --install 2>/dev/null || echo "✅ 已安裝"

echo "🍺 安裝 Homebrew..."
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew 已安裝"
fi

echo "📦 安裝 Brewfile 套件..."
if ! brew bundle --file="$(dirname "$0")/Brewfile"; then
  echo "⚠️ [警告] Brewfile 安裝有錯，請檢查上方錯誤訊息修正再重新執行"
  echo "📦 👉 建議執行：brew bundle --file=... --verbose 來找錯誤"
fi

echo "🔠 安裝 Nerd Font 字體（Meslo）..."
brew install --cask font-meslo-lg-nerd-font || echo "⚠️ 字體安裝失敗，請手動安裝"

echo "🌀 安裝 Oh My Zsh..."
export ZSH="$HOME/.oh-my-zsh"
if [ ! -d "$ZSH" ]; then
  export RUNZSH=no
  export CHSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh 已安裝"
fi

echo "✨ 安裝 Powerlevel10k..."
if [ ! -d "${ZSH_CUSTOM:-$ZSH/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$ZSH/custom}/themes/powerlevel10k"
else
  echo "✅ Powerlevel10k 已安裝"
fi

echo "✨ 安裝 zsh-autosuggestions 插件..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
else
  echo "✅ zsh-autosuggestions 已安裝"
fi

echo "✨ 安裝 zsh-syntax-highlighting 插件..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
else
  echo "✅ zsh-syntax-highlighting 已安裝"
fi

echo "🔗 建立 symbolic links..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "$SCRIPT_DIR/.zshrc.template" "$HOME/.zshrc"
ln -sf "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$SCRIPT_DIR/.swiftlint.yml" "$HOME/.swiftlint.yml"

echo "🧩 匯入 VSCode 設定..."
mkdir -p "$HOME/Library/Application Support/Code/User"
cp "$(dirname "$0")/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
cp "$(dirname "$0")/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

echo "🔌 安裝 VSCode 擴充套件..."
if command -v code &> /dev/null; then
  cat "$(dirname "$0")/vscode/extensions.txt" | xargs -n 1 code --install-extension
else
  echo "⚠️ 找不到 'code' CLI，請手動從 VSCode 裝：Shell Command: Install 'code' command in PATH"
fi

echo "✅ 所有設定完成！請重新開啟 Terminal 並執行："
echo '   1. source "$HOME/.zshrc"'
echo '   2. p10k configure'
echo ""
