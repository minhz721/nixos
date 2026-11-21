{
  config,
  lib,
  pkgs,
  ...
}: let
  fuzzel = config.programs.fuzzel.package;

  mkScript = name: runtimeInputs: file:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = builtins.readFile file;
    };

  powermenu = mkScript "fuzzel-powermenu" [fuzzel pkgs.hyprlock] ./scripts/powermenu.sh;
  wallpaper =
    mkScript "fuzzel-wallpaper"
    (with pkgs; [fuzzel swaybg libnotify findutils procps util-linux coreutils])
    ./scripts/wallpaper-select.sh;
in {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Maple Mono:size=13";
        dpi-aware = "yes";
        icon-theme = "Papirus-Dark";
        terminal = "alacritty -e";
        lines = 10;
        width = 35;
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 10;
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "f38ba8ff";
        border = "b4befeff";
      };
      border = {
        width = 2;
        radius = 12;
      };
    };
  };

  home.packages = [
    powermenu
    wallpaper
    pkgs.papirus-icon-theme
  ];

  xdg.configFile = {
    "fuzzel/scripts/powermenu.sh".source = lib.getExe powermenu;
    "fuzzel/scripts/wallpaper-select.sh".source = lib.getExe wallpaper;
  };
}
