#!/bin/bash
set -e

# Find backup folder. Get first find
INTERFACE_FOLDER=$(find . -type d -name "interface" | head -n 1)
if [ -z "$INTERFACE_FOLDER" ]; then
	INTERFACE_FOLDER="./"
fi

FONT_DIR="$HOME/.local/share/fonts"
ICON_DIR="$HOME/.icons"
THEME_DIR="$HOME/.themes"
WALL_DIR="$HOME/Pictures/Wallpapers"

mkdir -p "$FONT_DIR" "$ICON_DIR" "$THEME_DIR" "$WALL_DIR"

if ! command -v unzip >/dev/null 2>&1; then
	echo "[+] Installing unzip..."
	sudo pacman -S --noconfirm unzip
fi

echo "[+] Moving wallpapers"
cp -a "$INTERFACE_FOLDER/wallpapers/." "$WALL_DIR/"

echo "[+] Installing icons"
for zip in "$INTERFACE_FOLDER/icons/"*.zip; do
	[ -f "$zip" ] || continue
	unzip -o "$zip" -d "$ICON_DIR"
done

echo "[+] Installing themes"
for zip in "$INTERFACE_FOLDER/themes/"*.zip; do
	[ -f "$zip" ] || continue
	unzip -o "$zip" -d "$THEME_DIR"
done

echo "[+] Installing fonts"
cp -a "$INTERFACE_FOLDER/fonts/." "$FONT_DIR/"

echo "[+] Updating font cache"
fc-cache -fv
