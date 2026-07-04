#!/bin/bash

set -e

echo "Installing packages..."
sudo dnf install -y \
  7zip \
  bat \
  btop \
  clang \
  du-dust \
  eza \
  fastfetch \
  fd-find \
  ffmpeg \
  ffmpegthumbnailer \
  fzf \
  gh \
  google-roboto-fonts \
  helium-bin \
  jq \
  neovim \
  nerd-fonts \
  nodejs22 \
  python3 \
  ripgrep \
  starship \
  stow \
  tmux \
  uv \
  zoxide \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting
