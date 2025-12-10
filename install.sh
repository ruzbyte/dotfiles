#!/bin/bash
set -e

if [[ "$PWD" != "$HOME/dotfiles" ]]; then
    echo "Error: Please run this script from $HOME/dotfiles"
    exit 1
fi

PACMAN_PACKAGES="stow hyprland hyprpaper waybar rofi-wayland alacritty thunar firefox swaylock dunst polkit-kde-agent grim slurp ttf-jetbrains-mono-nerd"

AUR_PACKAGES="visual-studio-code-bin"

sudo pacman -Syu

# Install pacman packages
sudo pacman -S --needed $PACMAN_PACKAGES

# Install AUR packages
~/scripts/install-yay.sh
yay -S --needed $AUR_PACKAGES

echo "All packages installed successfully"

stow --adopt .
echo "Dotfiles stowed successfully"