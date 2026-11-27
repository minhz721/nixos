{
  pkgs,
  lib,
  ...
}:
let
  extract = pkgs.writeShellApplication {
    name = "nemo-extract";
    runtimeInputs = with pkgs; [
      libarchive
      unrar
      libnotify
      coreutils
    ];
    text = ''
      shopt -s dotglob nullglob

      extract_one() {
        local file="$1" dir base name tmp
        dir="$(dirname "$file")"
        base="$(basename "$file")"

        name="''${base%.*}"
        name="''${name%.tar}"

        tmp="$(mktemp -d -p "$dir" ".extract.XXXXXX")" || return 1

        case "''${base,,}" in
          *.rar)
            unrar x -idq -y "$file" "$tmp/" || { rm -rf "$tmp"; return 1; }
            ;;
          *)
            bsdtar -xf "$file" -C "$tmp" || { rm -rf "$tmp"; return 1; }
            ;;
        esac

        local entries=("$tmp"/*) src dest final n=1
        if [ "''${#entries[@]}" -eq 1 ]; then
          src="''${entries[0]}"
          dest="$dir/$(basename "$src")"
        else
          src="$tmp"
          dest="$dir/$name"
        fi

        final="$dest"
        while [ -e "$final" ]; do
          final="$dest ($n)"
          n=$((n + 1))
        done

        mv "$src" "$final" || { rm -rf "$tmp"; return 1; }
        rm -rf "$tmp"
        notify-send -t 3000 "Extracted" "$(basename "$final")"
      }

      for f in "$@"; do
        if ! extract_one "$f"; then
          notify-send -u critical "Extraction failed" "$(basename "$f")"
        fi
      done
    '';
  };

  archiveMimes = [
    "application/zip"
    "application/vnd.rar"
    "application/x-rar"
    "application/x-7z-compressed"
    "application/x-tar"
    "application/x-compressed-tar"
    "application/x-bzip-compressed-tar"
    "application/x-xz-compressed-tar"
    "application/x-zstd-compressed-tar"
  ];

  assoc = app: types: lib.genAttrs types (_: [ app ]);
in
{
  home.packages = with pkgs; [
    # File Manager & Extraction
    nemo
    extract
    libnotify # notify-send (wallpaper script, fish "done" plugin)

    # Archive & System Utilities
    czkawka

    # Multimedia
    imv
    mpv
    ffmpeg
    cava

    # Disk / Filesystem GUI
    gnome-disk-utility

    # Desktop Applications
    zathura
    mission-center
    localsend

    # Communication & API
    telegram-desktop
    bruno
  ];

  xdg.dataFile."nemo/actions/ghostty.nemo_action".text = ''
    [Nemo Action]
    Active=true
    Name=Open in Ghostty
    Comment=Open Ghostty terminal in the current directory
    Exec=ghostty --working-directory=%P
    Icon-Name=com.mitchellh.ghostty
    Selection=none
    Extensions=dir;
    Quote=double
  '';
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
    "org/gnome/desktop/privacy".remember-recent-files = false;
  };

  xdg.desktopEntries.nemo-extract = {
    name = "Extract Archive";
    exec = "${extract}/bin/nemo-extract %F";
    mimeType = archiveMimes;
    terminal = false;
    noDisplay = true;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nemo.desktop" ];
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
    ]
    // assoc "nemo-extract.desktop" archiveMimes;
  };
}
