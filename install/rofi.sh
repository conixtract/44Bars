# installed in /usr/local/

rofi_dependencies=(
  "gcc"                           # C compiler supporting C99 (or use clang)
  "make"                          # build tool
  "autoconf"                      # for generating configuration scripts
  "automake"                      # automake (version 1.11.3 or newer)
  "pkg-config"                    # for dependency configuration
  "flex"                          # lexical analyzer (>= 2.5.39)
  "bison"                         # parser generator
  "check"                         # build-time tests (can be disabled)
  "libglib2.0-dev-bin"            # provides glib-compile-resources
  "libpango1.0-dev"               # libpango (>= 1.50)
  "libpangocairo-dev"             # libpangocairo
  "libcairo2-dev"                 # libcairo and libcairo-xcb
  "libglib2.0-dev"                # libglib2.0 (includes gmodule-2.0, gio-unix-2.0)
  "libgdk-pixbuf2.0-dev"          # libgdk-pixbuf-2.0
  "libstartup-notification-dev"   # libstartup-notification-1.0
  "libxkbcommon-dev"              # libxkbcommon (>= 0.4.1)
  "libxkbcommon-x11-dev"          # libxkbcommon-x11
  "libxcb1-dev"                   # libxcb
  "libxcb-xkb-dev"                # libxcb-xkb
  "libxcb-randr0-dev"             # libxcb-randr
  "libxcb-xinerama0-dev"          # libxcb-xinerama
  "xcb-util-dev"                  # xcb-util
  "libxcb-ewmh-dev"               # xcb-util-wm part (libxcb-ewmh)
  "libxcb-icccm-dev"              # xcb-util-wm part (libxcb-icccm)
  "libxcb-cursor-dev"             # xcb-util-cursor
  "libxcb-imdkit-dev"             # xcb-imdkit (optional, 1.0.3+ preferred)
  "libwayland-dev"                # for Wayland support
  "wayland-protocols"             # Wayland protocols (>= 1.17)
  "libxcb-icccm4-dev"
  "libstartup-notification0-dev"
)

install() {
  ########################################################
  #           build rofi with wayland support
  ########################################################

  for package in "${rofi_dependencies[@]}"; do
      sudo apt-get install -y "$package"
  done

  # clone and build rofi-wayland repo
  cd $SCRIPT_DIR
  gh repo clone in0ni/rofi-wayland
  cd rofi-wayland
  meson setup build/
  ninja -C build install

  # rm build files
  cd $SCRIPT_DIR
  rm -rf rofi-wayland
}

remove() {
  sudo rm -rf /usr/local/bin/rofi
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

echo "Usage: rofi.sh <install/remove>"
