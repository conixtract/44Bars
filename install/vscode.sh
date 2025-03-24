install() {
    # check if vscode already installed
    if [ -x "$(command -v code)" ]; then
        echo "VS Code is already installed."
        exit
    fi

    # Import the Microsoft GPG key
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

    # Add the VS Code repository
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    # Update package lists and install code
    sudo apt update
    sudo apt install -y code

    # Set the Ozone platform hint to Wayland
    echo "ELECTRON_OZONE_PLATFORM_HINT=wayland" | sudo tee -a /etc/environment

    # Clean up
    rm packages.microsoft.gpg
}

remove() {
    sudo apt --purge remove code
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
