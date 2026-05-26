#!/bin/bash

# Video drivers
# - mesa: Common driver
# - libva-mesa-driver: Mesa accelerated video decoding for VA-API
# - mesa-vdpau (removed): Mesa accelerated video decoding for VDPAU

sudo pacman -S --needed mesa libva-mesa-driver
echo "[+] Downloading Video Drivers 32 bits"
sudo pacman -S --needed lib32-mesa lib32-libva-mesa-driver xf86-video-amdgp

# AMD drivers
# - xf86-video-amdgpu: base 2D Xorg driver
# - vulkan-radeon: Vulkan support
# - amdvlk (removed): Alternative Vulkan driver
# - vulkan-swrast: Rasterizer

sudo pacman -S --needed xf86-video-amdgpu vulkan-radeon vulkan-swrast
echo "[+] Downloading AMD Drivers 32 bits"
sudo pacman -S --needed lib32-vulkan-radeon lib32-vulkan-swrast

