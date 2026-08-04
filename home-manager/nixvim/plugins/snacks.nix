{ config, pkgs, ... }:

{
  programs.nixvim = {
    # https://github.io
    plugins.snacks = {
      enable = true;
      
      settings = {
        # 1. === ACTIVATED SNACKS INDENT MODULE ===
        # Draws high-performance vertical scoping guides for nested code blocks
        indent = {
          enabled = true;
          char = "│";                # Standard clean thin vertical line character
          blank = " ";               # Keeps blank space rendering clean without garbage symbols
          only_scope = false;        # Set to true if you ONLY want to highlight the active code block
          only_current = false;      # Set to true if you only want lines on the current cursor position
          
          # Smooth dynamic fading animation configuration for scoping switches
          animate = {
            enabled = true;
            style = "out";
            duration = { step = 20; total = 200; };
          };
        };

        # 2. High-performance smooth scrolling module
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

        # 3. Activated Lazygit modern interface module
        lazygit = {
          enabled = true;
          configure = true;
        };

        # 4. Performance booster modules
        bigfile.enabled = true;      # Optimizes Neovim when opening massive files
        quickfile.enabled = true;    # Maximizes initial startup time velocities
      };
    };

    # Custom keymaps utilizing the built-in Snacks Lazygit APIs
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";          # Press Space + g + g to toggle Lazygit popup window
        action = "<cmd>lua Snacks.lazygit()<CR>";
        options = {
          silent = true;
          desc = "Toggle Lazygit modern floating UI interface";
        };
      }
      {
        mode = "n";
        key = "<leader>gl";          # Press Space + g + l to view Git commit logs history
        action = "<cmd>lua Snacks.lazygit.log()<CR>";
        options = {
          silent = true;
          desc = "Open Lazygit commit logs historical timelines";
        };
      }
    ];
  };
}
