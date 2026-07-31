{ config, pkgs, ... }:

{
  home.file.".config/ghostty" = {
    source = ./.;
    recursive = true;
  };
}