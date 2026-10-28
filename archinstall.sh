#!/usr/bin/env bash
set -Eeuo pipefail

# Get the directory where this setup script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Updating package databases and base development tools..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git

echo "==> Checking for AUR helper (yay)..."
if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
    echo "==> Installing 'yay' from AUR..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    (cd /tmp/yay-bin && makepkg -si --noconfirm)
    rm -rf /tmp/yay-bin
fi

# Set active AUR helper
AUR_HELPER="yay"
if command -v paru &>/dev/null; then
    AUR_HELPER="paru"
fi

echo "==> Installing official Arch packages..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    hyprpaper \
    hypridle \
    hyprlock \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    polkit-kde-agent \
    sddm \
    qt6-virtualkeyboard \
    neovim \
    ghostty \
    nautilus \
    htop \
    libvirt \
    qemu-desktop \
    virt-manager \
    dnsmasq \
    iptables-nft \
    pavucontrol \
    pipewire \
    pipewire-alsa \
    pipewire-pulse \
    wireplumber \
    gst-plugin-pipewire \
    ranger \
    waybar \
    wofi \
    imagemagick \
    python \
    ripgrep \
    curl \
    go \
    luarocks \
    npm \
    firefox \
    qemu-desktop \
    virt-manager \
    virt-viewer \
    libvirt \
    dnsmasq \
    iptables-nft \
    dmidecode \
    openbsd-netcat \
    libguestfs \
    spice-gtk


echo "==> Installing AUR packages (sublime-text-4, fdclone)..."
$AUR_HELPER -S --needed --noconfirm sublime-text-4 fdclone

echo "==> Installing Tree-sitter CLI for Neovim globally via npm..."
sudo npm install -g tree-sitter-cli

echo "==> Setting up SDDM and Astronaut theme..."
if [ ! -d "/usr/share/sddm/themes/sddm-astronaut-theme" ]; then
    sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
else
    echo "sddm-astronaut-theme already exists, pulling latest changes..."
    sudo git -C /usr/share/sddm/themes/sddm-astronaut-theme pull
fi

sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

sudo mkdir -p /etc/sddm.conf.d
echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf

sudo systemctl enable sddm.service

echo "==> Configuring User Groups & Services..."
# Add user to libvirt group for non-root VM management
sudo usermod -aG libvirt "$USER"

# Enable libvirt service
sudo systemctl enable --now libvirtd.service

# Enable PipeWire user audio services
systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service || true

echo "==> Creating 'devenv' directory in home..."
mkdir -p ~/devenv

echo "==> Copying 'Pictures' directory..."
if [ -d "$SCRIPT_DIR/Pictures" ]; then
    mkdir -p ~/Pictures
    cp -r "$SCRIPT_DIR/Pictures/." ~/Pictures/
    echo "Pictures copied successfully."
fi

echo "==> Copying contents of '.config' folder..."
if [ -d "$SCRIPT_DIR/.config" ]; then
    mkdir -p ~/.config
    cp -r "$SCRIPT_DIR/config/." ~/.config/
    echo ".config contents copied successfully."
fi

echo "==> Configuring ~/.bashrc aliases and gitupdate function..."
BASHRC="$HOME/.bashrc"
touch "$BASHRC"

if ! grep -q "gitupdate" "$BASHRC"; then
    cat << 'EOF' >> "$BASHRC"

# --- Custom Workstation Aliases & Functions ---
alias ls="ls --color=auto -F"
alias ll="ls -l --color=auto -Fhoa"

gitupdate() {
    if [ "$1" == "--help" ]; then
        echo "Usage: gitupdate {commit message}"
        return 0
    fi

    if [ -z "$1" ]; then
        echo "Error: missing argument"
        echo "Use --help for usage"
        return 1
    fi

    git add .
    git commit -m "$*"
    git push origin main
}
EOF
    echo "Aliases and gitupdate function added to ~/.bashrc."
fi

echo "==> Setup completed successfully!"
echo "    NOTE: Log out and back in (or reboot) for user group changes (libvirt) and SDDM to take effect."
