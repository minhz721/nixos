{ pkgs, ... }:
let
  thoriumPkg = pkgs.callPackage ../packages/thorium { };
  thoriumWrapped = pkgs.symlinkJoin {
    name = "thorium-wrapped";
    paths = [ thoriumPkg ];
    nativeBuildInputs = [
      pkgs.makeWrapper
    ];
    postBuild = ''
      rm -f "$out/bin/thorium"
      makeWrapper \
        "${thoriumPkg}/bin/thorium" \
        "$out/bin/thorium" \
        --add-flags "--ozone-platform=wayland" \
        --add-flags "--enable-wayland-ime"
    '';
  };
in
{
  home.packages = [
    thoriumWrapped
  ];
}
