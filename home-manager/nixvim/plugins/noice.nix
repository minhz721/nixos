{
  programs.nixvim = {
    plugins.nui.enable = true;

    plugins.noice = {
      enable = true;
      settings = {
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };
        };
        presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = false;
          lsp_doc_border = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>nd";
        action = "<cmd>Noice dismiss<CR>";
        options.desc = "Dismiss Noice messages";
      }
      {
        mode = "n";
        key = "<leader>nl";
        action = "<cmd>Noice last<CR>";
        options.desc = "Last Noice message";
      }
      {
        mode = "n";
        key = "<leader>nh";
        action = "<cmd>Noice history<CR>";
        options.desc = "Noice history";
      }
    ];
  };
}
