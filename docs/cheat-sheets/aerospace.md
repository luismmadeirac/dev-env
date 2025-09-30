# AeroSpace Cheat Sheet  ![Status: Updated](https://img.shields.io/badge/Status-Updated-green)

Last updated: Sep, 14th 2025

## AeroSpace Tiling Window Manager

AeroSpace is like i3 tiling window manager but for macOS..

## Workspace Navigation

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+B` | Switch to Browser workspace |
| `Alt+S` | Switch to Slack workspace |
| `Alt+T` | Switch to Terminal/Editor workspace |
| `Alt+D` | Switch to Design workspace (Figma) |
| `Alt+O` | Switch to Obsidian workspace |
| `Alt+R` | Switch to R workspace |
| `Alt+1` | Switch to workspace 1 (secondary monitor) |
| `Alt+2` | Switch to workspace 2 (secondary monitor) |

## Window Movement

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+Shift+B` | Move window to Browser workspace |
| `Alt+Shift+S` | Move window to Slack workspace |
| `Alt+Shift+T` | Move window to Terminal/Editor workspace |
| `Alt+Shift+D` | Move window to Design workspace |
| `Alt+Shift+O` | Move window to Obsidian workspace |
| `Alt+Shift+R` | Move window to R workspace |
| `Alt+Shift+1` | Move window to workspace 1 (secondary monitor) |
| `Alt+Shift+2` | Move window to workspace 2 (secondary monitor) |

## Focus Movement

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+H` | Focus window to the left |
| `Alt+J` | Focus window below |
| `Alt+K` | Focus window above |
| `Alt+L` | Focus window to the right |

## Window Positioning

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+Shift+H` | Move window left |
| `Alt+Shift+J` | Move window down |
| `Alt+Shift+K` | Move window up |
| `Alt+Shift+L` | Move window right |

## Multi-Monitor Controls

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+M` | Focus next monitor |
| `Alt+N` | Focus previous monitor |
| `Alt+Shift+M` | Move window to next monitor |
| `Alt+Shift+N` | Move window to previous monitor |
| `Alt+Shift+Tab` | Move workspace to next monitor |

## Layout Controls

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+/` | Toggle between horizontal/vertical tiles layout |
| `Alt+,` | Toggle between horizontal/vertical accordion layout |
| `Alt+Shift+F` | Toggle fullscreen mode |

## Resize Mode

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+Shift+;` | Enter service mode |

### In Resize Mode:
| Keybinding | Description |
| ---------- | ----------- |
| `H` | Decrease width by 50px |
| `J` | Increase height by 50px |
| `K` | Decrease height by 50px |
| `L` | Increase width by 50px |
| `B` | Balance window sizes |
| `-` | Smart resize decrease by 50px |
| `=` | Smart resize increase by 50px |
| `Enter` | Exit to main mode |
| `Esc` | Exit to main mode |

## Service Mode

| Keybinding | Description |
| ---------- | ----------- |
| `Alt+Shift+;` | Enter service mode |

### In Service Mode:
| Keybinding | Description |
| ---------- | ----------- |
| `Esc` | Reload config and return to main mode |
| `R` | Reset workspace layout and return to main mode |
| `F` | Toggle between floating/tiling layout |
| `Backspace` | Close all windows except current |
| `Alt+Shift+H` | Join with left window |
| `Alt+Shift+J` | Join with window below |
| `Alt+Shift+K` | Join with window above |
| `Alt+Shift+L` | Join with right window |

## Auto Window Assignment

The following applications are automatically assigned to specific workspaces:

| Application | Workspace | Description |
| ----------- | --------- | ----------- |
| WezTerm | T | Terminal workspace |
| Chrome | B | Browser workspace |
| Alacritty | T | Terminal workspace |
| Safari | B | Browser workspace |
| Arc Browser | B | Browser workspace |
| Firefox | B | Browser workspace |
| Figma | D | Design workspace |

## Monitor Configuration

- **Main Monitor (MacBook)**: Displays existing workspaces (B, S, T, D, O, R)
- **Secondary Monitor (Dell)**: Displays new workspaces (1, 2)
- **Layout**: Vertical dual monitor setup with proper gap spacing
- **Orientation**: Auto-detects based on monitor dimensions

### Further Resources

* [AeroSpace Official Documentation](https://nikitabobko.github.io/AeroSpace/guide)
* [AeroSpace Commands Reference](https://nikitabobko.github.io/AeroSpace/commands)
* [Configuration File](../../../env/.config/aerospace/aerospace.toml)
