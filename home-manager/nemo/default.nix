{ config, pkgs, ... }:

let
  # 1. Background execution wrapper for unzip with automatic directory extraction
  myUnzip = pkgs.writeShellScriptBin "nemo-unzip" ''
    FILE="$1"
    DIR=$(dirname "$FILE")
    ${pkgs.unzip}/bin/unzip "$FILE" -d "$DIR"
  '';

  # 2. Background execution wrapper for unrar
  myUnrar = pkgs.writeShellScriptBin "nemo-unrar" ''
    FILE="$1"
    DIR=$(dirname "$FILE")
    cd "$DIR" && ${pkgs.unrar}/bin/unrar x "$FILE"
  '';

  # 3. Background execution wrapper for 7z handling remaining compression formats
  myP7zip = pkgs.writeShellScriptBin "nemo-p7zip" ''
    FILE="$1"
    DIR=$(dirname "$FILE")
    ${pkgs.p7zip}/bin/7z x "$FILE" -o"$DIR"
  '';
in
{
  # Link custom Nemo Action for right-click "Open in Ghostty" integration
  home.file.".local/share/nemo/actions/ghostty.nemo_action" = {
    source = ./ghostty.nemo_action;
  };

  # Register core CLI tools and customized wrapper scripts to user environment
  home.packages = with pkgs; [
    unzip
    unrar
    p7zip
    openjdk
    myUnzip
    myUnrar
    myP7zip
  ];

  # Configure Nemo file manager appearance and behavior profiles via dconf
  dconf.settings = {
    "org/nemo/preferences" = {
      default-folder-viewer = "list-view"; # Enforce global default layout to List View
      ignore-view-metadata = true;         # Override and ignore directory-specific layout history
      show-hidden-files = true;            # Persistent visibility for hidden files
    };

    "org/nemo/preferences/menu-config" = {
      # Hide default Cinnamon terminal menus to prioritize Ghostty Nemo Action
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

  # Define XDG compliant desktop entry launchers for file executions
  xdg.desktopEntries = {
    # Java Runtime Launcher
    "java-jar-launcher" = {
      name = "Java Runtime Launcher";
      exec = "${pkgs.jdk}/bin/java -jar %f";
      mimeType = [ "application/java-archive" "application/x-java-archive" "application/x-jar" ];
      terminal = false;
      noDisplay = true; 
    };

    # Unzip Wrapper
    "unzip-launcher" = {
      name = "Unzip Extractor";
      exec = "${myUnzip}/bin/nemo-unzip %f";
      mimeType = [ "application/zip" ];
      terminal = false; 
      noDisplay = true;
    };
    
    # Unrar Wrapper
    "unrar-launcher" = {
      name = "Unrar Extractor";
      exec = "${myUnrar}/bin/nemo-unrar %f";
      mimeType = [ "application/x-rar" ];
      terminal = false;
      noDisplay = true;
    };

    # 7z Wrapper
    "p7zip-launcher" = {
      name = "7-Zip Extractor";
      exec = "${myP7zip}/bin/nemo-p7zip %f";
      mimeType = [ "application/x-tar" "application/x-bzip2" "application/x-gzip" "application/x-7z-compressed" ];
      terminal = false;
      noDisplay = true;
    };
  };

  # Global system-wide User MIME applications associations routing
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Default File Manager
      "inode/directory" = [ "nemo.desktop" ];

      # Web Browser (Thorium Browser)
      "text/html" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/http" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/https" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/about" = [ "thorium-browser.desktop" ];

      # Image Viewer (IMV)
      "image/jpeg" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
      "image/bmp" = [ "imv.desktop" ];
      "image/svg+xml" = [ "imv.desktop" ];
      "image/tiff" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];

      # Video Media Player (MPV)
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/avi" = [ "mpv.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];

      # Audio Media Player (MPV)
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];

      # Document Reader (Zathura PDF)
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];

      # Routing archive extensions to background CLI script launchers
      "application/zip" = [ "unzip-launcher.desktop" ];
      "application/x-rar" = [ "unrar-launcher.desktop" ];
      "application/x-tar" = [ "p7zip-launcher.desktop" ];
      "application/x-bzip2" = [ "p7zip-launcher.desktop" ];
      "application/x-gzip" = [ "p7zip-launcher.desktop" ];
      "application/x-7z-compressed" = [ "p7zip-launcher.desktop" ];

      # Routing Java Archive extensions to Java Runtime Launcher
      "application/java-archive" = [ "java-jar-launcher.desktop" ];
      "application/x-java-archive" = [ "java-jar-launcher.desktop" ];
      "application/x-jar" = [ "java-jar-launcher.desktop" ];
    };
  };
}
