{ config, pkgs, ... }:

{
  programs.nixvim = {
    # https://github.io
    plugins.snacks = {
      enable = true;
      
      settings = {
        # 1. High-performance smooth scrolling module
        scroll = {
          enabled = true;
          animate = {
            duration = { step = 15; total = 150; };
            easing = "linear";
          };
          animate_repeat = {
            delay = 50;
            duration = { step = 5; total = 50; };
            easing = "linear";
          };
        };

        # 2. === ACTIVATED LAZYGIT MODULE ===
        lazygit = {
          enabled = true;
          # Configures the underlying float window geometry aesthetics
          configure = true;
        };

        # 3. Performance booster modules
        bigfile.enabled = true;      # Optimizes Neovim when opening massive files
        quickfile.enabled = true;    # Maximizes initial startup time velocities
      };
    };

    # Custom keymaps utilizing the built-in Snacks Lazygit APIs
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";          # Press Space + g + g to toggle Lazygit popup window
        action = ''
          <cmd>lua Snacks.lazygit()<CR>
        '';
        options = {
          silent = true;
          desc = "Toggle Lazygit modern floating UI interface";
        };
      }
      {
        mode = "n";
        key = "<leader>gl";          # Press Space + g + l to view Git commit logs history
        action = ''
          <cmd>lua Snacks.lazygit.log()<CR>
        '';
        options = {
          silent = true;
          desc = "Open Lazygit commit logs historical timelines";
        };
      }
    ];
  };
}
