{...}: {
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
        bigfile = {
          enabled = true;
        };
      };
    };
  };
}
