{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      layer = "overlay";

      font = "JetBrainsMono Nerd Font 11";

      margin = "16";
      padding = "16";

      border-size = 2;
      border-radius = 12;

      icons = true;
      max-icon-size = 48;

      default-timeout = 5000;
      ignore-timeout = false;

      background-color = "#1e1e2eff";
      text-color = "#cdd6f4ff";
      border-color = "#cba6f7ff";
      progress-color = "over #89b4faff";
    };

    extraConfig = ''
      [urgency=low]
      background-color=#1e1e2eff
      text-color=#bac2deff
      border-color=#6c7086ff

      [urgency=normal]
      background-color=#1e1e2eff
      text-color=#cdd6f4ff
      border-color=#cba6f7ff

      [urgency=high]
      background-color=#f38ba8ff
      text-color=#1e1e2eff
      border-color=#fab387ff
      default-timeout=0
    '';
  };
}
