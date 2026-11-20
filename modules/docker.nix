{
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker.enable = true;
  systemd.services.docker.wantedBy = lib.mkForce [];
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
