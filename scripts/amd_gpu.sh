#!/bin/bash

# Video drivers
# - mesa: Common driver
# - libva-mesa-driver: Mesa accelerated video decoding for VA-API
# - mesa-vdpau: Mesa accelerated video decoding for VDPAU

sudo pacman -S --needed mesa libva-mesa-driver mesa-vdpau
# 32-bits
# sudo pacman -S --needed lib32-mesa lib32-libva-mesa-driver lib32-mesa-vdpau

# AMD drivers
# - xf86-video-amdgpu: base 2D Xorg driver
# - vulkan-radeon: Vulkan support
# - amdvlk: Alternative Vulkan driver
# - vulkan-swrast: Rasterizer

sudo pacman -S --needed xf86-video-amdgpu vulkan-radeon vulkan-swrast
# 32-btis
# sudo pacman -S --needed lib32-vulkan-radeon amdvlk lib32-amdvlk lib32-vulkan-swrast

