#!/usr/bin/env bash
# =============================================================================
# Cross-platform setup script for Neovim config + dependencies
# Works on macOS (Homebrew) and Ubuntu/Debian (apt)
# =============================================================================

set -euo pipefail

# ── OS & Package Manager Detection ──────────────────────────────────────────

if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
    PKG_MANAGER="brew"
    PKG_UPDATE="brew update"
    PKG_INSTALL="brew install --quiet"
    SUDO=""
    GITPATH="$(brew --prefix)/bin/"  # /opt/homebrew/bin or /usr/local/bin
    CONFIG_FILE="$HOME/.zshrc"
else
    OS="Linux"
    if command -v apt-get >/dev/null 2>&1; then
        PKG_MANAGER="apt"
        PKG_UPDATE="sudo apt update"
        PKG_INSTALL="sudo apt install -y"
        SUDO="sudo"
        GITPATH="/usr/local/bin/"
        CONFIG_FILE="$HOME/.bashrc"
    else
        echo "Unsupported Linux distribution (only Debian/Ubuntu family supported)"
        exit 1
    fi
fi

echo "--- Detected OS: $OS"

# ── Add enhanced ls aliases if not present ──────────────────────────────────

if ! grep -q "alias ls='ls -GF'" "$CONFIG_FILE" 2>/dev/null; then
    {
        echo ""
        echo "# Enhanced ls with colors & indicators (added by setup script)"
        echo "alias ls='ls -GF'"
        echo "alias ll='ls -lGFho'"
    } >> "$CONFIG_FILE"
    echo "--- Added improved ls aliases to $CONFIG_FILE"
else
    echo "--- Aliases already in $CONFIG_FILE"
fi

# ── Copy gitupdate script to proper bin directory ───────────────────────────

echo "--- Copying gitupdate script..."
if [[ $OS == "macOS" ]]; then
    TARGET="$GITPATH/gitupdate"
    if [[ -w "$(dirname "$TARGET")" ]]; then
        cp gitupdate "$TARGET" && chmod +x "$TARGET"
        echo "--- gitupdate copied to $TARGET"
    else
        mkdir -p ~/bin
        cp gitupdate ~/bin/gitupdate && chmod +x ~/bin/gitupdate
        echo "--- gitupdate copied to ~/bin/gitupdate"
        echo "   (add 'export PATH=\"\$HOME/bin:\$PATH\"' to ~/.zshrc if needed)"
    fi
else
    $SUDO cp gitupdate "$GITPATH/gitupdate"
    $SUDO chmod +x "$GITPATH/gitupdate"
    echo "--- gitupdate copied to $GITPATH/gitupdate"
fi

# ── Copy Neovim config (overwrite, no backup) ───────────────────────────────
echo "--- Copying Neovim config (overwriting existing one)..."
rm -rf ~/.config/nvim
cp -r nvim ~/.config/nvim
chmod -R u+rw ~/.config/nvim
echo "--- Neovim config overwritten at ~/.config/nvim"

# ── Packages (with OS-specific mapping) ─────────────────────────────────────

# Your original list style, but we map names at runtime
PACKAGES=(
  imagemagick
  python3.12-venv
  golang-go
  fdclone
  npm
  curl
  ripgrep
  git
  htop
  cmatrix
)

# Apply macOS-friendly names
if [[ $OS == "macOS" ]]; then
  for i in "${!PACKAGES[@]}"; do
    case "${PACKAGES[i]}" in
      python3.12-venv) PACKAGES[i]="python@3.12" ;;  # venv included
      golang-go)       PACKAGES[i]="go" ;;
      fdclone)         PACKAGES[i]="fd" ;;
      npm)             PACKAGES[i]="node" ;;
    esac
  done
fi

# ── Ultra-optimized package installation ─────────────────────────────────────
# Always update the package manager and (re)install all packages.
# Modern package managers are idempotent: they skip what's already up-to-date.
# This is much faster than checking each package individually.

echo "--- Updating package manager and installing/updating all required packages..."
$PKG_UPDATE >/dev/null 2>&1 || true
$PKG_INSTALL "${PACKAGES[@]}"
echo "--- Package installation/update complete"

# ── tree-sitter-cli (npm global) ────────────────────────────────────────────

if ! command -v tree-sitter &>/dev/null; then
    echo "--- Installing tree-sitter-cli..."
    $SUDO npm install -g tree-sitter-cli
else
    echo "--- tree-sitter-cli is already installed, skipping..."
fi


# Reload shell configuration so changes take effect immediately
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
    echo "--- Reloaded $CONFIG_FILE — your new aliases and changes are now active!"
else
    echo "--- $CONFIG_FILE not found — open a new terminal to apply changes"
fi


echo ""
echo -e "\033[32m--- Setup complete!\033[0m"
# echo "--- Setup complete!"
