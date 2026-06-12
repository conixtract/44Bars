{
  config,
  pkgs,
  lib,
  ...
}:
let
  HOME = builtins.getEnv "HOME";
  DOTFILES = "/home/forestgump/44Bars/home/config";
in
{
  # some general info
  home.username = "forestgump";
  home.homeDirectory = "/home/forestgump";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  imports = [
    (import ./config/rofi/default.nix {
      inherit
        config
        pkgs
        lib
        ;
    })
    (import ./config/vscode/default.nix)
    (import ./config/polybar/default.nix)
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  # dropbox setup from https://nixos.wiki/wiki/Dropbox
  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
    };
  };

  services.swaync.enable = true;

  services.clipman.enable = true;

  services.hypridle = {
    enable = true;
    settings = { };
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    waybar = {
      enable = true;
      systemd.enable = true;
    };
    hyprlock = {
      enable = true;
    };
    alacritty = {
      enable = true;
      settings = { };
    };
  };
  xdg.portal = {
    enable = true;
    # we need both because "xdg-desktop-portal 1.17 reworked config" is weird
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr # this is for waybar to work
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  programs.java = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initContent = ''
      eval "$(direnv hook zsh)"
    ''
    # LFCD=${HOME}/44Bars/home/scripts/lfcd.sh
    + builtins.readFile ./scripts/lfcd.sh
    + builtins.readFile ./config/zsh/.zshrc;

    shellAliases = {
      la = "ls -a -l -h";
      ls = "ls --color=auto";
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";
      take-out-trash = "sudo nix-collect-garbage --delete-older-than 5d && nix-collect-garbage --delete-older-than 5d";
      open = "xdg-open";
      vpn = ''sudo openconnect -v vpn.rwth-aachen.de --useragent=AnyConnect -b --authgroup="RWTH-VPN (Full Tunnel)" --user="fx245575"'';
      koki = "cd ~/dev/KoKi-Website";
      connect-koch-vpn = "sudo swanctl --load-all --file ~/.config/strongswan/swanctl.conf && sudo swanctl --initiate --child net";
      disconnect-koch-vpn = "sudo swanctl --terminate --child net && sudo systemctl restart strongswan-swanctl.service";
      nix-home = "code ~/44Bars";
      hiwi = "cd ~/dev/fracturing";
    };

    oh-my-zsh = {
      enable = true;
      custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
      theme = "powerlevel10k";
      plugins = [
        "git"
      ];
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    keymap = {
      mgr.prepend_keymap = [
        {
          # The key you want to press — "!" is yazi's default for this, but pick anything
          on = "!";
          run = ''shell "zsh" --block'';
          desc = "Open shell in current directory";
        }
      ];
    };
  };

  programs.git = {
    enable = true;
    signing.format = null;

    settings = {
      alias = {
        lg = "lg1";
        lg1 = "lg1-specific --all";
        lg2 = "lg2-specific --all";
        lg3 = "lg3-specific --all";

        lg1-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";

        lg2-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white) - %an%C(reset)'";

        lg3-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white) - %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";

        cleanup-local-branches = "!git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs -r git branch -D";
      };
    };
  };

  # override the default config files
  xdg.configFile."hypr/hypridle.conf".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/hyprland/hypridle.conf"
  );
  xdg.configFile."alacritty/alacritty.toml".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/alacritty/alacritty.toml"
  );
  xdg.configFile."sway/config".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/sway/sway.conf"
  );
  xdg.configFile."waybar/config".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/waybar/waybar.conf"
  );
  xdg.configFile."waybar/style.css".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/waybar/style.css"
  );

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "floorp.desktop";
      "text/html" = "floorp.desktop";
      "x-scheme-handler/http" = "floorp.desktop";
      "x-scheme-handler/https" = "floorp.desktop";
      "x-scheme-handler/chrome" = "floorp.desktop";
      "application/xhtml+xml" = "floorp.desktop";
      "application/x-extension-htm" = "floorp.desktop";
      "application/x-extension-html" = "floorp.desktop";
      "application/x-extension-shtml" = "floorp.desktop";
      "application/x-extension-xhtml" = "floorp.desktop";
      "application/x-extension-xht" = "floorp.desktop";
      "application/json" = "code.desktop";
      "text/css" = "code.desktop";
    };
  };

  # virtualiztion
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };

  home = {
    file = {
      ".config/hypr/hyprlock.conf".source = ./config/hyprland/hyprlock.conf;

      ".config/Code/User/settings.json".source = lib.mkForce (
        config.lib.file.mkOutOfStoreSymlink "${DOTFILES}/vscode/settings.json"
      );
    };

    packages = with pkgs; [
      floorp-bin
      networkmanager_dmenu
      zsh-powerlevel10k
      imagemagick
      wl-clipboard
      hyprshot
      nixpkgs-fmt
      beekeeper-studio
      openconnect
      obsidian
      feh
      rsync
      qt6.qtwayland
      libnotify
      libqalculate
      killall
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
      gh
      rustfmt
      power-profiles-daemon
      desmume
      meshlab
      claude-code
      chromium
      dnsutils
      blender
    ];

    sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      EDITOR = "code";
      BROWSER = "floorp";
      FILE = "yazi";
      TERMINAL = "alacritty";
      garden = "${HOME}/Dropbox/digital-garden/";
    };
    sessionPath = [
      "${HOME}/.local/bin"
      "${HOME}/44Bars/home/scripts"
    ];
  };
}
