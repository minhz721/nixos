{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        explorer = {
          enabled = true;
          replace_netrw = false;
        };
        input.enabled = true;
        notifier = {
          enabled = true;
          timeout = 3000;
        };
        indent = {
          enabled = true;
          char = "│";
          animate.enabled = false;
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
        bigfile.enabled = true;
        quickfile.enabled = true;
        words.enabled = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = "function() Snacks.explorer() end";
        options.desc = "Toggle file explorer";
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "]]";
        action.__raw = "function() Snacks.words.jump(vim.v.count1) end";
        options.desc = "Next reference";
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "[[";
        action.__raw = "function() Snacks.words.jump(-vim.v.count1) end";
        options.desc = "Prev reference";
      }
    ];
  };
}
