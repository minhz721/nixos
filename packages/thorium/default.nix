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

    if [ -n "$desktop_src" ]; then
      install -Dm444 \
        "$desktop_src" \
        "$out/share/applications/thorium-browser.desktop"

      desktop_file="$out/share/applications/thorium-browser.desktop"

      sed -i -E \
        's|^Exec=.*|Exec=thorium %U|' \
        "$desktop_file"

      sed -i \
        's/^Icon=.*/Icon=thorium/' \
        "$desktop_file"
    fi

    # PNG icon
    icon_src=$(
      find "${appimageContents}" \
        -iname "*thorium*.png" \
        -print -quit
    )

    if [ -n "$icon_src" ]; then
      install -Dm444 \
        "$icon_src" \
        "$out/share/icons/hicolor/512x512/apps/thorium.png"
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
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
