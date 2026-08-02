{ config, pkgs, ... }:

{
  home.file.".config/dunst" = {
    source = ./.;
    recursive = true;
  };
}