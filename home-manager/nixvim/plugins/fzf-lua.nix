{
  programs.nixvim = {

    plugins.fzf-lua = {
      enable = true;

      settings = {
        winopts = {
          height = 0.85;
          width = 0.80;
          border = "rounded";
        };

        previewer = {
          builtin = {
            syntax = true;
          };
        };
      };
    };


    keymaps = [
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
        options.desc = "Search project";
      }

      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>FzfLua buffers<CR>";
        options.desc = "Find buffers";
      }

      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>FzfLua helptags<CR>";
        options.desc = "Search help tags";
      }

      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>FzfLua oldfiles<CR>";
        options.desc = "Recent files";
      }

      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>FzfLua grep_cword<CR>";
        options.desc = "Search current word";
      }

      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>FzfLua commands<CR>";
        options.desc = "Search commands";
      }

      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>FzfLua keymaps<CR>";
        options.desc = "Search keymaps";
      }
    ];
  };
}