#!/bin/bash

set -e

echo "Configuring dnf..."
grep -q "^fastestmirror=True" /etc/dnf/dnf.conf || echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null
grep -q "^defaultyes=True" /etc/dnf/dnf.conf || echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null
grep -q "^keepcache=True" /etc/dnf/dnf.conf || echo "keepcache=True" | sudo tee -a /etc/dnf/dnf.conf >/dev/null

sudo dnf update -y
sudo dnf upgrade -y
