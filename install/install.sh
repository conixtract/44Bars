#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJ_DIR="../$SCRIPT_DIR"

########################################################
#                installing packages
########################################################
sudo apt update

while IFS= read -r package; do
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
mkdir ~/.config -p
ln -s $PROJ_DIR/config/sway ~/.config/sway
ln -s $PROJ_DIR/config/alacritty ~/.config/alacritty
ln -s $PROJ_DIR/config/rofi ~/.config/rofi
