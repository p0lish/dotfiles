#!/bin/bash
# Hyprland rice config
# curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/hyprland-rice.sh | bash

set -e

echo "🔴 Hyprland Rice"
echo "================"
echo ""

mkdir -p ~/.config/hypr

cat > ~/.config/hypr/hyprland.conf << 'HYPRCONF'
# Hyprland config - dark minimal

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
    rounding = 4
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

bind = $mod, left, movefocus, l
bind = $mod, right, movefocus, r
bind = $mod, up, movefocus, u
bind = $mod, down, movefocus, d

bind = $mod, H, movefocus, l
bind = $mod, L, movefocus, r
bind = $mod, K, movefocus, u
bind = $mod, J, movefocus, d

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

bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
bind = SHIFT, Print, exec, grim - | wl-copy

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

echo "✓ Hyprland config written to ~/.config/hypr/hyprland.conf"
echo ""
echo "Reload with: hyprctl reload"
echo ""
