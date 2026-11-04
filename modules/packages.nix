{
  pkgs,
  inputs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    # =========================================================================
    # NixOS / System Management
    # =========================================================================
    home-manager

    # =========================================================================
    # Disk / Filesystem
    # =========================================================================
    gnome-disk-utility
    ntfs3g
    exfat
    exfatprogs
    udiskie

    # =========================================================================
    # System Themes / Icons
    # =========================================================================
    gnome-themes-extra
    adwaita-icon-theme

    inputs.mitos.packages.${pkgs.system}.default
  ];
}
