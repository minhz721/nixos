{inputs, ...}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Noctalia Greeter
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      appearance.scheme = "Catppuccin";
      keyboard.layout = "us";
      output.name = "DP-1";
      user.default = "leomin";
    };
  };
}
