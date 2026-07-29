{
  pkgs,
  ...
}: {
  programs.fuzzel.enable = true;

  home.file.".config/fuzzel" = {
    source = ./.;
    recursive = true;
  };
}
