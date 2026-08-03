{
  programs.nixvim = {
    colorschemes = {
      vscode = {
        enable = true;
      };

      tokyonight = {
        enable = true;
        settings = {
          style = "moon"; # "storm", "night", "day"
          transparent = true;
        };
      };
    };

    colorscheme = "tokyonight";

  };
}
