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

sudo dnf install -y \
  fastfetch \
  clang \
  llvm \
  python3 \
  gh \
  uv \
  stow \
  ripgrep \
  fd-find \
  npm \
  starship \
  zoxide \
  fzf \
  bat \
  eza \
  neovim \
  tmux

echo "Installing opencode-ai..."
sudo npm i -g opencode-ai

echo "Setting up LazyVim..."
mkdir -p ~/.config
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
else
  echo "NeoVim configuration already exists, skipping LazyVim clone."
fi

echo "Stowing dotfiles..."
stow starship bash

echo "Setup complete! Please restart your terminal or run 'source ~/.bashrc' to apply your new configurations."
