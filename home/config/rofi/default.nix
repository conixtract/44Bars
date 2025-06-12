{
  config,
  pkgs,
  colors,
  lib,
  ...
}:

let
  DOTFILES = "/home/forestgump/44Bars/home/config";
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    configPath = "/.tmp/rofi-generated-but-ignored.rasi"; # lul hack
  };
  xdg.configFile."rofi/config.rasi".source = (
    config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/rofi/rofi.conf"
  );
}
