{ lib, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Start Docker daemon on-demand via socket for faster boot
  systemd.services.docker.wantedBy = lib.mkForce [ ];
}
