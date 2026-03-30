#!/bin/bash

echo "Starting packages installation for minimal i3 environment..."
echo "This script will install core components, utilities, and drivers"
sleep 5

# --- CORE DESKTOP & X11 ---
# i3-wm: The window manager
# i3status: A status bar
# i3lock: A screen locker
# 
# ly: A terminal-based display/login manager (your choice, good for minimal)
# kitty: A GPU-accelerated terminal emulator (your choice, excellent)
# dunst: A notification daemon
# libnotify: notify-send command
#
# feh: Background image setter
# scrot: Screenshot tool
#
# xss-lock: A screen locker
# xset: A tool for manipulating X11 settings
echo "Installing Core Desktop Packages..."
sudo pacman -S --noconfirm --needed \
	xorg i3-wm i3status i3lock \
	dunst libnotify \
	scrot \
	xss-lock xset
# xcompmgr: Compositor

# --- CORE USER APPLICATIONS ---
# xsel: Get content of selection
sudo pacman -S --noconfirm --needed xsel

