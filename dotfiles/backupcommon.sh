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

# kitty
if [ -d "$HOME/.config/kitty" ]; then
	cp -a "$HOME/.config/kitty" "$DOTFILES"
fi

# neofetch
if [ -d "$HOME/.config/neofetch" ]; then
	cp -a "$HOME/.config/neofetch" "$DOTFILES"
fi

# zsh
if [ -f "$HOME/.zshrc" ]; then
	cp "$HOME/.zshrc" "$DOTFILES"
fi


echo "dotfiles backuped!"
