#!/bin/bash
# Waybar rice - Kian's minimal (dark adapted)
# curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/waybar-rice.sh | bash

set -e

echo "🔴 Waybar Rice"
echo "=============="
echo ""

mkdir -p ~/.config/waybar

cat > ~/.config/waybar/config << 'WAYBARCONF'
{
    "layer": "top",
    "position": "top",
    "height": 32,

    "modules-left": ["custom/logo", "hyprland/workspaces"],
    "modules-center": ["hyprland/window"],
    "modules-right": ["pulseaudio", "network", "battery", "tray", "clock"],

    "custom/logo": {
        "format": "󰣛",
        "tooltip": false,
        "on-click": "wofi --show drun"
    },

    "hyprland/workspaces": {
        "format": "{name}",
        "on-click": "activate"
    },

    "hyprland/window": {
        "max-length": 50
    },

    "tray": {
        "spacing": 8,
        "icon-size": 16
    },

    "clock": {
        "format": "{:%H:%M}",
        "format-alt": "{:%a %d %b}",
        "tooltip-format": "{:%Y-%m-%d}"
    },

    "battery": {
        "format": "{icon}",
        "format-icons": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
        "format-charging": "󰂄",
        "tooltip-format": "{capacity}%"
    },

    "network": {
        "format-wifi": "󰖩",
        "format-ethernet": "󰈀",
        "format-disconnected": "󰖪",
        "tooltip-format-wifi": "{essid} {signalStrength}%"
    },

    "pulseaudio": {
        "format": "{icon}",
        "format-muted": "󰝟",
        "format-icons": {"default": ["󰕿", "󰖀", "󰕾"]},
        "tooltip-format": "{volume}%",
        "on-click": "pavucontrol"
    }
}
WAYBARCONF

cat > ~/.config/waybar/style.css << 'WAYBARSTYLE'
* {
    font-family: "JetBrains Mono Nerd Font", "JetBrains Mono", monospace;
    font-size: 13px;
    border: none;
    border-radius: 0;
    min-height: 0;
}

window#waybar {
    background: #0d0d0d;
    color: #888888;
}

#custom-logo {
    color: #51a2da;
    padding: 0 14px 0 10px;
    font-size: 15px;
}

#custom-logo:hover {
    color: #7ac2fa;
}

#workspaces button {
    padding: 0 10px;
    color: #555555;
    border-bottom: 2px solid transparent;
}

#workspaces button.active {
    color: #cccccc;
    border-bottom: 2px solid #cc6666;
}

#workspaces button:hover {
    color: #888888;
}

#window {
    color: #666666;
}

#clock {
    color: #cccccc;
    padding: 0 14px;
}

#battery, #network, #pulseaudio {
    padding: 0 10px;
    color: #888888;
}

#battery.charging {
    color: #88aa88;
}

#battery.warning {
    color: #ccaa66;
}

#battery.critical {
    color: #cc6666;
}

#network.disconnected {
    color: #444444;
}

#pulseaudio.muted {
    color: #444444;
}

#tray {
    padding: 0 8px;
}
WAYBARSTYLE

echo "✓ Waybar config written"
echo ""
echo "Reload: killall waybar; waybar &"
echo ""
