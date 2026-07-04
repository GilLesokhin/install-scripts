#!/bin/bash

set -e

echo "Configuring dnf..."
grep -q "^fastestmirror=True" /etc/dnf/dnf.conf || echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null
grep -q "^defaultyes=True" /etc/dnf/dnf.conf || echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null
grep -q "^keepcache=True" /etc/dnf/dnf.conf || echo "keepcache=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null

sudo dnf update -y
sudo dnf upgrade -y

echo "Enabling repositories..."
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y imput/helium
sudo dnf copr enable -y che/nerd-fonts

sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

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
  google-chrome-stable \
  gnome-tweaks \
  gparted \
  google-roboto-fonts \
  helium-bin \
  jq \
  neovim \
  nerd-fonts \
  nodejs22 \
  papirus-icon-theme \
  python3 \
  qbittorrent \
  ripgrep \
  starship \
  stow \
  tmux \
  uv \
  zoxide \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting

echo "Installing Zed..."
if ! command -v zed &>/dev/null; then
  curl -f https://zed.dev/install.sh | sh
else
  echo "Zed is already installed, skipping."
fi

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

echo "Setup complete! Please log out and back in for the shell change to take effect."
