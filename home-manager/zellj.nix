{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    settings = {
      # General
      default_shell = "${pkgs.fish}/bin/fish";
      default_layout = "default";
      default_mode = "normal";
      # UI
      pane_frames = true;
      simplified_ui = false;
      show_startup_tips = false;
      mouse_mode = true;
      pane_viewport_serialization = true;
      # Theme
      theme = "catppuccin-mocha";
      # Clipboard
      copy_on_select = true;
      # Scrollback
      scroll_buffer_size = 10000;
      # Session
      session_serialization = true;
      # Built-in UI
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
    };
    extraConfig = ''
    '';
  };

  # Layouts
  home.file = {
    ".config/zellij/layouts/dev.kdl".text = ''
      layout {
        tab name="code" focus=true {
          pane command="hx"
        }
        tab name="git" {
          pane command="lazygit"
        }
        tab name="files" {
          pane command="yazi"
        }
        tab name="system" {
          pane command="btop"
        }
        tab name="terminal" {
          pane command="fish"
        }
      }
    '';
  };
}
