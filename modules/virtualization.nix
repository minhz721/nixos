{ pkgs, ... }:

{
  # Docker (On-demand socket activation)
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Virt-Manager (QEMU/KVM + SPICE)
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
