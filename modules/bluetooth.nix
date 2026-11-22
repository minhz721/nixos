{
  boot.kernelModules = [ "uhid" ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Privacy = "off";
        JustWorksRepairing = "confirm";
        FastConnectable = false;
        Experimental = true;
        KernelExperimental = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  # services.blueman.enable = true;

}
