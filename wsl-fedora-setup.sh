#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing packages..."
# Optimize DNF configuration
grep -q "^fastestmirror=True" /etc/dnf/dnf.conf || echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null
grep -q "^defaultyes=True" /etc/dnf/dnf.conf || echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null
grep -q "^keepcache=True" /etc/dnf/dnf.conf || echo "keepcache=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y lihaohong/yazi

sudo dnf install -y \
  7zip \
  bat \
  btop \
  clang \
  du-dust \
  eza \
  fastfetch \
  fd-find \
  ffmpeg-free \
  fzf \
  gh \
  jq \
  llvm \
  neovim \
  npm \
  poppler-utils \
  python3 \
  resvg \
  ripgrep \
  starship \
  stow \
  tmux \
  uv \
  yazi \
  zoxide \  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting
  
echo "Installing opencode-ai..."
if ! command -v opencode &>/dev/null; then
  sudo npm i -g opencode-ai
else
  echo "opencode-ai is already installed, skipping."
fi

echo "Setting up LazyVim..."
mkdir -p ~/.config
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
else
  echo "NeoVim configuration already exists, skipping LazyVim clone."
fi

echo "Cloning dotfiles..."
if [ ! -d "$HOME/dotfiles" ]; then
  git clone https://github.com/GilLesokhin/dotfiles.git ~/dotfiles
else
  echo "Dotfiles repository already exists, skipping clone."
fi

echo "Stowing dotfiles..."
cd ~/dotfiles && stow --adopt starship bash zsh bat opencode

echo "Installing zsh plugins..."
if [ ! -d "$HOME/.zsh/plugins/zsh-auto-notify" ]; then
  git clone https://github.com/MichaelAquilina/zsh-auto-notify ~/.zsh/plugins/zsh-auto-notify
fi
if [ ! -d "$HOME/.zsh/plugins/zsh-you-should-use" ]; then
  git clone https://github.com/MichaelAquilina/zsh-you-should-use ~/.zsh/plugins/zsh-you-should-use
fi
if [ ! -d "$HOME/.zsh/plugins/zsh-history-substring-search" ]; then
  git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/plugins/zsh-history-substring-search
fi
if [ ! -d "$HOME/.zsh/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/plugins/fzf-tab
fi

echo "Adding zsh to /etc/shells..."
grep -q "^$(which zsh)$" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells >/dev/null

echo "Setting zsh as default shell..."
sudo chsh -s "$(which zsh)" "$(whoami)"

echo "Setup complete! Please log out and back in for the shell change to take effect."
