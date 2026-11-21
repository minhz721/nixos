{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        explorer.enabled = true;
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
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = ''function() Snacks.explorer() end'';
        options.desc = "Toggle file explorer";
      }
    ];
  };
}
