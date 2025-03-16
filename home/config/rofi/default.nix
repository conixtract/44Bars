{ config, pkgs, colors, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  xdg.configFile."rofi/config.rasi".text = lib.readFile(./rofi-dracula.conf);
}
