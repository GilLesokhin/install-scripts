#!/bin/bash

set -e

echo "Enabling repositories..."
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y imput/helium
sudo dnf copr enable -y che/nerd-fonts

sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
