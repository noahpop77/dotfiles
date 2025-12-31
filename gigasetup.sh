#!/bin/bash

# Quirks: For the usage of this script on mac it will only copy the gitupdate
#         and neovim config to the desired locations. The package downloading
#         is not currently configured. 
#
# TODO: At some point add dynamic package downloading for MAC like we have for
#       Linux.

set -e

# Detects the OS you are using and you can set custom variables depending
if [[ "$OSTYPE" == "darwin"* ]]; then
    GITPATH="/usr/local/bin/"
    CONFIG_FILE="$HOME/.zshrc"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CONFIG_FILE="$HOME/.bashrc"
    OS="Linux"
fi

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
    echo "→ Aliases already in $CONFIG_FILE"
fi

# Copies gitupdate script to the OS specific bin directory
sudo cp gitupdate $GITPATH
echo "---gitupdate copied to $GITPATH"

# Copies the nvim config to the nvim config location on the OS
cp -r nvim ~/.config/
echo "---neovim config copied to ~/.config/"

# TODO: Temp stop gap since the packages are not installed for mac dynamically
#       This just exits out early on MAC before it gets to that part.
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

# Dynamic package installation based off whats already on the system
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
# Runs the npm install for it and skips it if its already installed
# Added this cause npm takes forever and skipping it is NICE
if ! command -v tree-sitter &>/dev/null; then
    sudo npm install -g tree-sitter-cli
else
    echo "---tree-sitter-cli is already installed, skipping..."
fi

