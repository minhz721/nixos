{...}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # boot.loader = {
  #     efi = {
  #       canTouchEfiVariables = true;
  #     };
  #       grub = {
  #       enable = true;
  #       efiSupport = true;
  #       device = "nodev";
  #       useOSProber = true;
  #     };
  # };
  # boot.kernelParams = [ "acpi_backlight=vendor" ];
}
