#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing packages..."
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
  bat \
  btop \
  du-dust \
  eza \
  fastfetch \
  fd-find \
  ffmpeg \
  fzf \
  gh \
  llvm \
  neovim \
  npm \
  ripgrep \
  starship \
  stow \
  tmux \
  zoxide \
  zsh

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
stow --dir ~/dotfiles --target ~ --adopt starship bash zsh bat opencode

echo "Installing zsh plugins..."
if [ ! -d "$HOME/.zsh/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/plugins/fzf-tab
fi

echo "Adding zsh to /etc/shells..."
grep -q "^$(which zsh)$" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells >/dev/null

echo "Setting zsh as default shell..."
sudo chsh -s "$(which zsh)" "$(whoami)"

echo "Setup complete! Please log out and back in for the shell change to apply."
