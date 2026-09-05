{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "leomin";

  # Enable networking
  networking.networkmanager.enable = true;
  # localsend
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [53317];
    allowedUDPPorts = [53317];
  };
}
