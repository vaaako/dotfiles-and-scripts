#!/bin/bash

# -- Common packages
# ly: A terminal-based display/login manager
# kitty: A GPU-accelerated terminal emulator
sudo pacman -S --needed --noconfirm \
	ly \
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

# loupe: Image viewer
# evince: Document viewer
# sushi: Previewer for nautilus
sudo pacman -S --needed --noconfirm \
	loupe \
	evince
# sushi

# -- Enable the Login Manager
sudo systemctl enable ly@tty2.service
sudo systemctl disable getty@tty2.service

# -- Make sure the user directories are created
xdg-user-dirs-update

# -- Create necessary directories
mkdir -p ~/Pictures/Screenshots ~/Pictures/Wallpapers

# -- Set default terminal
xdg-mime default kitty.desktop application/x-terminal-emulator

echo -e "\nAll done! 🌱"
