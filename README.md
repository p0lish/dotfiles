# dotfiles

Personal config files.

## Hyprland (Fedora + NVIDIA)

### Full install
```bash
curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/hyprland-install.sh | bash
curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/hyprland-rice.sh | bash
curl -fsSL https://raw.githubusercontent.com/p0lish/dotfiles/master/waybar-rice.sh | bash
```

### Individual scripts

| Script | What it does |
|--------|--------------|
| `hyprland-install.sh` | Packages, COPR, fonts, NVIDIA setup |
| `hyprland-rice.sh` | Hyprland appearance & keybindings |
| `waybar-rice.sh` | Waybar config & styling |

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

## Neovim

```bash
cp -r lua ~/.config/nvim/
cp init.lua ~/.config/nvim/
```
