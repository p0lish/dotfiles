#!/bin/bash
# Waybar rice config - clean pills style
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
    "spacing": 0,
    "modules-left": ["custom/logo", "hyprland/workspaces"],
    "modules-center": ["hyprland/window"],
    "modules-right": ["pulseaudio", "network", "cpu", "temperature", "battery", "clock", "tray"],
    "custom/logo": {
        "format": "󰣛",
        "tooltip": false,
        "on-click": "wofi --show drun"
    },
    "hyprland/workspaces": {
        "format": "{icon}",
        "format-icons": {
            "1": "󰖟 Web",
            "2": "󰅩 Code",
            "3": "󰝚 Music",
            "4": "󰭹 Chat",
            "5": "󰉋 Files",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9"
        },
        "on-click": "activate",
        "persistent-workspaces": {
            "*": 5
        }
    },
    "hyprland/window": {
        "max-length": 50,
        "separate-outputs": true,
        "format": "{title}"
    },
    "clock": {
        "format": "{:%H:%M}",
        "format-alt": "{:%a %d %b}",
        "tooltip-format": "<tt>{calendar}</tt>"
    },
    "cpu": {
        "format": "󰻠 {usage}%",
        "interval": 2
    },
    "temperature": {
        "format": " {temperatureC}°C",
        "critical-threshold": 80,
        "format-critical": " {temperatureC}°C"
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
        "format-ethernet": "󰈀 LAN",
        "format-disconnected": "󰖪",
        "tooltip-format-wifi": "{essid}\n{ipaddr}",
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
    min-height: 0;
}

window#waybar {
    background: rgba(15, 25, 35, 0.95);
    color: #8899aa;
}

#custom-logo {
    font-size: 16px;
    color: #51a2da;
    background: rgba(81, 162, 218, 0.1);
    padding: 0 12px;
    margin: 4px 4px 4px 8px;
    border-radius: 8px;
}

#custom-logo:hover {
    background: rgba(81, 162, 218, 0.2);
}

#workspaces {
    margin: 4px 4px;
}

#workspaces button {
    padding: 0 12px;
    margin: 0 2px;
    background: rgba(255, 255, 255, 0.05);
    border: none;
    border-radius: 8px;
    color: #667788;
}

#workspaces button.active {
    background: rgba(81, 162, 218, 0.2);
    color: #51a2da;
}

#workspaces button:hover {
    background: rgba(255, 255, 255, 0.1);
}

#window {
    color: #8899aa;
}

#clock, #battery, #network, #pulseaudio, #cpu, #temperature, #tray {
    padding: 0 10px;
    margin: 4px 2px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 8px;
}

#clock {
    color: #aabbcc;
    font-weight: 600;
}

#battery.charging { color: #88cc88; }
#battery.warning { color: #ccaa66; }
#battery.critical { 
    color: #cc6666; 
    animation: pulse 1s infinite;
}

@keyframes pulse {
    50% { background: rgba(204, 102, 102, 0.3); }
}

#temperature.critical {
    color: #cc6666;
}

#network.disconnected { 
    color: #556677; 
}

#pulseaudio.muted { 
    color: #556677; 
}

#tray {
    margin-right: 8px;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}
WAYBARSTYLE

echo "✓ Waybar config written to ~/.config/waybar/"
echo ""
echo "Reload with: killall waybar; waybar &"
echo ""
