#!/bin/bash
# Waybar rice config
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
    "height": 34,
    "spacing": 0,
    "modules-left": ["custom/logo", "hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["cpu", "memory", "pulseaudio", "network", "battery", "tray"],
    "custom/logo": {
        "format": "󰣛",
        "tooltip": false,
        "on-click": "wofi --show drun"
    },
    "hyprland/workspaces": {
        "format": "{icon}",
        "format-icons": {
            "1": "一",
            "2": "二",
            "3": "三",
            "4": "四",
            "5": "五",
            "6": "六",
            "7": "七",
            "8": "八",
            "9": "九",
            "active": "●",
            "default": "○"
        },
        "on-click": "activate"
    },
    "hyprland/window": {
        "max-length": 40,
        "separate-outputs": true
    },
    "clock": {
        "format": "{:%H:%M}",
        "format-alt": "{:%a %d %b}",
        "tooltip-format": "<tt>{calendar}</tt>",
        "calendar": {
            "format": {
                "today": "<span color='#cc6666'><b>{}</b></span>"
            }
        }
    },
    "cpu": {
        "format": " {usage}%",
        "interval": 2
    },
    "memory": {
        "format": " {percentage}%",
        "interval": 2
    },
    "battery": {
        "format": "{icon} {capacity}%",
        "format-icons": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
        "format-charging": "󰂄 {capacity}%",
        "format-plugged": "󰚥 {capacity}%",
        "states": { "warning": 20, "critical": 10 }
    },
    "network": {
        "format-wifi": "󰖩 {signalStrength}%",
        "format-ethernet": "󰈀",
        "format-disconnected": "󰖪",
        "tooltip-format-wifi": "{essid} ({signalStrength}%)\n{ipaddr}",
        "on-click": "nm-connection-editor"
    },
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "󰝟",
        "format-icons": { "default": ["󰕿", "󰖀", "󰕾"] },
        "on-click": "pavucontrol"
    },
    "tray": { 
        "icon-size": 16,
        "spacing": 8 
    }
}
WAYBARCONF

cat > ~/.config/waybar/style.css << 'WAYBARSTYLE'
* {
    font-family: "JetBrains Mono Nerd Font", "JetBrains Mono", monospace;
    font-size: 13px;
    color: #909090;
    min-height: 0;
}
window#waybar {
    background: #0a0a0a;
    border-bottom: 1px solid #1a1a1a;
}
#custom-logo {
    font-size: 18px;
    color: #51a2da;
    padding: 0 14px 0 10px;
}
#custom-logo:hover {
    color: #6cb2ea;
}
#workspaces {
    margin-left: 4px;
}
#workspaces button {
    padding: 0 8px;
    margin: 0 2px;
    background: transparent;
    border: none;
    color: #505050;
}
#workspaces button.active {
    color: #cc6666;
}
#workspaces button:hover {
    color: #808080;
}
#window {
    margin-left: 16px;
    color: #606060;
    font-style: italic;
}
#clock {
    font-weight: 600;
    color: #cc6666;
}
#cpu, #memory {
    color: #606060;
}
#battery, #network, #pulseaudio, #cpu, #memory, #tray {
    padding: 0 12px;
}
#battery.charging { color: #6c8c6c; }
#battery.warning { color: #cc9966; }
#battery.critical { color: #cc6666; animation: pulse 1s infinite; }
@keyframes pulse { 50% { color: #ff6666; } }
#network.disconnected { color: #404040; }
#pulseaudio.muted { color: #404040; }
#tray {
    margin-right: 8px;
}
WAYBARSTYLE

echo "✓ Waybar config written to ~/.config/waybar/"
echo ""
echo "Reload with: killall waybar; waybar &"
echo ""
