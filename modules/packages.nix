{
  pkgs,
  inputs,
  ...
}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    keep-outputs = true;
    keep-derivations = true;
  };
  environment.systemPackages = with pkgs; [
    # NixOS / System Management
    home-manager

    # Disk / Filesystem
    ntfs3g
    exfat
    exfatprogs
  ];
}
