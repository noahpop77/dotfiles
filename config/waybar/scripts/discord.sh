#!/usr/bin/env bash

# 1. Check if process is running
if ! pgrep -xi "discord" > /dev/null && ! pgrep -xi "vesktop" > /dev/null; then
    echo '{"text": "󰙯", "class": "offline", "tooltip": "Discord is closed"}'
    exit 0
fi

# 2. Check Hyprland client titles first
TITLE=$(hyprctl clients -j 2>/dev/null | jq -r '.[] | select(.class | test("discord|vesktop"; "i")) | .title' | head -n 1)

if echo "$TITLE" | grep -qE '\([0-9]+\)|•'; then
    COUNT=$(echo "$TITLE" | grep -oE '\([0-9]+\)' | head -n 1 | tr -d '()')
    if [ -n "$COUNT" ]; then
        echo "{\"text\": \"󰙯 ${COUNT}\", \"class\": \"unread\", \"tooltip\": \"Discord: ${COUNT} Unread\"}"
    else
        echo '{"text": "󰙯 •", "class": "unread", "tooltip": "Discord: Unread Messages"}'
    fi
    exit 0
fi

# 3. Check swaync / notification manager history if using swaync or dunst for unread Discord notifications
if command -v swaync-client > /dev/null 2>&1; then
    SWAYNC_DISCORD=$(swaync-client -c 2>/dev/null)
    # If swaync reports active unread notifications from Vesktop
    if [ "$SWAYNC_DISCORD" -gt 0 ]; then
        echo '{"text": "󰙯 •", "class": "unread", "tooltip": "Discord: Unread Notifications"}'
        exit 0
    fi
fi

# 4. Fallback default: Discord running normally
echo '{"text": "󰙯", "class": "running", "tooltip": "Discord: No Unread Messages"}'
