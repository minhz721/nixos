{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    download-buffer-size = 524288000;
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    # Disk / Filesystem    ntfs3g
    exfatprogs

    # Core CLI & Archives
    fastfetch
    btop

    # System Themes / Icons
    gnome-themes-extra
    adwaita-icon-theme
  ];
}
