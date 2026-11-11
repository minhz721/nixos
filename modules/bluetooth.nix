{
  boot.kernelModules = ["uhid"];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";

        UserspaceHID = true;
        Privacy = "off";
        JustWorksRepairing = "always";
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;
}
