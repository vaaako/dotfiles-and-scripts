#!/bin/bash

echo "Starting packages installation for minimal Sway environment..."
echo "This script will install core components, utilities, and drivers"
sleep 5

# --- CORE DESKTOP & WAYLAND COMPOSITOR ---
# sway: The window manager and Wayland compositor
# swayidle: An idle management daemon (e.g., turn off screen, lock after timeout)
# swaybg: Be able to change the background
# rofi: An application launcher
# waybar: A highly customizable status bar for Wayland composers like Sway
# mako: A lightweight notification daemon for Wayland
# libnotify: notify-send command
echo "Installing Core Desktop Packages..."
sudo pacman -S --noconfirm --needed \
	sway swaybg swayidle \
	rofi waybar mako libnotify

# pip install --user nautilus-open-any-terminal
# gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty

# --- WAYLAND & X11 COMPATIBILITY ---
# xorg-xwayland: The X11 compatibility layer, absolutely essential for running apps that don't support Wayland natively.
# xdg-desktop-portal-wlr: The backend for screen sharing, portals, etc. (xdg-desktop-portal-wl is a transitional package)
# wl-clipboard: Command line copy/paste for Wayland
# wl-mirror: A utility for mirroring the screen (used for virtual monitors)
# grim: A screenshot utility
# slurp: A utility to select a region of the screen (used with grim)
# jq: Command-line JSON processor (used with grim)
# slop: an application that queries for a selection from the user
echo "Installing Wayland & X11 Compatibility Packages..."
sudo pacman -S --noconfirm --needed \
	xorg-xwayland \
	xdg-desktop-portal \
	xdg-desktop-portal-wlr \
	wl-clipboard \
	grim \
	slurp \
	jq

