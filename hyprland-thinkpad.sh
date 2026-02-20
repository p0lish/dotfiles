#!/bin/bash
# Hyprland rice for ThinkPad E14 (Intel)
# curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/hyprland-thinkpad.sh | bash

set -e

echo "🔴 Hyprland ThinkPad Setup"
echo "=========================="
echo ""

mkdir -p ~/.config/hypr

cat > ~/.config/hypr/hyprland.conf << 'HYPRCONF'
# Hyprland config - ThinkPad E14 (Intel)

# === MONITOR ===
monitor = ,preferred,auto,1

# === PROGRAMS ===
$terminal = kitty
$fileManager = dolphin
$menu = wofi --show drun

# === AUTOSTART ===
exec-once = waybar
exec-once = dunst
exec-once = hyprpaper

# === ENVIRONMENT ===
env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24

# === LOOK AND FEEL ===
general {
    gaps_in = 0
    gaps_out = 0
    border_size = 1
    col.active_border = rgba(cc6666ee)
    col.inactive_border = rgba(333333aa)
    resize_on_border = true
    layout = dwindle
}

decoration {
    rounding = 0
    active_opacity = 1.0
    inactive_opacity = 0.95
    
    shadow {
        enabled = true
        range = 8
        render_power = 2
        color = rgba(00000066)
    }
    
    blur {
        enabled = true
        size = 6
        passes = 2
        new_optimizations = true
    }
}

animations {
    enabled = true
    bezier = snappy, 0.05, 0.9, 0.1, 1.0
    animation = windows, 1, 4, snappy, slide
    animation = windowsOut, 1, 4, snappy, popin 80%
    animation = fade, 1, 4, snappy
    animation = workspaces, 1, 4, snappy, slidevert
    animation = border, 1, 5, default
}

dwindle {
    pseudotile = true
    preserve_split = true
}

misc {
    force_default_wallpaper = 0
    disable_hyprland_logo = true
}

# === INPUT ===
input {
    kb_layout = us
    follow_mouse = 1
    sensitivity = 0
    
    touchpad {
        natural_scroll = true
        tap-to-click = true
        drag_lock = true
    }
}

gestures {
    workspace_swipe = true
    workspace_swipe_fingers = 3
}

# === KEYBINDINGS ===
$mod = SUPER

bind = $mod, Q, exec, $terminal
bind = $mod, C, killactive
bind = $mod, M, exit
bind = $mod, E, exec, $fileManager
bind = $mod, R, exec, $menu
bind = $mod, F, fullscreen
bind = $mod, V, togglefloating
bind = $mod, P, pseudo
bind = $mod, J, togglesplit

# Focus
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
bind = $mod, 0, workspace, 10

bind = $mod SHIFT, 1, movetoworkspace, 1
bind = $mod SHIFT, 2, movetoworkspace, 2
bind = $mod SHIFT, 3, movetoworkspace, 3
bind = $mod SHIFT, 4, movetoworkspace, 4
bind = $mod SHIFT, 5, movetoworkspace, 5
bind = $mod SHIFT, 6, movetoworkspace, 6
bind = $mod SHIFT, 7, movetoworkspace, 7
bind = $mod SHIFT, 8, movetoworkspace, 8
bind = $mod SHIFT, 9, movetoworkspace, 9
bind = $mod SHIFT, 0, movetoworkspace, 10

# Move between monitors
bind = $mod SHIFT, left, movewindow, mon:l
bind = $mod SHIFT, right, movewindow, mon:r

# Scratchpad
bind = $mod, S, togglespecialworkspace, magic
bind = $mod SHIFT, S, movetoworkspace, special:magic

# Mouse
bind = $mod, mouse_down, workspace, e+1
bind = $mod, mouse_up, workspace, e-1
bindm = $mod, mouse:272, movewindow
bindm = $mod, mouse:273, resizewindow

# Media keys
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl set +5%
bindel = ,XF86MonBrightnessDown, exec, brightnessctl set 5%-
bindl = ,XF86AudioPlay, exec, playerctl play-pause
bindl = ,XF86AudioNext, exec, playerctl next
bindl = ,XF86AudioPrev, exec, playerctl previous

# Screenshot
bind = ,Print, exec, grim -g "$(slurp)" - | wl-copy
bind = SHIFT,Print, exec, grim - | wl-copy

# === WINDOW RULES ===
windowrule {
    match:class = ^(pavucontrol)$
    float = on
}
windowrule {
    match:class = ^(nm-connection-editor)$
    float = on
}
windowrule {
    match:title = ^(Picture-in-Picture)$
    float = on
}
HYPRCONF

echo "✓ Hyprland config written"
echo ""
echo "Reload: hyprctl reload"
echo ""
