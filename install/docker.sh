#!/bin/bash

# Dependencies required for Docker installation
docker_dependencies=(
    "apt-transport-https" # Allows apt to use HTTPS for repositories
    "ca-certificates"     # Provides CA certificates
    "curl"                # Command line tool for transferring data
    "gnupg"               # GPG for key management
    "lsb-release"         # Provides information about the Debian release
)

install() {
    # Check if Docker is already installed
    if [ -x "$(command -v docker)" ]; then
        echo "Docker is already installed."
        exit
    fi

    ########################################################
    #            Install Docker via Official Repository
    ########################################################

    # Remove any old versions of Docker
    sudo apt-get remove -y docker docker-engine docker.io containerd runc

    # Install prerequisites
    for package in "${docker_dependencies[@]}"; do
        sudo apt-get install -y "$package"
    done

    # Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Set up the stable repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

    # Update package index and install Docker Engine
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # Optionally, add the current user to the docker group for non-root usage
    sudo usermod -aG docker "$USER"

    echo "Docker installation complete. Please log out and back in for group changes to take effect."
}

remove() {
    sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
    sudo rm -f /etc/apt/sources.list.d/docker.list
    sudo rm -f /usr/share/keyrings/docker-archive-keyring.gpg
    echo "Docker removal complete."
}

# Compare the strings using the '=' operator.
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
