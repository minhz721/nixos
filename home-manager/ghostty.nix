{pkgsUnstable, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgsUnstable.ghostty;
    settings = {
      background-opacity = 0.8;
      background-blur = 30;
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      window-padding-balance = true;

      theme = "Dark+";
      background = "#121314";

      font-family = "Maple Mono NF";
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

        # Split panes
        "alt+p=new_split:right"
        "alt+n=new_split:down"
        "alt+x=close_surface"

        # Move focus between panes
        "alt+left=goto_split:left"
        "alt+right=goto_split:right"
        "alt+up=goto_split:up"
        "alt+down=goto_split:down"

        # Resize panes
        "alt+shift+left=resize_split:left,20"
        "alt+shift+right=resize_split:right,20"
        "alt+shift+up=resize_split:up,20"
        "alt+shift+down=resize_split:down,20"
      ];
    };
  };
}
