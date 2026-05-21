#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing packages..."
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
  fastfetch \
  clang \
  llvm \
  python3 \
  gh \
  stow \
  ripgrep \
  fd-find \
  npm \
  zoxide \
  fzf \
  bat \
  eza \
  starship \
  neovim \
  tmux


echo "Installing opencode-ai..."
if ! command -v opencode &> /dev/null; then
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
cd ~/dotfiles && stow --adopt starship bash

echo "Setup complete! Please restart your terminal or run 'source ~/.bashrc' to apply your new configurations."
