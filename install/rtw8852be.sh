#!/bin/bash

rtw_driver_deps=(
  "dkms"
  "debhelper"
  "dh-modaliases"
  "build-essential"
)

TMP_DIR="/tmp/rtw8852be-build"
DEB_URL="http://kr.archive.ubuntu.com/ubuntu/pool/main/u/ubuntu-drivers-common/dh-modaliases_0.2.91.4_all.deb"
DRIVER_REPO="https://github.com/lwfinger/rtw8852be.git"

install() {
  echo "[*] Installing rtw8852be driver..."

  # Check if already installed
  if dkms status | grep -q rtw8852be; then
    echo "rtw8852be is already installed via DKMS."
    exit 0
  fi

  # Install dependencies
  for pkg in "${rtw_driver_deps[@]}"; do
    sudo apt-get install -y "$pkg"
  done

  # Get updated dh-modaliases if needed
  wget "$DEB_URL" -O /tmp/dh-modaliases.deb
  sudo dpkg -i /tmp/dh-modaliases.deb
  rm /tmp/dh-modaliases.deb

  # Prepare temp build directory
  mkdir -p "$TMP_DIR"
  cd "$TMP_DIR"

  # Clone the repo
  git clone "$DRIVER_REPO"
  cd rtw8852be

  # Build the DKMS package
  dpkg-buildpackage -us -uc

  # Install the resulting .deb package
  cd ..
  sudo apt install -y ./rtw8852be-dkms_*.deb

  echo "[✓] rtw8852be installed successfully."

  # Cleanup
  rm -rf "$TMP_DIR"
}

remove() {
  echo "[*] Removing rtw8852be driver..."
  sudo dkms remove rtw8852be/1.0.0 --all
  echo "[✓] Removed."
}

filename=$(basename "$0")
if [ "$1" = "install" ]; then
  install
  exit
fi

if [ "$1" = "remove" ]; then
  remove
  exit
fi

echo "Usage: $filename <install/remove>"
