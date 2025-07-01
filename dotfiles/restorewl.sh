#!/bin/bash

# Ask if the user wants to restore the dotfiles
read -p "Do you want to restore the dotfiles? (y/N) " response

if [[ $response != "y" ]]; then
	echo "Dotfiles not restored"
	exit
fi

read -p "This will delete all existing dotfiles. Are you sure? (y/N) " response

if [[ $response != "y" ]]; then
	echo "Dotfiles not restored"
	exit
fi
# find dotfiles folder in this repository
DOTFILES=$(find . -type d -name "dotfiles")
if [ ! $DOTFILES ]; then
	DOTFILES="./"
fi

CONFIG_FOLDER="$HOME/.config"

# mako
cp -a "$DOTFILES/mako" "$CONFIG_FOLDER"

# sway
cp -a "$DOTFILES/sway" "$CONFIG_FOLDER"

# waybar
cp -a "$DOTFILES/waybar" "$CONFIG_FOLDER"

# wofi
cp -a "$DOTFILES/wofi" "$CONFIG_FOLDER"

# xdg-desktop-portal-wlr
cp -a "$DOTFILES/xdg-desktop-portal-wlr" "$CONFIG_FOLDER"


echo "dotfiles restored!"

