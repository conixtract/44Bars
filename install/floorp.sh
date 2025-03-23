
install() {
    curl -fsSL https://ppa.ablaze.one/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/Floorp.gpg
    sudo curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list 'https://ppa.ablaze.one/Floorp.list'

    sudo apt update
    sudo apt install floorp
}

remove(){
    sudo apt --purge remove floorp
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

echo "Usage: floorp.sh <install/remove>"

