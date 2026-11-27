{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Maple Mono NF:size=13";
        dpi-aware = "yes";
        icon-theme = "Papirus-Dark";
        terminal = "ghostty -e";
        lines = 10;
        width = 35;
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 10;
        exit-on-keyboard-focus-loss = false;
        icons-enabled = true;
      };

      # Catppuccin Mocha (accent: blue)
      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        prompt = "bac2deff";
        placeholder = "7f849cff";
        input = "cdd6f4ff";
        match = "89b4faff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "89b4faff";
        counter = "7f849cff";
        border = "89b4faff";
      };

      border = {
        width = 1;
        radius = 10;
      };
    };
  };

  xdg.configFile."fuzzel/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}
