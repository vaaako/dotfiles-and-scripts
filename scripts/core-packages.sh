#!/bin/bash

echo "[+] Starting 'drivers' install..."
echo "[+] See script content for packages details"
sleep 10

echo "[+] Installing GVFS backends..."
sleep 2
sudo pacman -S --noconfirm --needed autotiling

# --- VIRTUAL FILESYSTEM (for mounting phones, network shares, etc.) ---
# gvfs: The backend that allows apps to access virtual filesystems
# gvfs-mtp: For Android phones/MTP devices
# gvfs-google: For Google Drive
# gvfs-nfs: For Network File System shares
echo "[+] Installing GVFS backends..."
sleep 2
sudo pacman -S --noconfirm --needed \
	gvfs \
	gvfs-google \
	gvfs-mtp \
	gvfs-nfs


echo "[+] Installing ffmpeg and audio codecs"
sleep 2
sudo pacman -S --noconfirm --needed \
	ffmpeg \
	gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-plugins-base \
	gst-libav gstreamer


# pipewire: The modern audio/video server
# wireplumber: The session manager for PipeWire
# pipewire-alsa, pipewire-pulse, pipewire-jack: Compatibility layers for applications expecting ALSA, PulseAudio, or JACK
# pavucontrol: A simple GUI volume mixer for PulseAudio (works with pipewire-pulse)
echo "[+] Installing pipewire"
sleep 2
sudo pacman -S --needed \
	pipewire wireplumber \
	pipewire-alsa pipewire-pulse pipewire-jack \
	pipewire-openrc pipewire-pulse-openrc wireplumber-openrc \
	pavucontrol


# blueman: A GTK Bluetooth manager (good choice)
# ufw: firewall
echo "[+] Installing System Utilities"
sudo pacman -Sy --noconfirm --needed \
	bluez bluez-openrc bluez-libs bluez-plugins bluez-utils blueman \
	ufw ufw-openrc gufw \


echo "[+] Installing fonts"
sleep 2
sudo pacman -Sy --noconfirm --needed \
	ttf-jetbrains-mono-nerd \
	ttf-iosevka-nerd ttf-iosevkaterm-nerd \
	ttf-ubuntu-font-family \
	ttf-liberation \
	# ttf-cascadia-code \
	noto-fonts \
	noto-fonts-cjk \
	noto-fonts-emoji



echo "[+] Package installation complete."
echo "[+] Now enabling essential services..."
sleep 2

# -- ENABLE SERVICES

# Enable the PipeWire audio services for your user
# No 'sudo' and use '--user' flag
# systemctl --user enable --now pipewire pipewire-pulse wireplumber
rc-update add -U pipewire default
rc-update add -U pipewire-pulse default
rc-update add -U wireplumber default

# Enable Bluetooth service
# sudo systemctl enable bluetooth.service
sudo rc-update add bluetoothd default

# Enable the firewall
# sudo systemctl enable --now ufw.service
sudo rc-update add ufw default


echo -e "\nAll done! 🌱"
