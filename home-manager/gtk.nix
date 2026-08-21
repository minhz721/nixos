{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "adw-gtk3-dark";
      "Gtk/DecorationLayout" = "menu:";
      "Gtk/PrimaryButtonWarpsSlider" = 0;
      "Gtk/ToolbarStyle" = 3;
      "Gtk/MenuImages" = 1;
      "Gtk/ButtonImages" = 1;
      "Gtk/CursorThemeName" = "Adwaita";
      "Gtk/ShellShowsAppMenu" = 0;
      "Net/ColorScheme" = "prefer-dark";
    };
  };
}
