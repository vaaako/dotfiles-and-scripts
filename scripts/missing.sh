#!/bin/bash

echo "Starting missing packages install..."
echo "See script content for packages details"
sleep 10


# --- VIRTUAL FILESYSTEM (for mounting phones, network shares, etc.) ---
# gvfs: The backend that allows apps to access virtual filesystems
# gvfs-mtp: For Android phones/MTP devices
# gvfs-google: For Google Drive
# gvfs-nfs: For Network File System shares
echo "Installing GVFS backends..."
sleep 3
sudo pacman -S --noconfirm --needed \
	gvfs \
	gvfs-google \
	gvfs-mtp \
	gvfs-nfs


echo -e "\n-> Installing ffmpeg and audio codecs"
sleep 3
sudo pacman -S --noconfirm --needed \
	ffmpeg \
	gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-plugins-base \
	gst-libav gstreamer


# pipewire: The modern audio/video server
# wireplumber: The session manager for PipeWire
# pipewire-alsa, pipewire-pulse, pipewire-jack: Compatibility layers for applications expecting ALSA, PulseAudio, or JACK
# pavucontrol: A simple GUI volume mixer for PulseAudio (works with pipewire-pulse)
echo -e "\n-> Installing pipewire"
sleep 3
sudo pacman -S --noconfirm --needed \
	pipewire wireplumber \
	pipewire-alsa pipewire-pulse pipewire-jack \
	pavucontrol


# xdg-utils: For scripts that open files and URLs with default applications (xdg-open)
# xdg-user-dirs: To manage user directories like ~/Documents, ~/Pictures, etc.
# xfce4-taskmanager: Personal taskmanager
# polkit: A policy kit for managing system-wide privileges
# brightnessctl: A utility to control screen brightness
# blueman: A GTK Bluetooth manager (good choice)
echo "Installing System Utilities..."
sudo pacman -S --noconfirm --needed \
	xdg-utils xdg-user-dirs \
	xfce4-taskmanager \
	polkit brightnessctl \
	bluez bluez-libs bluez-plugins bluez-utils blueman \
	ufw gufw \


echo -e "\n-> Installing fonts"
sleep 3
sudo pacman -S --noconfirm --needed \
	ttf-jetbrains-mono-nerd \
	ttf-ubuntu-font-family \
	ttf-liberation \
	ttf-cascadia-code \
	noto-fonts \
	noto-fonts-cjk \
	noto-fonts-emoji



echo "Package installation complete."
echo "Now enabling essential services..."



# -- ENABLE SERVICES

# Enable the Login Manager
sudo systemctl enable ly.service

# Enable the PipeWire audio services for your user
# No 'sudo' and use '--user' flag
sudo systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service

# Enable Bluetooth service
sudo systemctl enable bluetooth.service

# Enable the firewall
sudo systemctl enable --now ufw.service

