# About
Multiple config files to set up different environments using `pacman`

>![WARNING] My rofi config is from [this repo](https://github.com/sayoohnara/bspwm-dots)
> i will change it later but im quite lazy now

>![WARNING] I didn't tested any of the installation scripts in a fresh install yet

# Folders
- **dm**: `xfce` and `gnome` installation and configuration
- **dotfiles**: My personal dotfiles. Some are only used with `x11` and some with `wayland` only
- **interface**: Icons and themes
- **scripts**: Auxiliary scripts
- **wm**: `i3` and `sway` installation and configuration

## Scripts
- **[backupx11.sh](dotfiles/backupx11.sh)** and **[restorex11.sh](dotfiles/restorex11.sh)**: Backup and restore `dunst`, `i3`, `i3status` and `rofi`
- **[backupwl.sh](dotfiles/backupwl.sh)** and **[restorewl.sh](dotfiles/restorewl.sh)**: Backup and restore `mako`, `sway`, `waybar`, `wofi` and `xdg-desktop-portal-wlr`
- **[backupcommon.sh](dotfiles/backupcommon.sh)** and **[restorecommon.sh](dotfiles/restorecommon.sh)**: Backup and restore `.zshrc`, `kitty` and `neofetch`

- **[amd_gpu.sh](scripts/amd_gpu.sh)**: Install AMD GPU drivers
- **[missing.sh](scripts/missing.sh)**: Install necessary packages
- **[packages.sh](scripts/packages.sh)**: Install Personal packages
- **[sudoconfigs.sh](scripts/sudoconfigs.sh)**: Configs with sudo permission

For neovim config see [my nvim repository](https://github.com/vaaako/nvim)

# Keybinds
These keybinds are the same for `i3` and `sway`

## Basics
- `$mod+q`: Close window
- `$mod+Enter`: Launch terminal
- `Ctrl+Shift+k`: Application launcher
- `$mod+e`: Open file explorer
- `$mod+Shift+e`: Exit sway (logs out)

## Window
- `$mod+f`: Fullscreen window
- `$mod+Shift+space`: Toggle floating
- `$mod+space`: Swap focus between tiling area and floating area
- `$mod+w`: Switch to tabbed layout. Group windows by tab in the same workspace

- `Alt+LMB` to move a window around (tiling and floating mode)
- `Alt+RMB` to resize a window around (tiling and floating mode)

# Scratchpad
Scratchpad is a bag of holding for windows. It replaces minimization

- `$mod+Shift+minus`: Move window to scratchpad
- `$mod+minus`: Cycles through windows in scratchpad or hide the window to scratchpad

## Movement
- `$mod+h`: Change focus to window on left
- `$mod+j`: Change focus to window on bottom
- `$mod+k`: Change focus to window on top
- `$mod+l`: Change focus to window on right
- `$mod+shift+(any direction)`: Move window to the direction

## Workspaces
- `$mod+1-9`: Switch to workspace 1-9
- `$mod+Shift+1-9`: Move window to workspace 1-9

## Screenshot
These keybinds are the same in all environments

- `Print`: Screenshot the whole screen, copy and save
- `Win+Shift+s`: Screenshot the area selected with mouse, copy and save
- `Win+Shift+w`: Screenshot the active window, copy and save

# Terminal
Keybinds for `kitty`, so it works in all environments

- `Ctrl+Shift+t`: Open a new tab
- `Ctrl+Shift+l`: Move to next tab
- `Ctrl+Shift+h`: Move to previous tab
- `Ctrl+Shift+n`: Open a new terminal in the same directory

## Alias
- `rm`: Safe rm. Uses `gio` to safely remove files (move to trash)
- `urm`: Unsafe rm
- `explorer`: Open file explorer. Either `nautilus` (default) or `thunar`
- `largest`: List the largest files in the current directory
- `removeorphans`: Remove orphaned files
- `virtualmonitor`: (Wayland only) creates a virtual monitor and mirrors it. Used to screenshare
- `open-ports`: List open ports
- `copy-image`: Uses `xclip` (X11) or `wl-copy` (Wayland) to copy an image to the clipboard
- `drive-mount` and `drive-unmount`: Mount and unmount Google Drive to `~/Drive` using `rclone`
- `mkv-to-mp4`: Converts a mkv file to mp4
- `video-to-gif`: Converts a video file to gif
- `video-to-mp3`: Converts a video file to mp3

