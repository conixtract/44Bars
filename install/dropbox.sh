#!/bin/bash

install() {
    if dpkg -l | grep -q dropbox; then
        echo "Dropbox is already installed."
        exit
    fi

    echo "Downloading Dropbox .deb package..."
    wget -O dropbox.deb https://linux.dropbox.com/packages/debian/dropbox_2020.03.04_amd64.deb

    echo "Installing Dropbox..."
    sudo apt install -y ./dropbox.deb

    echo "Cleaning up..."
    rm -f dropbox.deb
}

remove() {
    echo "Removing Dropbox..."
    sudo apt --purge remove dropbox
}

if [ "$1" = "install" ]; then
    install
    exit
fi

if [ "$1" = "remove" ]; then
    remove
    exit
fi

filename=$(basename "$0")
echo "Usage: $filename <install/remove>"
