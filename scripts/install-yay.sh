#!/bin/bash

# Install yay AUR helper

set -e

# Install dependencies
sudo pacman -S --needed base-devel git

# Clone yay repository
git clone https://aur.archlinux.org/yay.git ~/tmp/yay
cd ~/tmp/yay

# Build and install
makepkg -si

echo "yay installed successfully"
rm -rf ~/tmp/yay