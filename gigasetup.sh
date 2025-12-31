#!/bin/bash

# Quirks: For the usage of this script on mac it will only copy the gitupdate
#         and neovim config to the desired locations. The package downloading
#         is not currently configured. 
#

set -e

# Detects the OS you are using and you can set custom variables depending
if [[ "$OSTYPE" == "darwin"* ]]; then
    GITPATH="/usr/local/bin/"
    CONFIG_FILE="$HOME/.zshrc"
    OS="macOS"
    PKG_MANAGER="brew"
    PKG_UPDATE="brew update"
    PKG_INSTALL="brew install --quiet"
    SUDO=""
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CONFIG_FILE="$HOME/.bashrc"
    OS="Linux"
    if command -v apt-get >/dev/null 2>&1; then
        PKG_MANAGER="apt"
        PKG_UPDATE="sudo apt update"
        PKG_INSTALL="sudo apt install -y"
        SUDO="sudo"
    else
        echo "Unsupported Linux distribution (only Debian/Ubuntu family supported)"
        exit 1
    fi
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

echo "---Detected OS: $OS"

# Adds a built in beautified `ls` and `ls -la` command
# Add only if not present
if ! grep -q "alias ls='ls -GF'" "$CONFIG_FILE" 2>/dev/null; then
    {
        echo ""
        echo "# Enhanced ls (added by setup script)"
        echo "alias ls='ls -GF'"
        echo "alias ll='ls -lGFho'"
    } >> "$CONFIG_FILE"
    echo "→ Added improved ls aliases to $CONFIG_FILE"
else
    echo "---Aliases already in $CONFIG_FILE"
fi

# Copies gitupdate script to the OS specific bin directory
sudo cp gitupdate $GITPATH
echo "---gitupdate copied to $GITPATH"

# Copies the nvim config to the nvim config location on the OS
cp -r nvim ~/.config/
echo "---neovim config copied to ~/.config/"

PACKAGES=(
  imagemagick # Used for Image previews in neovim
#  python3.12-venv # Some plugins require this as a dep
  go
  golang-go # Required for go linters/formatters/and treesitter
  fdclone # No idea
  npm # Required to build some plugins for nvim
  curl # Normal dep
  ripgrep # Required for CTRL + L live grep functionality
  git # Obv
  htop # Fun
  cmatrix # Fun
)

NEEDED=()

for pkg in "${PACKAGES[@]}"; do
    if [[ $OS == "macOS" ]]; then
        # Homebrew check
        brew list "$pkg" >/dev/null 2>&1 || NEEDED+=("$pkg")
    else
        # apt check
        dpkg -s "$pkg" >/dev/null 2>&1 || NEEDED+=("$pkg")
    fi
done

if [ ${#NEEDED[@]} -gt 0 ]; then
    echo "--- Installing missing packages: ${NEEDED[*]}"
    $PKG_UPDATE
    $PKG_INSTALL "${NEEDED[@]}"
else
    echo "---All packages already installed..."
fi

# ── tree-sitter-cli (npm global) ────────────────────────────────────────────

if ! command -v tree-sitter &>/dev/null; then
    echo "--- Installing tree-sitter-cli..."
    $SUDO npm install -g tree-sitter-cli
else
    echo "---tree-sitter-cli is already installed, skipping..."
fi

echo ""
echo "--- Setup complete!"
