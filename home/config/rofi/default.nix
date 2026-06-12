{
  config,
  pkgs,
  lib,
  ...
}:

let
  DOTFILES = "${config.home.homeDirectory}/44Bars/home/config";
in
{
  programs.rofi = {
    enable = true;
    configPath = "/.tmp/rofi-generated-but-ignored.rasi"; # lul hack
  };
  xdg.configFile."rofi/config.rasi".source = (
    config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/rofi/rofi.conf"
  );
}
