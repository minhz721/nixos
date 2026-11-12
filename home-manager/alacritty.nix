{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/share/alacritty-theme/dark_plus.toml"
      ];
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

      keyboard.bindings = [
        {
          key = "C";
          mods = "Control";
          action = "Copy";
        }
        # SIGINT
        {
          key = "C";
          mods = "Control";
          chars = "\\u0003";
        }
        {
          key = "P";
          mods = "Control";
          action = "Paste";
        }
        # Reload configuration bằng Super + R
        {
          key = "R";
          mods = "Super";
          action = "ReceiveChar";
        }
      ];
    };
  };
}
