{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/default.nix
  ];

  system.stateVersion = "26.05";
}
