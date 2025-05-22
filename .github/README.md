<div align="center">
  <h1> 44Bars </h1>
</div>
<div align="center">

![OS](https://img.shields.io/badge/OS-NixOS-%230E9DF1?style=for-the-badge)
![compositor](https://img.shields.io/badge/compositor-sway-green?style=for-the-badge)
![Bar](https://img.shields.io/badge/Bar-swaybar-%23FF007E?style=for-the-badge)

![Menu](https://img.shields.io/badge/Menu-Rofi-%23FF6D00?style=for-the-badge)
![Terminal](https://img.shields.io/badge/Terminal-alacritty-%2300DC8D?style=for-the-badge)
![DisplayManager](https://img.shields.io/badge/DM-GDM-%23FFDC00?style=for-the-badge)

<img src="./images/Bobby_Tarantino.jpeg" alt="showcase" width="300" height=auto>

</div>

## Nix
```
home/
    forestgump/
        config/
        home.nix
        ...
hosts/
    44Bars/
        hardware-configuration.nix
        configuration.nix
    ...
```
This is the general structure of my dotfiles.

1. hosts/
- contains machine specific configurations
- `44Bars` contains the configurations for my current laptop

1. home/
- contains home-manager(user specific) configurations and resources

## Screenshots
| <b>Launch Menu</b>                                                                       |
| ---------------------------------------------------------------------------------------- |
| <a href="#--------"><img src="screenshots/rofi-menu.png" alt="bottom panel preview"></a> |

|                                         <b></b>                                          |                                            <b></b>                                             |
| :--------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------: |
| <a href="#--------"><img src="screenshots/home-html.png" alt="bottom panel preview"></a> | <a href="#--------"><img src="screenshots/example-working.png" alt="bottom panel preview"></a> |

## Installation
Don't

just ... just don't

## To-DO

- [ ] setup global color files
- [ ] wallpaper changer (rofi script like https://github.com/develcooking/hyprland-dotfiles/blob/main/.config/rofi/wallpaper-launcher.sh) or wall-d
