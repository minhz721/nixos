{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Enable core components
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.hyprlock.enable = true;
  services.accounts-daemon.enable = true;

  # Noctalia Greeter settings
  programs.noctalia-greeter = {
    enable = true;
    settings = {
      appearance.scheme = "Catppuccin";
      keyboard.layout = "us";
    };
  };

  # Greetd login manager setup
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${inputs.noctalia-greeter.packages.${pkgs.system}.default}/bin/noctalia-greeter-session -- --session sway";
        user = "leomin";
      };
    };
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];

  # Hardware optimization for AMD iGPU
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
}
