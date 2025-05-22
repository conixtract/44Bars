<div align="center">
  <h1> 44Bars </h1>
</div>
<div align="center">

![OS](https://img.shields.io/badge/OS-NixOS-%230E9DF1?style=for-the-badge)
![compositor](https://img.shields.io/badge/compositor-hyprland-green?style=for-the-badge)
![Bar](https://img.shields.io/badge/Bar-waybar-%23FF007E?style=for-the-badge)

![Menu](https://img.shields.io/badge/Menu-Rofi-%23FF6D00?style=for-the-badge)
![Terminal](https://img.shields.io/badge/Terminal-Kitty-%2300DC8D?style=for-the-badge)
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
    shared/
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
- `old44Bars` contains the configurations for my old (dead) surfcae

2. home/
- contains home-manager(user specific) configurations
- `shared` contains wallpapers, color schemes, scripts etc.

## Screenshots
| <b>Launch Menu</b>                                                                       |
| ---------------------------------------------------------------------------------------- |
| <a href="#--------"><img src="screenshots/rofi_menu.png" alt="bottom panel preview"></a> |

|                                     <b>Lock Screen</b>                                     |                                     <b>Login Screen</b>                                     |
| :----------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------: |
| <a href="#--------"><img src="screenshots/lock_screen.png" alt="bottom panel preview"></a> | <a href="#--------"><img src="screenshots/login_screen.png" alt="bottom panel preview"></a> |

## Installation
Don't

just ... just don't

## To-DO

- [ ] setup global color files
- [ ] wallpaper changer (rofi script like https://github.com/develcooking/hyprland-dotfiles/blob/main/.config/rofi/wallpaper-launcher.sh) or wall-d

## Credits old44Bars
> **Note**
>
> I do apologies for missing credits as I started documenting after I already had a basic setup.

- [chadcat](https://github.com/chadcat7)
    - style of readme
    - folder structure
- [Teenarp](https://github.com/Teenarp2003)
    - polybar
- [Ronnie Nissan](https://github.com/ronniedroid)
    - Wall-d
- [Michael Peyton Jones](https://github.com/michaelpj)
    - sddm theme nix package
- [David Worms](https://www.adaltas.com/en/2022/03/29/nix-package-creation-install-font/)
    - font packaging
