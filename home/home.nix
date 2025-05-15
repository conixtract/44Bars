{ config, pkgs, lib, ... }:
let
  colors = import ../colors/rose.nix { };
  HOME = builtins.getEnv "HOME";
in {
  # some general info  
  home.username = "forestgump";
  home.homeDirectory = "/home/forestgump";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ./config/hyprland/default.nix)
    (import ./config/rofi/default.nix { inherit config pkgs colors lib; })
    (import ./config/vscode/default.nix)
    (import ./config/polybar/default.nix)
  ];

  wayland.windowManager.sway.enable = true;

  # dropbox setup from https://nixos.wiki/wiki/Dropbox
  systemd.user.services.dropbox = {
    Unit = { Description = "Dropbox service"; };
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
    };
  };

  services.swaync.enable = true;

  services.hyprpaper = {
    enable = true;
    settings =
      { }; # ! set to empty set such that the config file is not generated and i can place my own
  };
  services.clipman.enable = true;

  services.hypridle = {
    enable = true;
    settings = { };
  };
  services.blueman-applet.enable = true;

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    firefox = { enable = true; };
    waybar = {
      enable = true;
      systemd.enable = false;
      settings = { };
      style = builtins.readFile ./config/waybar/style.css;
    };
    hyprlock = { enable = true; };
    alacritty = {
      enable = true;
      settings = { };
    };
  };

  programs.java = { enable = true; };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
      LFCD=${HOME}/44Bars/home/scripts/lfcd.sh
    '' + builtins.readFile ./scripts/lfcd.sh;

    shellAliases = {
      la = "ls -a -l -h";
      ls = "ls --color=auto";
      update = "sudo nixos-rebuild switch";
      upgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";
      take-out-trash = "sudo nix-collect-garbage --delete-older-than 5d";
      open = "xdg-open";
      vpn = ''
        sudo openconnect -v vpn.rwth-aachen.de --useragent=AnyConnect -b --authgroup="RWTH-VPN (Full Tunnel)" --user="fx245575"'';
      koki = "cd ~/dev/KoKi-Website/ && nix-shell shell.nix";
      connect-koch-vpn =
        "sudo swanctl --load-all --file ~/.config/strongswan/swanctl.conf && sudo swanctl --initiate --child net";
      disconnect-koch-vpn =
        "sudo swanctl --terminate --child net && sudo systemctl restart strongswan";
      nix = "code ~/44Bars";
      hiwi = "cd ~/dev/bachelor-thesis && nix-shell shell.nix";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ ];
    };
  };

  programs.git = {
    enable = true;

    extraConfig = {
      alias = {
        lg = "lg1";
        lg1 = "lg1-specific --all";
        lg2 = "lg2-specific --all";
        lg3 = "lg3-specific --all";

        lg1-specific =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";

        lg2-specific =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white) - %an%C (reset)'";

        lg3-specific =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white) - %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";
      };
    };
  };

  # override the default config files
  xdg.configFile."hypr/hyprpaper.conf" =
    lib.mkForce { source = ./config/hyprland/hyprpaper.conf; };
  xdg.configFile."hypr/hypridle.conf" =
    lib.mkForce { source = ./config/hyprland/hypridle.conf; };
  xdg.configFile."alacritty/alacritty.toml" =
    lib.mkForce { source = ./config/alacritty/alacritty.toml; };

  xdg.configFile."waybar/config" =
    lib.mkForce { source = ./config/waybar/waybar.conf; };

  xdg.configFile."sway/config" =
    lib.mkForce { source = ./config/sway/sway.conf; };

  xdg.mimeApps.defaultApplications = { "inode/directory" = [ "lf.desktop" ]; };

  # virtualiztion
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };

  nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.1.5" ];

  home = {
    file = {
      ".config/hypr/hyprlock.conf".source = ./config/hyprland/hyprlock.conf;
      # ".config/i3/config".source = ../pk/config/i3/config;
    };
    packages = with pkgs; [
      remmina
      floorp
      wl-clipboard
      hyprshot
      nixpkgs-fmt
      beekeeper-studio
      gitkraken
      openconnect
      obsidian
      feh
      rsync
      qt6.qtwayland
      libnotify
      whatsapp-for-linux
      (pkgs.mailspring.overrideAttrs (oldAttrs: rec {
        postInstall = ''
          wrapProgram $out/bin/mailspring --add-flags "--password-store=gnome-libsecret"
        '';
      }))
      spotify
      lf
      libqalculate
      element-desktop
      killall
      volantes-cursors
      strongswan
      unzip
      texlive.combined.scheme-full
      tex-fmt # latex formatter
      nixfmt
      swaybg
      i3status
      acpi
      alsa-utils
      htop
      kdePackages.okular
      tree
      include-what-you-use
    ];
    sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      EDITOR = "code";
      BROWSER = "floorp";
      TERMINAL = "alacritty";
      garden = "$HOME/Dropbox/digital-garden/";
    };
    sessionPath = [ "$HOME/.local/bin" "$HOME/44Bars/home/scripts" ];
  };
}

