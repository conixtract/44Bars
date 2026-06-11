{ config, pkgs, ... }:

let
  # themes = pkgs.callPackage ../../derivs/sddm-themes.nix { }; # for sddm
  # dancing-script = pkgs.callPackage ../../derivs/dancing-script.nix { }; # for sddm
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "44Bars"; # Define your hostname.

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
    # authKeyFile = "path"; # alternatively use tailscale up
  };

  # bluetooth applet
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  # audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # change location of the configuration.nix file
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" # dont change this
    "/nix/var/nix/profiles/per-user/root/channels" # neither this
    "nixos-config=${config.users.users.forestgump.home}/44Bars/hosts/44Bars/configuration.nix"
  ];

  # natural srcolling
  services.libinput.touchpad.naturalScrolling = true;

  # virtualization
  # virtualisation.libvirtd.enable = true;
  # virtualisation.libvirtd.qemu.ovmf.enable = true;
  # programs.virt-manager.enable = true;

  programs = {
    hyprland.enable = false;
    sway.enable = true;
  };
  programs.nix-ld.enable = true;

  # only for koch vpn details, disable afterwards

  # services.strongswan.enable = true;
  services.strongswan-swanctl.enable = true;

  services = {
    displayManager.gdm.enable = true;
    desktopManager = {
      gnome.enable = false; # Disable GNOME desktop
    };
    #* i3 stuff
    xserver = {
      windowManager.i3.enable = true;
      xkb = {
        layout = "de";
        variant = "neo_qwertz";
      };
    };
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # power management
  powerManagement.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0 = 100;
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
    };
  };

  # Configure console keymap
  console.keyMap = "de";
  programs.zsh.enable = true;

  home-manager.users.forestgump = import ../../home/home.nix;
  home-manager.backupFileExtension = "backup";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.forestgump = {
    isNormalUser = true;
    description = "44Bars";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    monaspace
  ];

  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    git
    keepassxc
    brightnessctl
    libsForQt5.qt5.qtgraphicaleffects
    libsecret
    # qemu
    # virt-manager
    # libvirt
    # virt-viewer
  ];

  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE  USER      ADDRESS         METHOD
      local   all       all                       trust
      host    all       all       127.0.0.1/32    trust
      host    all       all       ::1/128         trust
    '';
  };

  system.stateVersion = "24.05";
}
