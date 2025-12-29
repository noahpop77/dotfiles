#!/bin/bash

set -e

sudo cp gitupdate /usr/bin/
echo "---gitupdate copied to /usr/bin/"

cp -r nvim ~/.config/
echo "---neovim config copied to ~/.config/"

PACKAGES=(
  npm
  curl
  ripgrep
  git
  htop
  cmatrix
)

NEEDED=()

for pkg in "${PACKAGES[@]}"; do
    dpkg -s "$pkg" >/dev/null 2>&1 || NEEDED+=("$pkg")
done

if [ ${#NEEDED[@]} -gt 0 ]; then
    sudo apt update
    sudo apt install -y "${NEEDED[@]}"
else
    echo "---All packages already installed"
fi

# For the nvim config. Is a requirement for treesitter
sudo npm install -g tree-sitter-cli
