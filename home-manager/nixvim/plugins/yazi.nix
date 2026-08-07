{
  programs.nixvim = {
    plugins.yazi = {
      enable = true;
      settings = {
        open_for_directories = false;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Yazi<CR>";
        options.desc = "Open Yazi";
      }
    ];
  };
}