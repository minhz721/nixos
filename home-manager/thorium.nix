{
  pkgs,
  inputs,
  ...
}:
let
  currentSystem = pkgs.stdenv.hostPlatform.system;
  thoriumPkg = inputs.thorium.packages.${currentSystem}.thorium-avx2;

  thoriumWrapped = pkgs.symlinkJoin {
    name = "thorium-wrapped";
    paths = [ thoriumPkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      for bin in $out/bin/*; do
        wrapProgram "$bin" \
          --add-flags "--ozone-platform=wayland" \
          --add-flags "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinux,VaapiVideoEncoderGlue" \
          --add-flags "--disable-features=GlobalShortcutsPortal" \
          --add-flags "--ignore-gpu-blocklist" \
          --add-flags "--enable-gpu-rasterization" \
          --add-flags "--zero-copy-rasterizer"
      done
    '';
  };
in
{
  home.packages = [
    thoriumWrapped
  ];
}
