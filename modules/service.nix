{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      curl
    ];
  };

  # Graphics & AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Security & Authentication
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Storage & File Systems
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

  programs.dconf.enable = true;

  # Prevent unintended sleep/shutdown from keyboard knob (Xinmeng M75)
  services.logind.settings = {
    Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "ignore";
    };
  };

  # Polkit Gnome Authentication Agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
