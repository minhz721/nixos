{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        open_mapping = "[[<leader>t]]";
        float_opts = {
          border = "curved";
        };
      };
    };
  };
}
