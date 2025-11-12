#!/bin/bash

FONT_DIR="$HOME/.local/share/fonts"
ICON_DIR="$HOME/.icons"
THEME_DIR="$HOME/.themes"

# Create if missing
mkdir -p "$FONT_DIR" "$ICON_DIR" "$THEME_DIR"

echo "-> Installing icons"
sleep 3
# Extract all to destiny
for zip in icons/*.zip; do
	[ -f "$zip" ] || continue
	echo "Extracting $zip..."
	unzip -o "$zip" -d "$ICON_DIR"
done

echo -e "\n-> Installing themes"
sleep 3
# Extract all to destiny
for zip in themes/*.zip; do
	[ -f "$zip" ] || continue
	echo "Extracting $zip..."
	unzip -o "$zip" -d "$THEME_DIR"
done

echo -e "\n-> Installing fonts"
sleep 3
cp -v fonts/*.{ttf,otf} "$FONT_DIR" 2>/dev/null || true

echo -e "\n-> Updating font cache"
sleep 3
fc-cache -f "$FONT_DIR"
