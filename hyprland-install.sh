#!/bin/bash
# Hyprland one-liner installer for Fedora + NVIDIA
# curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/hyprland-install.sh | bash

set -e

echo "🔴 HAL 9000 Hyprland Installer"
echo "==============================="
echo ""

# Check Fedora
if ! command -v dnf &> /dev/null; then
    echo "❌ This script is for Fedora (dnf not found)"
    exit 1
fi

echo "=== Installing packages ==="
# sdegler COPR - maintained fork (solopasha abandoned, Qt6.10 breaks)
sudo dnf copr enable -y sdegler/hyprland
sudo dnf install -y --skip-unavailable hyprland kitty waybar wofi dunst \
    grim slurp wl-clipboard brightnessctl playerctl \
    hyprpolkitagent xdg-desktop-portal-hyprland

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
echo "=== Creating configs ==="
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi
mkdir -p ~/.config/dunst

# === HYPRLAND CONFIG ===
cat > ~/.config/hypr/hyprland.conf << 'HYPRCONF'
# Hyprland config - minimal practical setup

# === NVIDIA SETUP ===
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1

# === MONITOR ===
monitor = ,preferred,auto,1

# === STARTUP ===
exec-once = waybar
exec-once = dunst
exec-once = systemctl --user start hyprpolkitagent

# === INPUT ===
input {
    kb_layout = us
    follow_mouse = 1
    touchpad {
        natural_scroll = true
        tap-to-click = true
    }
    sensitivity = 0
}

# === APPEARANCE ===
general {
    gaps_in = 4
    gaps_out = 8
    border_size = 2
    col.active_border = rgba(cc6666ee) rgba(666666ee) 45deg
    col.inactive_border = rgba(1a1a1aee)
    layout = dwindle
}

decoration {
    rounding = 12
    blur {
        enabled = true
        size = 8
        passes = 3
        new_optimizations = true
        xray = true
    }
    shadow {
        enabled = true
        range = 20
        render_power = 3
        color = rgba(00000099)
    }
    active_opacity = 0.95
    inactive_opacity = 0.88
}

animations {
    enabled = true
    bezier = smooth, 0.05, 0.9, 0.1, 1.05
    bezier = fade, 0.0, 0.0, 0.2, 1.0
    animation = windows, 1, 5, smooth, slide
    animation = windowsOut, 1, 5, fade, popin 80%
    animation = fade, 1, 5, fade
    animation = workspaces, 1, 6, smooth, slidevert
    animation = border, 1, 10, default
    animation = borderangle, 1, 100, default, loop
}

dwindle {
    pseudotile = true
    preserve_split = true
}

# === KEYBINDINGS ===
$mod = SUPER

bind = $mod, Q, exec, kitty
bind = $mod, C, killactive
bind = $mod, M, exit
bind = $mod, R, exec, wofi --show drun
bind = $mod, F, fullscreen
bind = $mod, V, togglefloating
bind = $mod, P, pseudo
bind = $mod, J, togglesplit

# Move focus
bind = $mod, left, movefocus, l
bind = $mod, right, movefocus, r
bind = $mod, up, movefocus, u
bind = $mod, down, movefocus, d

bind = $mod, H, movefocus, l
bind = $mod, L, movefocus, r
bind = $mod, K, movefocus, u
bind = $mod, J, movefocus, d

# Workspaces
bind = $mod, 1, workspace, 1
bind = $mod, 2, workspace, 2
bind = $mod, 3, workspace, 3
bind = $mod, 4, workspace, 4
bind = $mod, 5, workspace, 5
bind = $mod, 6, workspace, 6
bind = $mod, 7, workspace, 7
bind = $mod, 8, workspace, 8
bind = $mod, 9, workspace, 9

bind = $mod SHIFT, 1, movetoworkspace, 1
bind = $mod SHIFT, 2, movetoworkspace, 2
bind = $mod SHIFT, 3, movetoworkspace, 3
bind = $mod SHIFT, 4, movetoworkspace, 4
bind = $mod SHIFT, 5, movetoworkspace, 5
bind = $mod SHIFT, 6, movetoworkspace, 6
bind = $mod SHIFT, 7, movetoworkspace, 7
bind = $mod SHIFT, 8, movetoworkspace, 8
bind = $mod SHIFT, 9, movetoworkspace, 9

bind = $mod, mouse_down, workspace, e+1
bind = $mod, mouse_up, workspace, e-1

bindm = $mod, mouse:272, movewindow
bindm = $mod, mouse:273, resizewindow

# Screenshot
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
bind = SHIFT, Print, exec, grim - | wl-copy

# Media/brightness
binde = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
binde = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
binde = , XF86MonBrightnessUp, exec, brightnessctl set +5%
binde = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# === WINDOW RULES ===
windowrule = match:class ^(pavucontrol)$, float on
windowrule = match:class ^(nm-connection-editor)$, float on
windowrule = match:title ^(Picture-in-Picture)$, float on
HYPRCONF

# === WAYBAR CONFIG ===
cat > ~/.config/waybar/config << 'WAYBARCONF'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 8,
    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "battery", "tray"],
    "hyprland/workspaces": {
        "format": "{id}",
        "on-click": "activate"
    },
    "clock": {
        "format": "{:%H:%M}",
        "format-alt": "{:%Y-%m-%d %H:%M}",
        "tooltip-format": "{:%A, %B %d, %Y}"
    },
    "battery": {
        "format": "{icon} {capacity}%",
        "format-icons": ["", "", "", "", ""],
        "format-charging": " {capacity}%"
    },
    "network": {
        "format-wifi": " {signalStrength}%",
        "format-ethernet": "",
        "format-disconnected": "",
        "tooltip-format": "{essid} ({signalStrength}%)"
    },
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "",
        "format-icons": { "default": ["", "", ""] },
        "on-click": "pavucontrol"
    },
    "tray": { "spacing": 10 }
}
WAYBARCONF

# === WAYBAR STYLE ===
cat > ~/.config/waybar/style.css << 'WAYBARSTYLE'
* {
    font-family: "JetBrains Mono", "Font Awesome 6 Free", monospace;
    font-size: 12px;
    color: #b0b0b0;
}
window#waybar {
    background: rgba(10, 10, 10, 0.85);
    border: none;
    border-radius: 0;
}
#workspaces button {
    padding: 0 10px;
    margin: 4px 2px;
    background: transparent;
    border: none;
    border-radius: 6px;
    color: #666;
    transition: all 0.2s ease;
}
#workspaces button.active {
    background: rgba(204, 102, 102, 0.3);
    color: #cc6666;
    border-bottom: 2px solid #cc6666;
}
#workspaces button:hover {
    background: rgba(255, 255, 255, 0.05);
    color: #999;
}
#clock {
    font-weight: bold;
    color: #cc6666;
}
#battery, #network, #pulseaudio, #tray {
    padding: 0 14px;
    margin: 4px 0;
}
#battery.charging { color: #7c9c7c; }
#battery.warning:not(.charging) { color: #cc9966; }
#battery.critical:not(.charging) { color: #cc6666; }
#network.disconnected { color: #444; }
#pulseaudio.muted { color: #444; }
WAYBARSTYLE

echo "✓ Configs written"

echo ""
echo "==============================="
echo "🔴 Setup complete"
echo ""
echo "Reboot, then select 'Hyprland' from login screen."
echo ""
echo "Keybindings:"
echo "  SUPER + Q       = terminal"
echo "  SUPER + C       = close window"
echo "  SUPER + R       = launcher"
echo "  SUPER + 1-9     = workspaces"
echo "  SUPER + arrows  = move focus"
echo "  SUPER + F       = fullscreen"
echo "  SUPER + M       = exit"
echo "  Print           = screenshot (select)"
echo ""
echo "Config: ~/.config/hypr/hyprland.conf"
echo ""
