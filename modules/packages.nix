{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      curl
    ];
  };

  environment.systemPackages = with pkgs; [
    # Disk / Filesystem
    ntfs3g
    exfat
    exfatprogs

    # Core CLI & Archives
    fastfetch
    btop

    # System Themes / Icons
    gnome-themes-extra
    adwaita-icon-theme
  ];
}
