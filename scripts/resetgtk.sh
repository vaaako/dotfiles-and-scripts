#!/bin/bash

read -p "Do you want to reset the gtk themes (remove gtk folders)? (y/N) " response

if [[ $response != "y" ]]; then
	echo "gtk not reset"
	exit
fi

rm -rf ~/.config/gtk-3.0
echo "~/.config/gtk-3.0 removed"
rm -rf ~/.config/gtk-4.0
echo "~/.config/gtk-4.0 removed"
rm -f ~/.gtkrc-2.0
echo "~/.gtkrc-2.0 removed"
