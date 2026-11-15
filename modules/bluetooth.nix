{
  boot.kernelModules = ["uhid"];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Privacy = "off";
        JustWorksRepairing = "confirm";
        FastConnectable = false;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;
}
