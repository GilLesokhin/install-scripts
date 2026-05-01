#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Enabling universe repository..."
sudo apt-add-repository universe -y

echo "Updating package lists..."
sudo apt update

echo "Upgrading system..."
sudo apt upgrade -y

echo "Installing packages..."
sudo apt install -y \
  fastfetch \
  clang \
  llvm \
  python3 \
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

echo "Installing gh..."
sudo snap install gh

echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

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
cd ~/dotfiles && stow starship bash

echo "Setup complete! Please restart your terminal or run 'source ~/.bashrc' to apply your new configurations."
