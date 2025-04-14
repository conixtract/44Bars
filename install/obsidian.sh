#!/bin/bash

install() {
    if dpkg -l | grep -q obsidian; then
        echo "obsidian is already installed."
        exit
    fi

    echo "Downloading obsidian .deb package..."
    wget -O obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.8.9/obsidian_1.8.9_amd64.deb

    echo "Installing obsidian..."
    sudo apt install -y ./obsidian.deb

    echo "Cleaning up..."
    rm -f obsidian.deb
}

remove() {
    echo "Removing obsidian..."
    sudo apt --purge remove obsidian
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
