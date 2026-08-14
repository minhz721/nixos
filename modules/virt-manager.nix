{pkgs, ...}: {
  # Enable the virt-manager GUI application
  programs.virt-manager.enable = true;

  # Enable and configure KVM/libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = true;
  };

  systemd.services.libvirtd.path = [pkgs.virtiofsd];

  # Allow USB redirection support (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  # Add your regular user to the libvirtd group
  users.users.leomin.extraGroups = ["libvirtd"];
}
