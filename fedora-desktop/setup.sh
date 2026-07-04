#!/bin/bash

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

source "$DIR/lib/dnf.sh"
source "$DIR/lib/repos.sh"
source "$DIR/lib/packages.sh"
source "$DIR/lib/apps.sh"
source "$DIR/lib/desktop.sh"

echo "Setup complete! Please log out and back in for the shell change to take effect."
