{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "leomin";
 
  # Enable networking
  networking.networkmanager.enable = true;
}
