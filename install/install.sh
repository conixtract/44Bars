#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJ_DIR=../$SCRIPT_DIR

USERNAME=forestgump

# give user sudo group
usermod -aG sudo $USERNAME

########################################################
#                installing packages
########################################################
apt update

while IFS= read -r package; do
    # Skip empty lines, lines starting with '[' (section headers), or '#' (comments)
    [[ -z "$package" || "$package" =~ ^[[:space:]]*\[ || "$package" =~ ^[[:space:]]*# ]] && continue
    apt install -y "$package"
done < ./packages.ini

########################################################
#                     symlinking
########################################################
ln -s $PROJ_DIR/config/sway ~/.config/sway
ln -s $PROJ_DIR/config/alacritty ~/.config/alacritty
ln -s $PROJ_DIR/config/rofi ~/.config/rofi

bash rofi-installer.sh
