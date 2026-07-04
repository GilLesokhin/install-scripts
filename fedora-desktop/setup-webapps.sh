#!/bin/bash

set -e

APPS_DIR="$HOME/.local/share/applications"
ICONS_DIR="$HOME/.local/share/icons/hicolor/48x48/apps"

BROWSER=""

choose_browser() {
  if command -v google-chrome-stable &>/dev/null; then
    BROWSER="google-chrome-stable"
  elif command -v helium &>/dev/null; then
    BROWSER="helium"
  else
    echo "Error: neither google-chrome-stable nor helium found."
    echo "Install one of them first, then re-run this script."
    exit 1
  fi
  echo "Using: $BROWSER"
}

install_webapp() {
  local name="$1"
  local url="$2"
  local id="$3"

  mkdir -p "$APPS_DIR" "$ICONS_DIR"

  cat > "$APPS_DIR/$id.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$name
Exec=$BROWSER --app=$url
Icon=$id
Terminal=false
Categories=Network;WebBrowser;
StartupNotify=true
EOF

  chmod +x "$APPS_DIR/$id.desktop"

  # download icon from Google's favicon service
  curl -sf "https://www.google.com/s2/favicons?sz=48&domain_url=$url" \
    -o "$ICONS_DIR/$id.png" 2>/dev/null || true

  echo "  ✓ $name → $APPS_DIR/$id.desktop"
}

choose_browser

echo "Installing web apps..."
install_webapp "Google Calendar" "https://calendar.google.com" "google-calendar"
install_webapp "Gmail" "https://mail.google.com" "gmail"
install_webapp "Google Docs" "https://docs.google.com" "google-docs"

echo
echo "Done! Apps will appear in GNOME after you log out and back in,"
echo "or run:  update-desktop-database ~/.local/share/applications"
