{ ... }:

{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Browser
      "text/html" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/http" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/https" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/about" = [ "thorium-browser.desktop" ];
      "x-scheme-handler/unknown" = [ "thorium-browser.desktop" ];

      # Insomnia
      "x-scheme-handler/insomnia" = [ "insomnia.desktop" ];

      # File manager
      "inode/directory" = [ "nemo.desktop" ];

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

      # Telegram
      "x-scheme-handler/tonsite" = [
        "org.telegram.desktop.desktop"
      ];
    };
  };
}