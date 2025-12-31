#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    GITPATH="/usr/local/bin/"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
    # Check for apt (Debian/Ubuntu family)
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


sudo cp gitupdate $GITPATH
echo "---gitupdate copied to $GITPATH"

cp -r nvim ~/.config/
echo "---neovim config copied to ~/.config/"

if [[ "$OSTYPE" == "darwin"* ]]; then
    exit 0
fi

PACKAGES=(
  imagemagick       # Used for Image previews in neovim
  python3.12-venv   # Some plugins require this as a dep
  golang-go         # Required for go linters/formatters/and treesitter
  fdclone           # No idea
  npm               # Required to build some plugins for nvim
  curl              # Normal dep
  ripgrep           # Required for CTRL + L live grep functionality
  git               # Obv
  htop              # Fun
  cmatrix           # Fun
)

NEEDED=()

for pkg in "${PACKAGES[@]}"; do
    dpkg -s "$pkg" >/dev/null 2>&1 || NEEDED+=("$pkg")
done

if [ ${#NEEDED[@]} -gt 0 ]; then
    sudo apt update
    sudo apt install -y "${NEEDED[@]}"
else
    echo "---All packages already installed..."
fi

# For the nvim config. Is a requirement for treesitter
if ! command -v tree-sitter &>/dev/null; then
    sudo npm install -g tree-sitter-cli
else
    echo "---tree-sitter-cli is already installed, skipping..."
fi


