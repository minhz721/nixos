{
  programs.nixvim.plugins = {
    # Auto-close brackets and quotes
    nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        event = "InsertEnter";
      };
    };

    # Auto-close and auto-rename HTML/JSX/TSX tags
    ts-autotag.enable = true;

    # Surround selections with brackets, quotes, or tags
    nvim-surround.enable = true;

    # Smart code commenting
    comment = {
      enable = true;
      settings = {
        mappings = {
          basic = true;
          extra = true;
        };
      };
    };

    # Highlight and search TODO/FIXME comments
    todo-comments = {
      enable = true;
      settings = {
        highlight.multiline = true;
        search.command = "rg";
      };
    };
  };
}
