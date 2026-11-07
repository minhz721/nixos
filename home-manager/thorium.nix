{
  pkgs,
  inputs,
  ...
}: let
  currentSystem = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = [
    inputs.thorium.packages.${currentSystem}.thorium-avx2
  ];

  home.file.".config/thorium-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=UseOzonePlatform,VaapiVideoDecodeLinux,VaapiVideoEncoderGlue
    --ignore-gpu-blocklist
    --enable-gpu-rasterization
    --zero-copy-rasterizer
  '';
}
