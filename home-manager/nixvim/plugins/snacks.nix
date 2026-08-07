{ ... }:

{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        indent = {
          enabled = true;
          char = "│";

          animate = {
            enabled = false;
          };
        };
        scroll = {
          enabled = true;

          animate = {
            duration = {
              step = 10;
              total = 100;
            };
            easing = "linear";
          };
        };
        lazygit = {
          enabled = true;
        };
        bigfile = {
          enabled = true;
        };
        quickfile = {
          enabled = true;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>lua Snacks.lazygit()<CR>";
        options.desc = "Open Lazygit";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>lua Snacks.lazygit.log()<CR>";
        options.desc = "Git log";
      }
    ];
  };
}