#!/bin/bash

echo -e "\n-> Installing terminal packages"
sleep 2
sudo pacman -Sy --noconfirm --needed \
	kitty \
	zsh \
	exa \
	zoxide

echo -e "\n-> Configuring zsh"
sleep 2
# Plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
# Change default shell
chsh -s $(which zsh)

echo -e "\n-> Installing applications"
sleep 2
sudo pacman -S --noconfirm --needed \
	vlc \
	firefox

echo -e "\n-> Installing C++ dev tools"
sleep 2
sudo pacman -S --noconfirm --needed \
	base-devel git clang make cmake gdb valgrind bear mingw-w64-gcc

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
paru -S --noconfirm vesktop-bin


echo -e "\nAll done! 🌱"
