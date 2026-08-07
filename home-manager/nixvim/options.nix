{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      cursorline = true;
      termguicolors = true;
      splitbelow = true;
      splitright = true;
      scrolloff = 8;
      clipboard = "unnamedplus";
      undofile = true;
      updatetime = 250;
      completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];
      mouse = "a";
      wrap = false;
      signcolumn = "yes";
      conceallevel = 0;
      pumheight = 15;
      swapfile = false;
    };
  };
}
