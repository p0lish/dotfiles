# dotfiles

Personal config files.

## Hyprland (Fedora + NVIDIA)

One-liner install:

```bash
curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/hyprland-install.sh | bash
```

Includes:
- Hyprland with NVIDIA env vars
- Waybar (minimal dark theme)
- Wofi launcher
- Kitty terminal
- Screenshot tools (grim + slurp)
- Media keys & brightness

After install, reboot and select Hyprland from login screen.

### Keybindings

| Key | Action |
|-----|--------|
| `Super + Q` | Terminal |
| `Super + C` | Close window |
| `Super + R` | App launcher |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move to workspace |
| `Super + arrows` | Move focus |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Super + M` | Exit Hyprland |
| `Print` | Screenshot (select area) |
| `Shift + Print` | Screenshot (full) |

Config: `~/.config/hypr/hyprland.conf`

## Neovim

```bash
cp -r lua ~/.config/nvim/
cp init.lua ~/.config/nvim/
```
