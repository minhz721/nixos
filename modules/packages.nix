{pkgs, ...}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
  environment.systemPackages = with pkgs; [
    # NixOS / System Management
    home-manager

    # Disk / Filesystem
    ntfs3g
    exfat
    exfatprogs
    gnome-disk-utility

    # Core CLI & Archives
    fastfetch
    btop
    ffmpeg

    # System Themes / Icons
    gnome-themes-extra
    adwaita-icon-theme
  ];
}
