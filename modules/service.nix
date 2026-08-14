{
  config,
  pkgs,
  ...
}: {
  programs.java.package = pkgs.jdk21;
  programs.nix-ld.enable = true;

  # Nix store optimization and garbage collection
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # polkit
  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Enable dconf for GTK/Nemo settings
  programs.dconf.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

}
