#!/bin/bash

set -e

# Find backup folder. Get first find
BACKUP_FOLDER=$(find . -type d -name "dotfiles" | head -n 1)
if [ -z "$BACKUP_FOLDER" ]; then
	BACKUP_FOLDER="./"
fi

# ---

read -p "Backup or Restore? (b/r) " mode
mode=${mode,,} # To lowercase

if [ "$mode" != "b" ] && [ "$mode" != "r" ]; then
	echo "[+] Invalid answer. Aborting"
	exit 1
fi

if [ "$mode" == "r" ]; then
	read -p "Are you sure? (y/N) " response
	if [ "$response" != "y" ]; then
		echo "[+] Cancelling restore"
		exit 1
	fi
fi


echo "Target (c/w)"
echo "c: 'kitty', 'neofetch', 'rofi', '.zshrc'"
echo "w: 'mako', 'sway', 'waybar', 'xdg-desktop-portal-wlr'"
read -p "Target? " target
target=${target,,} # To lowercase


# ---

# Directory default path is $HOME/.config/
# If file, just try to copy item
COMMON=("kitty" "neofetch" "rofi" ".zshrc")
WAYLAND=("mako" "sway" "waybar" "xdg-desktop-portal-wlr")
# X11=("dunst", "i3", "i3status")

# Copy target
TARGET_ARR=()
case "$target" in
	c) TARGET_ARR=("${COMMON[@]}") ;;
	w) TARGET_ARR=("${WAYLAND[@]}") ;;
	*) echo "[+] Invalid answer. Aborting"; exit 1 ;;
esac

# ---

# NOTE: I know i could have put 'mode' check inside the for-loop
# but i think this is cleaner

if [ "$mode" == "b" ]; then
	for t in "${TARGET_ARR[@]}"; do
		echo "[+] Backing up $t"

		if [ -d "$HOME/.config/$t" ]; then
			cp -rf "$HOME/.config/$t" "$BACKUP_FOLDER"
		else
			cp -f "$HOME/$t" "$BACKUP_FOLDER"
		fi
	done

	echo "[+] Backup complete! 🌱"
else
	for t in "${TARGET_ARR[@]}"; do
		echo "[+] Restoring $t"

		if [ -d "$BACKUP_FOLDER/$t" ]; then
			cp -rf "$BACKUP_FOLDER/$t" "$HOME/.config/"
		else
			cp -f "$BACKUP_FOLDER/$t" "$HOME/$t"
		fi
	done

	echo "[+] Restore complete! 🌱"
fi
