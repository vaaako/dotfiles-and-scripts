#!/bin/bash

# Exit if anything fails
set -e

# List of packages to install
FLATPAKS=(
	"io.github.flattool.Warehouse"
	"com.obsproject.Studio"
	"com.usebottles.bottles"
	"org.vinegarhq.Sober"
)

# Check if flatpak exists
if ! command -v flatpak >/dev/null 2>&1; then
	echo "Flatpak not found. Installing..."
	sudo pacman -Sy flatpak --noconfirm
fi


echo "Adding flathub remote if missing..."
if ! flatpak remote-list | grep -q flathub; then
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Install each app
for pkg in "${FLATPAKS[@]}"; do
	echo -e "\n-> Installing $pkg..."
	sleep 1
	flatpak install --system -y flathub "$pkg"
done

echo -e "\nAll done! 🌱"
