{ config, pkgs, ... }:

{
  home.file.".config/picom" = {
    source = ./.;
    recursive = true;
  };
}