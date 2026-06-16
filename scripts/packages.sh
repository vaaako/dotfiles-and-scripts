#!/bin/bash

echo "[+] Fetching fastet mirrors"
sleep 2
sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "[+] Installing terminal packages"
sleep 2
sudo pacman -Sy --noconfirm --needed \
	zsh \
	exa \
	zoxide \
	neofetch

echo "[+] Installing applications"
echo "vlc, waterfox, gimp, qbittorrent, xfce4-taskmanager, thunar, wine and libreoffice"
sleep 2
sudo pacman -S --noconfirm --needed \
	vlc waterfox \
	gimp \
	qbittorrent \
	xfce4-taskmanager \
	thunar thunar-media-tags-plugin thunar-archive-plugin \
	tumbler ffmpegthumbnailer engrampa \
	xed \
	wine winetricks \
	libreoffice-still
# thunar, thunar plugins, tumbler (image thumbnail), ffmpegthumbnailer (video thumbnail) engrampa (archive manager)
# xed: text file view

echo "[+] Installing neovim"
sleep 2
sudo pacman -S --noconfirm --needed neovim


echo "[+] Installing C++ dev tools"
sleep 2
sudo pacman -S --noconfirm --needed \
	base-devel git lazygit clang make cmake gdb valgrind bear mingw-w64-gcc

echo "[+] Installing yay"
sleep 2
if [ ! -f /usr/bin/yay ]; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	sudo rm -rf yay
fi

echo "[+] Installing AUR packages"
sleep 2
yay -S --noconfirm vesktop-bin pokemon-colorscripts-git

echo "[+] Setting librewolf as default browser"
sleep 2
# Set default browser
xdg-settings set default-web-browser librewolf.desktop
xdg-mime default librewolf.desktop \
	text/html \
	x-scheme-handler/http \
	x-scheme-handler/https

echo "[+] Configuring zsh"
sleep 2
# Plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
# Change default shell
chsh -s $(which zsh)

echo -e "\nAll done! 🌱"
echo "[+] Please restart the PC to apply the new default shell"
