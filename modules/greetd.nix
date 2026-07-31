{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Enable Niri compositor
  programs.niri.enable = true;


  # Noctalia Greeter
  programs.noctalia-greeter = {
    enable = true;

    settings = {
      appearance = {
        scheme = "Catppuccin";
      };

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };

      keyboard = {
        layout = "us";
      };
    };
  };


  # Greetd login manager
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = ''
          ${inputs.noctalia-greeter.packages.${pkgs.system}.default}/bin/noctalia-greeter-session -- --session niri
        '';

        user = "greeter";
      };
    };
  };


  # Needed for user/session handling
  services.accounts-daemon.enable = true;


  # Cursor package for greeter
  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];
}