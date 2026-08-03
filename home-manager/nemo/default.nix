{ config, pkgs, ... }:

{
  home.file.".local/share/nemo/actions/ghostty.nemo_action" = {
    source = ./ghostty.nemo_action;
  };

  home.packages = with pkgs; [
    unzip
    unrar
    p7zip
    jdk # Cần thiết để file .jar có thể tìm thấy binary chạy
  ];

  dconf.settings = {
    "org/nemo/preferences" = {
      default-folder-viewer = "list-view";
      ignore-view-metadata = true; 
      show-hidden-files = true;
    };

    "org/nemo/preferences/menu-config" = {
      background-menu-open-in-terminal = false;
      selection-menu-open-in-terminal = false;
    };

    "org/nemo/search" = {
      search-reverse-sort = false;
      search-sort-column = "name";
    };

    "org/nemo/window-state" = {
      sidebar-bookmark-breakpoint = 5;
      start-with-sidebar = true;
    };
  };

  xdg.desktopEntries = {
    # Java Launcher
    "java-jar-launcher" = {
      name = "Java Runtime Launcher";
      exec = "${pkgs.jdk}/bin/java -jar %f";
      mimeType = [ "application/java-archive" "application/x-java-archive" "application/x-jar" ];
      terminal = false;
      noDisplay = true; 
    };

    # Unzip CLI Wrapper
    "unzip-launcher" = {
      name = "Unzip Extractor";
      exec = "${pkgs.unzip}/bin/unzip %f -d %d";
      mimeType = [ "application/zip" ];
      terminal = true; 
      noDisplay = true;
    };
    
    # Unrar CLI Wrapper
    "unrar-launcher" = {
      name = "Unrar Extractor";
      exec = "${pkgs.unrar}/bin/unrar x %f %d";
      mimeType = [ "application/x-rar" ];
      terminal = true;
      noDisplay = true;
    };

    # 7z CLI Wrapper
    "p7zip-launcher" = {
      name = "7-Zip Extractor";
      exec = "${pkgs.p7zip}/bin/7z x %f -o%d";
      mimeType = [ "application/x-tar" "application/x-bzip2" "application/x-gzip" "application/x-7z-compressed" ];
      terminal = true;
      noDisplay = true;
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # File manager
      "inode/directory" = [ "nemo.desktop" ];

      # Browser
      "text/html" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/http" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/https" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/about" = [ "thorium-browser.desktop" ];

      # Image viewer
      "image/jpeg" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
      "image/bmp" = [ "imv.desktop" ];
      "image/svg+xml" = [ "imv.desktop" ];
      "image/tiff" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];

      # Video
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/avi" = [ "mpv.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];

      # Audio
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];

      # PDF
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];

      "application/zip" = [ "p7zip-launcher.desktop" ];
      "application/x-rar" = [ "unrar-launcher.desktop" ];
      "application/x-tar" = [ "p7zip-launcher.desktop" ];
      "application/x-bzip2" = [ "p7zip-launcher.desktop" ];
      "application/x-gzip" = [ "p7zip-launcher.desktop" ];
      "application/x-7z-compressed" = [ "p7zip-launcher.desktop" ];

      # Java Archives (.jar)
      "application/java-archive" = [ "java-jar-launcher.desktop" ];
      "application/x-java-archive" = [ "java-jar-launcher.desktop" ];
      "application/x-jar" = [ "java-jar-launcher.desktop" ];
    };
  };
}
