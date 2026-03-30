#!/bin/bash

BASE=$(find . -type d -name "interface")

FONT_DIR="$HOME/.local/share/fonts"
ICON_DIR="$HOME/.icons"
THEME_DIR="$HOME/.themes"

# Create if missing
mkdir -p "$FONT_DIR" "$ICON_DIR" "$THEME_DIR"

if ! command -v unzip >/dev/null 2>&1; then
	echo "unzip not found. Installing..."
	sudo pacman -S --noconfirm unzip
fi

echo "-> Moving wallpapers"
sleep 3
mkdir -p ~/Pictures/Wallpapers
cp -a "$BASE/wallpapers/." "$HOME/Pictures/Wallpapers/"

echo "-> Installing icons"
sleep 3
# Extract all to destiny
for zip in "$BASE/icons/"*.zip; do
	[ -f "$zip" ] || continue
	echo "Extracting $zip..."
	unzip -o "$zip" -d "$ICON_DIR"
done

echo -e "\n-> Installing themes"
sleep 3
# Extract all to destiny
for zip in "$BASE/themes/"*.zip; do
	[ -f "$zip" ] || continue
	echo "Extracting $zip..."
	unzip -o "$zip" -d "$THEME_DIR"
done

echo -e "\n-> Installing fonts"
sleep 3
cp -v "$BASE/fonts"/*.{ttf,otf} "$FONT_DIR" 2>/dev/null || true

echo -e "\n-> Updating font cache"
sleep 3
fc-cache -f "$FONT_DIR"
