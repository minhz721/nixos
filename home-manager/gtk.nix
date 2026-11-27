{
  config,
  pkgs,
  ...
}:
let
  themeName = "adw-gtk3-dark";
  iconThemeName = "Adwaita";
  font = {
    name = "Maple Mono NF";
    size = 12;
  };
  cursor = {
    name = "Adwaita";
    size = 16;
    package = pkgs.adwaita-icon-theme;
  };
  dirs = config.xdg.userDirs;
  recentOff = {
    gtk-recent-files-max-age = 0;
    gtk-recent-files-limit = 0;
  };
in
{
  home.pointerCursor = {
    inherit (cursor) name package size;
    gtk.enable = true;
    x11.enable = true;
  };
  gtk = {
    enable = true;
    theme = {
      name = themeName;
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = iconThemeName;
      package = pkgs.adwaita-icon-theme;
    };
    inherit font;

    gtk3 = {
      extraConfig = recentOff;
      bookmarks = [
        "file://${dirs.download} Downloads"
        "file://${dirs.documents} Documents"
        "file://${dirs.videos} Videos"
        "file://${dirs.music} Music"
        "file://${dirs.pictures} Pictures"
      ];
    };
    gtk4.extraConfig = recentOff;
  };
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    cursor-theme = cursor.name;
    cursor-size = cursor.size;
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = themeName;
      "Net/IconThemeName" = iconThemeName;
      "Gtk/FontName" = "${font.name} ${toString font.size}";
      "Gtk/CursorThemeName" = cursor.name;
      "Gtk/CursorThemeSize" = cursor.size;
      "Gtk/DecorationLayout" = "menu:";
      "Gtk/PrimaryButtonWarpsSlider" = 0;
      "Gtk/ToolbarStyle" = 3;
    };
  };
}
