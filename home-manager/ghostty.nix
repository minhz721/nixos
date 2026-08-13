{
  config,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;

    settings = {
      background = "1f1f1f";
      foreground = "cccccc";
      cursor-color = "aeafad";
      selection-background = "264f78";

      palette = [
        "0=000000"
        "1=cd3131"
        "2=0dbc79"
        "3=e5e510"
        "4=2472c8"
        "5=bc3fbc"
        "6=11a8cd"
        "7=e5e5e5"
        "8=666666"
        "9=f14c4c"
        "10=23d18b"
        "11=f5f543"
        "12=3b8eea"
        "13=d670d6"
        "14=29b8db"
        "15=ffffff"
      ];

      # background-opacity = 0.8;
      # background-blur-radius = 30;
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;
      cursor-style = "block";
      cursor-style-blink = false;
      cursor-invert-fg-bg = true;
      mouse-hide-while-typing = true;

      # Extras
      shell-integration-features = true;
      copy-on-select = "clipboard";
      focus-follows-mouse = true;
      link-url = true;

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
        "ctrl+n=new_window"
        "ctrl+w=close_tab"
        "ctrl+q=close_window"
        "ctrl+shift+q=close_all_windows"
      ];
    };
  };
}
