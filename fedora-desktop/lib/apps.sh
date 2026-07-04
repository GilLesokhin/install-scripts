#!/bin/bash

set -e

echo "Installing Google Chrome..."
if ! command -v google-chrome-stable &>/dev/null; then
  sudo dnf install -y fedora-workstation-repositories
  sudo dnf config-manager --set-enabled google-chrome
  sudo dnf install -y google-chrome-stable
else
  echo "Google Chrome is already installed, skipping."
fi

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
