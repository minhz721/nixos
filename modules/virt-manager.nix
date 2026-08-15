{pkgs, ...}: {
  # Enable the virt-manager GUI application
  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Allow USB redirection support (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  # Add your regular user to the libvirtd group
  users.users.leomin.extraGroups = ["libvirtd"];

  environment.systemPackages = with pkgs; [ 
    dnsmasq 
    spice-gtk
    spice
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

 
}
