{ pkgs, ... } :

{
    wayland.windowManager.hyprland = {
        enable = false;
        xwayland.enable = true;
        extraConfig = builtins.readFile ./hyprland.conf;
    };
}
