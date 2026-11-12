{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/share/alacritty-theme/dark_plus.toml"
      ];
      colors.primary.background = "#121314";
      window = {
        opacity = 0.8;
        blur = true;
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
      };
      font = {
        size = 11.0;
        # Font Ligatures
        builtin_box_drawing = true;
        normal = {
          family = "Maple Mono";
          style = "Regular";
        };
      };
      selection = {
        save_to_clipboard = true;
      };
      keyboard.bindings = [
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }
      ];
    };
  };
}
