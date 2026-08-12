{
  config,
  pkgs,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./modules/default.nix
  ];

  system.stateVersion = "26.05";
}
