#!/usr/bin/env bash
# Three floating Ghostty windows on workspace 5.
# Coordinates/sizes are in logical pixels (2560x1440 at 1.5 scale on DP-3).

set -euo pipefail

readonly WORKSPACE=5

lua_escape() {
    local value=$1
    value=${value//\\/\\\\}
    value=${value//\"/\\\"}
    printf '%s' "$value"
}

# Usage: spawn_floating "<command>" <x> <y> <width> <height>
spawn_floating() {
    local command=$1 x=$2 y=$3 width=$4 height=$5
    local escaped
    escaped=$(lua_escape "$command")

    hyprctl dispatch \
        "hl.dsp.exec_cmd(\"$escaped\", { float = true, workspace = \"$WORKSPACE\", move = { $x, $y }, size = { $width, $height } })" \
        >/dev/null
}

command -v hyprctl >/dev/null || { echo "hyprctl not found (is Hyprland running?)" >&2; exit 1; }
for bin in ghostty cava cmatrix fastfetch; do
    command -v "$bin" >/dev/null || { echo "missing required command: $bin" >&2; exit 1; }
done

spawn_floating \
    'ghostty --gtk-single-instance=false --title=cmatrix -e cmatrix' \
    2250 60 300 1350

# Custom fetch alias: top-right, keep the shell open after fastfetch exits
spawn_floating \
    'ghostty --gtk-single-instance=false --title=fetch -e bash -ic "fetch; exec bash"' \
    20 60 1000 620

# cava: wide visualizer along the bottom
spawn_floating \
    'ghostty --gtk-single-instance=false --title=cava -e cava' \
    20 1200 1000 200

# Bring workspace 5 into view once the dashboard exists
hyprctl dispatch 'hl.dsp.focus({ workspace = 5 })' >/dev/null
