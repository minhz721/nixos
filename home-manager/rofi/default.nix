{ config, pkgs, ... }:

let
  colorsFile = builtins.readFile ../theme/colors.py;

  getColor = key: 
    let
      match = builtins.match ".*\"${key}\":[[:space:]]*\"([^\"]+)\".*" colorsFile;
    in
      if match == null then "#FFFFFF" else builtins.elemAt match 0;

  myColors = {
    BG       = getColor "BG";
    MANTLE   = getColor "MANTLE";
    SURFACE2 = getColor "SURFACE2";
    TEXT     = getColor "TEXT";
    LAVENDER = getColor "LAVENDER";
    FONT     = "JetBrainsMono Nerd Font";
  };
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    extraConfig = {
      modi = "drun,window,filebrowser";
      show-icons = true;
      icon-theme = "Papirus";
      terminal = "ghostty";
      
      drun-display-format = "{name}";
      window-display-format = "{w} · {c} · {t}";
      
      display-drun = " Applications";
      display-window = " Windows";
      display-filebrowser = " File Browser";
      
      kb-mode-next = "Shift+Right,Control+Tab";
      kb-mode-previous = "Shift+Left";
    };

    /* --- Theme & Layout Stylesheet --- */
    theme = 
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          bg = mkLiteral "${myColors.BG}";
          bg-alt = mkLiteral "${myColors.MANTLE}";
          fg = mkLiteral "${myColors.TEXT}";
          accent = mkLiteral "${myColors.LAVENDER}";
          border = mkLiteral "${myColors.LAVENDER}";
        };

        "window" = {
          width = mkLiteral "600px";
          border = mkLiteral "2px";
          border-radius = mkLiteral "12px";
          border-color = mkLiteral "@border";
          background-color = mkLiteral "@bg";
          padding = mkLiteral "20px";
          font = "${myColors.FONT} 11";
        };

        "mainbox" = {
          background-color = mkLiteral "transparent";
          children = map mkLiteral [ "inputbar" "mode-switcher" "listview" ];
          spacing = mkLiteral "15px";
        };

        "inputbar" = {
          background-color = mkLiteral "@bg-alt";
          border-radius = mkLiteral "8px";
          padding = mkLiteral "10px 15px";
          children = map mkLiteral [ "prompt" "entry" ];
          spacing = mkLiteral "10px";
        };

        "prompt" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@accent";
          font = "${myColors.FONT} Bold 11";
        };

        "entry" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg";
          placeholder = "Type to search...";
          placeholder-color = mkLiteral "${myColors.SURFACE2}";
        };

        "mode-switcher" = {
          background-color = mkLiteral "transparent";
          spacing = mkLiteral "10px";
        };

        "button" = {
          padding = mkLiteral "8px";
          background-color = mkLiteral "@bg-alt";
          text-color = mkLiteral "#6c7086";
          border-radius = mkLiteral "6px";
          horizontal-align = mkLiteral "0.5";
        };

        "button selected" = {
          background-color = mkLiteral "@accent";
          text-color = mkLiteral "@bg";
          font = "${myColors.FONT} Bold 11";
        };

        "listview" = {
          background-color = mkLiteral "transparent";
          columns = mkLiteral "1";
          lines = mkLiteral "8";
          spacing = mkLiteral "5px";
          cycle = mkLiteral "true";
          dynamic = mkLiteral "true";
        };

        "element" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg";
          padding = mkLiteral "8px 12px";
          border-radius = mkLiteral "6px";
          spacing = mkLiteral "12px";
        };

        "element selected.normal" = {
          background-color = mkLiteral "@accent";
          text-color = mkLiteral "@bg";
        };

        "element-icon" = {
          size = mkLiteral "24px";
          background-color = mkLiteral "transparent";
        };

        "element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
        };
      };
  };
}
