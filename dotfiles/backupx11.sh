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

# dunst
if [ -d "$HOME/.config/dunst" ]; then
	cp -a "$HOME/.config/dunst" "$DOTFILES"
fi

# i3
if [ -d "$HOME/.config/i3" ]; then
	cp -a "$HOME/.config/i3" "$DOTFILES"
fi

# i3status
if [ -d "$HOME/.config/i3status" ]; then
	cp -a "$HOME/.config/i3status" "$DOTFILES"
fi

# rofi
if [ -d "$HOME/.config/rofi" ]; then
	cp -a "$HOME/.config/rofi" "$DOTFILES"
fi


echo "dotfiles backuped!"
