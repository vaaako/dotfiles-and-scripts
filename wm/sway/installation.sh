#!/bin/bash

echo "Starting packages installation for minimal Sway environment..."
echo "This script will install core components, utilities, and drivers"
sleep 5

# --- CORE DESKTOP & WAYLAND COMPOSITOR ---
# sway: The window manager and Wayland compositor
# swayidle: An idle management daemon (e.g., turn off screen, lock after timeout)
# wofi: An application launcher (your choice, excellent)
# ly: A terminal-based display/login manager (your choice, good for minimal)
# kitty: A GPU-accelerated terminal emulator (your choice, excellent)
# waybar: A highly customizable status bar for Wayland composers like Sway (much more flexible than the default swaybar)
# mako: A lightweight notification daemon for Wayland
# libnotify: notify-send command
echo "Installing Core Desktop Packages..."
sudo pacman -S --noconfirm --needed \
	sway swayidle \
	wofi ly kitty waybar mako libnotify

# --- CORE USER APPLICATIONS ---
# loupe: Image viewer
# evince: Document viewer
# sushi: Previewer for nautilus
# lxappearance: A GTK+ theme switcher
sudo pacman -S --noconfirm --needed \
	loupe \
	evince \
	sushi

# --- WAYLAND & X11 COMPATIBILITY ---
# wl-clipboard: Command line copy/paste for Wayland
# xdg-desktop-portal-wlr: The backend for screen sharing, portals, etc. (xdg-desktop-portal-wl is a transitional package)
# xdg-desktop-portal-gtk: GTK theme changing
# xorg-xwayland: The X11 compatibility layer, absolutely essential for running apps that don't support Wayland natively.
# wl-mirror: A utility for mirroring the screen (used for virtual monitors)
# grim: A screenshot utility
# slurp: A utility to select a region of the screen (used with grim)
# jq: Command-line JSON processor (used with grim)
# slop: an application that queries for a selection from the user
echo "Installing Wayland & X11 Compatibility Packages..."
sudo pacman -S --noconfirm --needed \
	wl-clipboard xdg-desktop-portal-wlr xorg-xwayland \
	xdg-desktop-portal-gtk \
	wl-mirror \
	grim \
	slurp \
	jq


