{ pkgs, lib, ... }:

{
  # Docker (On-demand socket activation)
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  systemd.services.docker.wantedBy = lib.mkForce [ ];

  # Virt-Manager (QEMU/KVM + SPICE)
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
