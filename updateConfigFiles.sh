#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure destination directory exists
mkdir -p "$SCRIPT_DIR/config"

for dir in hypr waybar wofi ghostty nvim dunst; do
    if [ -d "$HOME/.config/$dir" ]; then
        cp -r "$HOME/.config/$dir" "$SCRIPT_DIR/config/"
    fi
done

if [ -f "$HOME/.config/ReaperBadge.txt" ]; then
    rm -rf "$SCRIPT_DIR/ReaperBadge.txt"
    cp "$HOME/.config/ReaperBadge.txt" "$SCRIPT_DIR/"
fi

if [ -d "/usr/share/sddm/themes/rukia" ]; then
    rm -rf "$SCRIPT_DIR/rukia"
    cp -r "/usr/share/sddm/themes/rukia" "$SCRIPT_DIR/"
fi
