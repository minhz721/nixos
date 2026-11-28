{
  pkgs,
  lib,
  ...
}:
let
  assoc = app: types: lib.genAttrs types (_: [ app ]);
in
{
  home.packages = with pkgs; [
    # System & Notification
    czkawka
    gnome-disk-utility
    mission-center

    # Multimedia
    imv
    mpv
    ffmpeg
    cava

    # Desktop & Communication
    zathura
    localsend
    telegram-desktop
  ];

  dconf.settings."org/gnome/desktop/privacy".remember-recent-files = false;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    }
    // assoc "thorium.desktop" [
      "text/html"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
    ]
    // assoc "imv.desktop" [
      "image/jpeg"
      "image/webp"
      "image/bmp"
      "image/svg+xml"
      "image/tiff"
      "image/gif"
      "image/png"
      "image/avif"
    ]
    // assoc "mpv.desktop" [
      "video/x-matroska"
      "video/webm"
      "video/avi"
      "video/x-msvideo"
      "video/mp4"
      "video/quicktime"
      "video/mpeg"
      "audio/mpeg"
      "audio/wav"
      "audio/x-wav"
      "audio/flac"
      "audio/x-flac"
      "audio/ogg"
      "audio/opus"
      "audio/mp4"
      "audio/aac"
    ];
  };
}
