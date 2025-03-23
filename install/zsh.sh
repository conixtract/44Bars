
install() {
    sudo apt install zsh
    # set as default
    chsh -s $(which zsh)
}

remove(){
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

echo "Usage: zsh.sh <install/remove>"

