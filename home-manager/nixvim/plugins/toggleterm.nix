{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        open_mapping = "[[<C-`>]]";
        float_opts = {
          border = "curved";
        };
      };
    };
  };
}