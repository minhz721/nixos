{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = {
        preset = "classic";
        delay = 300;
      };
    };
  };
}