{
  programs.nixvim = {
    plugins.trouble = {
      enable = true;
      settings = {
        auto_close = false;
        auto_preview = true;
        focus = false;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
        options.desc = "Buffer diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=false<CR>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>Trouble loclist toggle<CR>";
        options.desc = "Location list (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xq";
        action = "<cmd>Trouble qflist toggle<CR>";
        options.desc = "Quickfix list (Trouble)";
      }
    ];
  };
}
