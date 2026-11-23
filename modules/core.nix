{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };

  # Timezone & Locales
  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # User Account & Default Fish Shell
  programs.fish.enable = true;

  users.users."leomin" = {
    isNormalUser = true;
    description = "leomin";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };

  # Nix Helper (nh) & Automated GC
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${config.users.users.leomin.home}/nixos";
  };
}
