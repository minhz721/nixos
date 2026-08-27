{
  config,
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
    # Authentication / Desktop Integration
    # =========================================================================
    polkit_gnome

    # =========================================================================
    # Disk / Filesystem
    # =========================================================================
    gnome-disk-utility
    ntfs3g
    exfat
    exfatprogs
    udiskie

    # =========================================================================
    # System / Monitoring
    # =========================================================================
    btop
    vim-full
    simplescreenrecorder

    # =========================================================================
    # System Themes / Icons
    # =========================================================================
    gnome-themes-extra
    adwaita-icon-theme

    # =========================================================================
    # External Packages
    # =========================================================================
    inputs.custom-packages.packages."x86_64-linux".thorium-avx2
    inputs.custom-packages.packages."x86_64-linux".stremio
    inputs.custom-packages.packages."x86_64-linux".ab-download-manager
  ];
}
