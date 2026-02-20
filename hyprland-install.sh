#!/bin/bash
# Hyprland base install for Fedora + NVIDIA
# curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/hyprland-install.sh | bash

set -e

echo "🔴 Hyprland Install"
echo "==================="
echo ""

if ! command -v dnf &> /dev/null; then
    echo "❌ This script is for Fedora (dnf not found)"
    exit 1
fi

echo "=== Installing packages ==="
sudo dnf copr enable -y sdegler/hyprland
sudo dnf install -y --skip-unavailable hyprland kitty waybar wofi dunst \
    grim slurp wl-clipboard brightnessctl playerctl pavucontrol \
    hyprpolkitagent xdg-desktop-portal-hyprland

echo ""
echo "=== Installing JetBrains Mono Nerd Font ==="
mkdir -p ~/.local/share/fonts
cd /tmp
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz -C ~/.local/share/fonts
fc-cache -fv
rm -f JetBrainsMono.tar.xz

echo ""
echo "=== Configuring NVIDIA kernel params ==="
if ! grep -q "nvidia-drm.modeset=1" /etc/default/grub; then
    sudo sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1 /' /etc/default/grub
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    echo "✓ Kernel params updated"
else
    echo "✓ Already configured"
fi

echo ""
echo "==================="
echo "✓ Base install complete"
echo ""
echo "Next steps:"
echo "  1. Run hyprland-rice.sh for Hyprland config"
echo "  2. Run waybar-rice.sh for Waybar config"
echo "  3. Reboot and select Hyprland from login screen"
echo ""
