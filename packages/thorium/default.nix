{ pkgs }:

let
  pname = "thorium";
  version = "158.0.8127.41";

  url = "https://github.com/gz83/thorium/releases/download/M158.0.8127.41/Thorium_Browser_158.0.8127.41_AVX2.AppImage";

  hash = "sha256-Nw0+VAVpwKPvZ6Popm8/GgYl93WCwu+yWqUYDGYThhU=";

  src = pkgs.fetchurl {
    inherit url hash;
  };

  appimageContents = pkgs.appimageTools.extract {
    inherit pname version src;
  };

in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    # Desktop entry
    desktop_src=$(
      find "${appimageContents}" \
        -maxdepth 4 \
        -name "thorium-browser.desktop" \
        -print -quit
    )

    if [ -z "$desktop_src" ]; then
      echo "thorium-browser.desktop not found in the AppImage" >&2
      exit 1
    fi

    desktop_file="$out/share/applications/thorium-browser.desktop"
    install -Dm444 "$desktop_src" "$desktop_file"

    # Only rewrite the command name, so the [Desktop Action ...] entries keep their
    # arguments (e.g. --incognito), and drop --no-sandbox to keep the sandbox enabled.
    sed -i -E \
      -e 's|^(Exec=)[^ ]*|\1thorium|' \
      -e 's| --no-sandbox||g' \
      "$desktop_file"
    sed -i 's/^Icon=.*/Icon=thorium/' "$desktop_file"

    # PNG icons: keep every hicolor size shipped in the AppImage
    found_icon=""
    while IFS= read -r icon; do
      size=$(basename "$(dirname "$(dirname "$icon")")")
      install -Dm444 "$icon" "$out/share/icons/hicolor/$size/apps/thorium.png"
      found_icon=1
    done < <(find "${appimageContents}" -path "*/icons/hicolor/*/apps/*thorium*.png")

    if [ -z "$found_icon" ]; then
      icon_src=$(find "${appimageContents}" -iname "*thorium*.png" -print -quit)
      if [ -n "$icon_src" ]; then
        install -Dm444 "$icon_src" "$out/share/icons/hicolor/512x512/apps/thorium.png"
      fi
    fi

    # SVG icon
    svg_src=$(
      find "${appimageContents}" \
        -iname "*thorium*.svg" \
        -print -quit
    )

    if [ -n "$svg_src" ]; then
      install -Dm444 \
        "$svg_src" \
        "$out/share/icons/hicolor/scalable/apps/thorium.svg"
    fi
  '';

  meta = with pkgs.lib; {
    description = "Thorium Browser (AVX2)";
    homepage = "https://github.com/gz83/thorium";
    license = licenses.bsd3;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
