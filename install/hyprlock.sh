#!/bin/bash

# Dependencies for hyprlock
hyprlock_dependencies=(
  "gcc"                  # C compiler supporting C99 (or use clang)
  "make"                 # build tool
  "cmake"                # build system
  "wayland-client"       # for Wayland support
  "wayland-protocols"    # for Wayland protocols
  "mesa"                 # for OpenGL support
  "mesa-libgbm-dev"      # for graphics buffer management
  "cairo"                # graphics library
  "libdrm-dev"           # Direct Rendering Manager library
  "pango"                # text layout and rendering
  "libxkbcommon-dev"     # for keymap support
  "libpam0g-dev"         # Pluggable Authentication Modules
  "libmagic-dev"         # file utility (file-devel on Fedora)
  "hyprlang-dev"         # Hyprlang (custom language for Hyprlock)
  "hyprutils-dev"        # Hyprlock utility library
  "hyprgraphics-dev"     # Hyprlock graphics library
  "libgles-dev"
)

install() {
  # Check if hyprlock is already installed
  if [ -x "$(command -v hyprlock)" ]; then
    echo "hyprlock is already installed."
    exit
  fi

  ########################################################
  # Install dependencies
  ########################################################
  echo "Installing required dependencies..."
  for package in "${hyprlock_dependencies[@]}"; do
    sudo apt-get install -y "$package"
  done

  ########################################################
  # Set up temporary directory for building Hyprlock
  ########################################################
  tmp_dir="/tmp/Hyprlock"
  echo "Cloning and building Hyprlock in $tmp_dir..."

  # Create the temporary build directory
  mkdir -p "$tmp_dir"
  cd "$tmp_dir"

  # Clone the repository
  git clone https://github.com/hyprwm/Hyprlock.git
  cd Hyprlock

  # Modify CMakeLists.txt (if necessary)
  sed -i '1s/.*/cmake_minimum_required(VERSION 3.24)/' CMakeLists.txt
  echo "Updated CMakeLists.txt for compatibility."

  ########################################################
  # Find GLES3 libraries path (try default system paths)
  ########################################################
  GLES3_INCLUDE_DIR=$(find /usr/include -type d -name "GLES3" -print -quit)
  GLES3_LIBRARIES=$(find /usr/lib -type f -name "libGLESv2.so" -print -quit)

  if [ -z "$GLES3_INCLUDE_DIR" ] || [ -z "$GLES3_LIBRARIES" ]; then
    echo "Could not find GLES3 libraries. Ensure that 'libgles3-mesa-dev' is installed."
    exit 1
  fi

  echo "Found GLES3 include directory: $GLES3_INCLUDE_DIR"
  echo "Found GLES3 libraries: $GLES3_LIBRARIES"

  ########################################################
  # Build and install Hyprlock
  ########################################################
  echo "Building Hyprlock..."
  mkdir build
  cd build

  # Run cmake with GLES3 paths explicitly set
  cmake -DOPENGL_INCLUDE_DIR="$GLES3_INCLUDE_DIR" \
        -DOPENGL_LIBRARIES="$GLES3_LIBRARIES" \
        --no-warn-unused-cli \
        -DCMAKE_BUILD_TYPE:STRING=Release -S .. -B ./build

  cmake --build ./build --config Release --target hyprlock -j$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)
  sudo cmake --install build

  ########################################################
  # Clean up temporary build directory
  ########################################################
  echo "Cleaning up..."
  cd /tmp
  rm -rf "$tmp_dir"

  echo "Hyprlock installed successfully!"
}

remove() {
  echo "Removing Hyprlock..."
  sudo rm -rf /usr/local/bin/hyprlock
  echo "Hyprlock removed successfully."
}

# Check for user argument
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
