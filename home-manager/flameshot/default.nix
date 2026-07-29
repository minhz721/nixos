{ pkgs, ... }:

{
  home.packages = with pkgs; [
    flameshot
  ];

  home.file.".config/flameshot" = {
    source = ./.;
    recursive = true;
  };
}