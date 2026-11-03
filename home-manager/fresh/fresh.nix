{pkgsUnstable, ...}: {
  home.packages = with pkgsUnstable; [
    fresh-editor
  ];

  xdg.configFile."fresh/config.json" = {
    source = ./config.json;
  };
}
