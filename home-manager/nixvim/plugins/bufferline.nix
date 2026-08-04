{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          diagnostics = "nvim_lsp";
          # separator_style = "slant";
          show_buffer_close_icons = true;
          show_close_icon = false;
          always_show_bufferline = true;
        };
      };
    };
  };
}