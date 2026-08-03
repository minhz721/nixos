{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<CR>";
        options.desc = "Save file";
      }

      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit";
      }

      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>noh<CR>";
        options.desc = "Clear search";
      }

      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Explorer";
      }

      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>FzfLua files<CR>";
        options.desc = "Find files";
      }

      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>FzfLua live_grep<CR>";
        options.desc = "Search text";
      }

      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>FzfLua buffers<CR>";
        options.desc = "Buffers";
      }

      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>FzfLua help_tags<CR>";
        options.desc = "Help";
      }

      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Go definition";
      }

      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "References";
      }

      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Hover";
      }

      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Rename";
      }

      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }

      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        options.desc = "Format";
      }

      {
        mode = "n";
        key = "<C-`>";
        action = "<cmd>ToggleTerm<CR>";
        options.desc = "Terminal";
      }

      {
        mode = "n";
        key = "<A-j>";
        action = ":m .+1<CR>==";
        options.desc = "Move line down";
      }

      {
        mode = "n";
        key = "<A-k>";
        action = ":m .-2<CR>==";
        options.desc = "Move line up";
      }

      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move selection down";
      }

      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move selection up";
      }
    ];
  };
}