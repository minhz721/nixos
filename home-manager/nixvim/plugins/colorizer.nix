{
  programs.nixvim.plugins.colorizer = {
    enable = true;

    settings = {
      user_default_options = {
        RGB = true;
        RRGGBB = true;
        RRGGBBAA = true;
        names = true;
        mode = "background";
        tailwind = true;
      };
    };
  };
}
