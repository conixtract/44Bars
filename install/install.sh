#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJ_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
HOME_DIR="$HOME"

########################################################
#                installing packages
########################################################
sudo apt update

while IFS= read -r package; do
    cd $PROJ_DIR
    # Skip empty lines, section headers (lines starting with '['), or comments (lines starting with '#')
    [[ -z "$package" || "$package" =~ ^[[:space:]]*\[ || "$package" =~ ^[[:space:]]*# ]] && continue

    # Check if a script for the package exists in $SCRIPT_DIR
    if [[ -f "$SCRIPT_DIR/$package.sh" ]]; then
        echo "Running $package.sh for package '$package'..."
        bash "$SCRIPT_DIR/$package.sh" install
    else
        echo "Installing '$package' using apt..."
        sudo apt install -y "$package"
    fi
done <./packages.ini

########################################################
#                     symlinking
########################################################
ln -s $PROJ_DIR/config/zsh/.zshrc $HOME_DIR/.zshrc

mkdir $HOME_DIR/.config -p
ln -s $PROJ_DIR/config/sway $HOME_DIR/.config/sway
ln -s $PROJ_DIR/config/alacritty $HOME_DIR/.config/alacritty
ln -s $PROJ_DIR/config/rofi $HOME_DIR/.config/rofi

mkdir $HOME_DIR/.swaylock -p
ln -s $PROJ_DIR/config/swaylock/config $HOME_DIR/.swaylock/config

########################################################
#                     configuring lightdm
########################################################
# disable default xsession in lightdm
echo "NoDisplay=true" | sudo tee -a /usr/share/xsessions/lightdm-xsession.desktop
