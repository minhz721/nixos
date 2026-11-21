{inputs, ...}: {
  imports = [
    inputs.umbriel.nixosModules.default
  ];

  programs.umbriel.enable = true;

  # Laptop
  # services.upower.enable = true;
  # services.power-profiles-daemon.enable = true;
}
