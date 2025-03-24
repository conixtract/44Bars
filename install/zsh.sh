install() {
    # check if zsh already installed
    if [ -x "$(command -v zsh)" ]; then
        echo "zsh is already installed"
        exit
    fi

    sudo apt install -y zsh
    # set as default
    sudo chsh -s $(which zsh)

    # oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # install autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

remove() {
    sudo apt remove zsh
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
