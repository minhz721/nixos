{
  programs.nixvim = {
    plugins.yazi = {
      enable = true;
      settings = {
        open_for_directories = false;
        show_hidden = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Yazi<CR>";
        options.desc = "Open Yazi";
      }
      {
      mode = "n";
      key = "<leader>cw";
      action = "<cmd>Yazi cwd<CR>";
      options = {
        desc = "Toggle Yazi file manager at project root workspace";
        silent = true;
      };
      }
    ];
  };
}