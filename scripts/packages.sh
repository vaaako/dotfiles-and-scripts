#!/bin/bash

echo -e "\n-> Installing terminal packages"
sleep 2
sudo pacman -Sy --noconfirm --needed \
	zsh \
	exa \
	zoxide \
	neofetch

echo -e "\n-> Installing applications"
echo -e "\n-> vlc, firefox, gimp, xfce4-taskmanager, thunar and wine"
sleep 2
sudo pacman -S --noconfirm --needed \
	vlc \
	firefox \
	gimp \
	xfce4-taskmanager \
	thunar thunar-media-tags-plugin thunar-archive-plugin tumbler ffmpegthumbnailer engrampa \
	xed \
	wine winetricks
# thunar, thunar plugins, tumbler (image thumbnail), ffmpegthumbnailer (video thumbnail) engrampa (archive manager)
# xed: text file view

echo -e "\n-> Installing neovim nightly"
sleep 2
sudo pacman -S --noconfirm --needed bob
bob use latest
bob install nightly

echo -e "\n-> Installing C++ dev tools"
sleep 2
sudo pacman -S --noconfirm --needed \
	base-devel git lazygit clang make cmake gdb valgrind bear mingw-w64-gcc

echo -e "\n-> Installing paru"
sleep 2
if [ ! -f /usr/bin/paru ]; then
	git clone "https://aur.archlinux.org/paru-bin.git"
	cd paru-bin
	makepkg -si
	cd ..
	sudo rm -rf paru-bin
# paru             -- Alias for paru -Syu.
# paru -S <target> -- Install a specific package.
# paru -Sua        -- Upgrade AUR packages.
# paru -Qua        -- Print available AUR updates.
fi

echo -e "\n-> Installing AUR packages"
sleep 2
paru -S --noconfirm vesktop-bin librewolf-bin pokemon-colorscripts

echo -e "\n-> Setting librewolf as default browser"
sleep 2
# Set default browser
xdg-settings set default-web-browser librewolf.desktop
xdg-mime default librewolf.desktop \
	text/html \
	x-scheme-handler/http \
	x-scheme-handler/https

echo -e "\n-> Configuring zsh"
sleep 2
# Plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
# Change default shell
chsh -s $(which zsh)

echo -e "\nAll done! 🌱"
echo -e "\n-> Please restart the PC to apply the new default shell"
