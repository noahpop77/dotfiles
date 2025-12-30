#!/bin/bash

# Purpose:
# Silently overwrites the existing systems nvim config folder in ~/.config/nvim 
# with wahts in the github repo

set -euo pipefail

REPO_URL="https://github.com/noahpop77/dotfiles.git"
TARGET_DIR="$HOME/.config/nvim"
TEMP_DIR="$(mktemp -d)"

git clone --depth 1 "$REPO_URL" "$TEMP_DIR" 2>/dev/null || exit 1

[[ -d "$TEMP_DIR/nvim" ]] || {
    rm -rf "$TEMP_DIR"
    exit 1
}

rm -rf "$TARGET_DIR"
cp -r "$TEMP_DIR/nvim" "$TARGET_DIR"
rm -rf "$TEMP_DIR"

exit 0
#
