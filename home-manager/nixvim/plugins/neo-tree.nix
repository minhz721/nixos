{
  programs.nixvim = {

    plugins.mini-icons = {
      enable = true;
      mockDevIcons = true;
    };

    plugins.neo-tree = {
      enable = true;

      settings = {
        popup_border_style = "rounded";

        filesystem = {
          filtered_items = {
            hide_dotfiles = false;
            hide_gitignored = false;
          };

          follow_current_file = {
            enabled = true;
          };

          use_libuv_file_watcher = true;
        };
      };
    };


    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Toggle file explorer";
      }

      {
        mode = "n";
        key = "<leader>ef";
        action = "<cmd>Neotree reveal<CR>";
        options.desc = "Reveal current file";
      }

      {
        mode = "n";
        key = "<leader>eg";
        action = "<cmd>Neotree git_status<CR>";
        options.desc = "Open git status";
      }

      {
        mode = "n";
        key = "<leader>eb";
        action = "<cmd>Neotree buffers<CR>";
        options.desc = "Open buffer tree";
      }
    ];

  };
}