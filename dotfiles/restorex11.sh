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

# dunst
cp -a "$DOTFILES/dunst" "$CONFIG_FOLDER"

# i3
cp -a "$DOTFILES/i3" "$CONFIG_FOLDER"

# i3status
cp -a "$DOTFILES/i3status" "$CONFIG_FOLDER"

echo "dotfiles restored!"

