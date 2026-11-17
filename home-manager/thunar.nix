{
  pkgs,
  lib,
  ...
}: let
  extract = pkgs.writeShellApplication {
    name = "thunar-extract";
    runtimeInputs = with pkgs; [
      libarchive
      unrar
      libnotify
      coreutils
      findutils
    ];

    text = ''
      shopt -s dotglob nullglob
      extract_one() {
        local file="$1"
        local dir base name tmp
        local src dest final n=1
        local -a entries
        if [ ! -f "$file" ]; then
          notify-send -u critical "Extraction failed" "Invalid file: $file"
          return 1
        fi

        dir="$(dirname "$file")"
        base="$(basename "$file")"
        name="''${base%.*}"
        name="''${name%.tar}"

        tmp="$(mktemp -d -p "$dir" ".extract.XXXXXX")" || return 1
        case "''${base,,}" in
          *.rar)
            unrar x -idq -y "$file" "$tmp/" || {
              rm -rf "$tmp"
              return 1
            }
            ;;
          *)
            bsdtar -xf "$file" -C "$tmp" || {
              rm -rf "$tmp"
              return 1
            }
            ;;
        esac

        entries=("$tmp"/*)

        if [ "''${#entries[@]}" -eq 0 ]; then
          rm -rf "$tmp"
          notify-send "Extracted" "$base (empty archive)"
          return 0
        fi

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

        mv "$src" "$final" || {
          rm -rf "$tmp"
          return 1
        }

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
    "application/x-rar-compressed"
    "application/x-7z-compressed"
    "application/x-tar"
    "application/x-compressed-tar"
    "application/x-bzip-compressed-tar"
    "application/x-xz-compressed-tar"
    "application/x-zstd-compressed-tar"
    "application/gzip"
    "application/x-gzip"
    "application/x-bzip2"
    "application/x-xz"
    "application/zstd"
  ];

  assoc = app: types: lib.genAttrs types (_: [app]);
in {
  # --------------------------------------------------
  # Packages
  # --------------------------------------------------

  home.packages = with pkgs; [
    thunar
    thunar-volman
    thunar-archive-plugin

    tumbler
    gvfs
    file-roller
    xarchiver

    extract
  ];

  # --------------------------------------------------
  # Thunar custom actions
  # --------------------------------------------------

  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>Alacritty</icon>
        <name>Open in Alacritty</name>
        <unique-id>176339000000001</unique-id>
        <command>alacritty --working-directory="%f"</command>
        <description>Open Alacritty in this directory</description>
        <patterns>*</patterns>
        <directories/>
      </action>
    </actions>
  '';

  # --------------------------------------------------
  # Thunar preferences (xfconf)
  # --------------------------------------------------

  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="thunar" version="1.0">
      <property name="last-view" type="string" value="ThunarDetailsView"/>
      <property name="last-show-hidden" type="bool" value="true"/>
      <property name="last-side-pane" type="string" value="ThunarShortcutsPane"/>
      <property name="last-side-pane-width" type="int" value="180"/>
      <property name="last-statusbar-visible" type="bool" value="true"/>
      <property name="last-menubar-visible" type="bool" value="true"/>
    </channel>
  '';

  # --------------------------------------------------
  # Archive extraction desktop entry
  # --------------------------------------------------

  xdg.desktopEntries.thunar-extract = {
    name = "Extract Archive";
    comment = "Extract archive here";
    exec = "${extract}/bin/thunar-extract %F";
    icon = "archive";
    mimeType = archiveMimes;
    terminal = false;
    noDisplay = true;
  };

  # --------------------------------------------------
  # User directories
  # --------------------------------------------------

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # --------------------------------------------------
  # Disable recent files
  # --------------------------------------------------

  dconf.settings = {
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };
  };

  # --------------------------------------------------
  # Default applications
  # --------------------------------------------------

  xdg.mimeApps = {
    enable = true;

    defaultApplications =
      {
        "inode/directory" = ["thunar.desktop"];
        "application/pdf" = ["org.pwmt.zathura.desktop"];
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
      // assoc "thunar-extract.desktop" archiveMimes;
  };
}
