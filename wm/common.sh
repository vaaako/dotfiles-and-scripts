#!/bin/bash

# -- Common packages
# ly: A terminal-based display/login manager
# kitty: A GPU-accelerated terminal emulator
sudo pacman -S --needed --noconfirm \
	ly ly-openrc \
	kitty \
	feh \
	lxappearance

# polkit: A policy kit for managing system-wide privileges
# brightnessctl: A utility to control screen brightness
# xdg-utils: Open URLs, Open files with default apps etc
# xdg-user-dirs: Creates and manages directories
sudo pacman -S --noconfirm --needed \
	polkit \
	brightnessctl \
	xdg-utils \
	xdg-user-dirs

# eog: Image viewer
# evince: Document viewer
sudo pacman -S --needed --noconfirm \
	eog \
	evince

# -- Make sure the user directories are created
xdg-user-dirs-update

# -- Create necessary directories
mkdir -p ~/Pictures/Screenshots ~/Pictures/Wallpapers

# -- Set default terminal
xdg-mime default kitty.desktop application/x-terminal-emulator

# -- Enable the Login Manager
# sudo systemctl enable ly@tty2.service
# sudo systemctl disable getty@tty2.service
sudo rc-update add ly default
sudo rc-update del agetty.tty2

echo -e "\nAll done! 🌱"
