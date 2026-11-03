{
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = 0.7;
      background-blur = true;
      # swayfx
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      window-padding-balance = true;
      # theme = "Dark+";
      # theme = "Catppuccin Mocha";
      font-family = "Maple Mono";
      font-size = 11;
      font-feature = [
        "calt"
        "liga"
      ];
      cursor-style = "block";
      cursor-style-blink = false;
      cursor-invert-fg-bg = true;
      mouse-hide-while-typing = true;
      # Extras
      shell-integration-features = true;
      copy-on-select = "clipboard";
      focus-follows-mouse = true;
      link-url = true;
      # --- vscode dark ---
      background = "#121314";
      foreground = "#bbbebf";
      cursor-color = "#bbbebf";
      cursor-text = "#121314";
      selection-background = "#276782";
      selection-foreground = "#ededed";
      palette = [
        "0=#191a1b"
        "1=#ff7b72"
        "2=#7ee787"
        "3=#ffa657"
        "4=#79c0ff"
        "5=#d2a8ff"
        "6=#a5d6ff"
        "7=#bfbfbf"
        "8=#8c8c8c"
        "9=#ffa198"
        "10=#7ee787"
        "11=#ffa657"
        "12=#79c0ff"
        "13=#d2a8ff"
        "14=#a5d6ff"
        "15=#ededed"
      ];
      # --- end ---

      keybind = [
        "ctrl+1=goto_tab:1"
        "ctrl+2=goto_tab:2"
        "ctrl+3=goto_tab:3"
        "ctrl+4=goto_tab:4"
        "ctrl+5=goto_tab:5"
        "ctrl+6=goto_tab:6"
        "ctrl+7=goto_tab:7"
        "ctrl+8=goto_tab:8"
        "ctrl+9=goto_tab:9"

        # Custom keybindings
        "super+r=reload_config"
        "f10=toggle_fullscreen"
        "ctrl+v=paste_from_clipboard"
        "ctrl+t=new_tab"
        # "ctrl+n=new_window"
        "ctrl+w=close_tab"
        # "ctrl+q=close_window"
        # "ctrl+shift+q=close_all_windows"
      ];
    };
  };
}
