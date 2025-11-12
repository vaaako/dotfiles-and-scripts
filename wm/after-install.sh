#!/bin/bash

# Enable the Login Manager
sudo systemctl enable ly.service

# Make sure the user directories are created
xdg-user-dirs-update

# Create necessary directories
mkdir -p ~/Pictures/Screenshots ~/Pictures/Wallpapers

# gsettings
# to set cursor, theme and icons
sudo pacman -S gnome-settings-daemon
