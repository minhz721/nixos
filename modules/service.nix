{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.nix-ld.enable = true;

  # Graphics & AMD GPU
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Security & Authentication
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Polkit Gnome Authentication Agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Storage & File Systems
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

  programs.dconf.enable = true;
}
