#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# basic install script for the system

usermod -aG sudo forestgump

apt update

base_packages=("sudo" "lightdm" "sway" "swaybg" "rofi")

for package in "${packages[@]}"; do
    apt install -y "$package"
done

while IFS= read -r package; do
    apt install -y "$package"
done <./packages.ini

# link the config files
ln -s $SCRIPT_DIR/config/sway ~/.config/sway
