#!/bin/bash

set -e

sudo cp gitupdate /usr/bin/
echo "---gitupdate copied to /usr/bin/"

PACKAGES=(
  curl
  git
  neovim
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
