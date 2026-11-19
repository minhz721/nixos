{inputs, ...}: {
  imports = [
    inputs.umbriel.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.umbriel.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Noctalia Greeter
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      appearance.scheme = "Catppuccin";
      keyboard.layout = "us";
      output.name = "DP-1";
      session.default = "umbriel";
      user.default = "leomin";
    };
  };
}
