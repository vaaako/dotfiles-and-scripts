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

# kitty
cp -a "$DOTFILES/kitty" "$CONFIG_FOLDER"

# neofetch
cp -a "$DOTFILES/neofetch" "$CONFIG_FOLDER"

# zsh
cp "$DOTFILES/.zshrc" "$HOME/.zshrc"

echo "dotfiles restored!"

