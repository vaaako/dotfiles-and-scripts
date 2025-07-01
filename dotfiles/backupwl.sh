#!/bin/bash

read -p "Do you want to backup the dotfiles? (y/N) " response

if [[ $response != "y" ]]; then
	echo "dotfiles not backuped"
	exit
fi

# find dotfiles folder in this repository
DOTFILES=$(find . -type d -name "dotfiles")
if [ ! $DOTFILES ]; then
	DOTFILES="./"
fi

# mako
if [ -d "$HOME/.config/mako" ]; then
	cp -a "$HOME/.config/mako" "$DOTFILES"
fi

# sway
if [ -d "$HOME/.config/sway" ]; then
	cp -a "$HOME/.config/sway" "$DOTFILES"
fi

# waybar
if [ -d "$HOME/.config/waybar" ]; then
	cp -a "$HOME/.config/waybar" "$DOTFILES"
fi

# wofi
if [ -d "$HOME/.config/wofi" ]; then
	cp -a "$HOME/.config/wofi" "$DOTFILES"
fi

# xdg-desktop-portal-wlr
if [ -d "$HOME/.config/xdg-desktop-portal-wlr" ]; then
	cp -a "$HOME/.config/xdg-desktop-portal-wlr" "$DOTFILES"
fi


echo "dotfiles backuped!"
