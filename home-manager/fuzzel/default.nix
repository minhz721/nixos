{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        include = "${config.home.homeDirectory}/.cache/current-theme/fuzzel.ini";
        font = "Maple Mono NF:size=13";
        dpi-aware = "yes";
        icon-theme = "Papirus-Dark";
        terminal = "alacritty -e";
        lines = 10;
        width = 35;
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 10;
        exit-on-keyboard-focus-loss = false;
        icons-enabled = true;
      };
      border = {
        width = 2;
        radius = 12;
      };
    };
  };

  xdg.configFile."fuzzel/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

}
