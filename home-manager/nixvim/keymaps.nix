{
  programs.nixvim.keymaps = [
    # File operations
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<C-s>";
      action = "<Esc><cmd>w<CR>";
      options = {
        silent = true;
        desc = "Save file";
      };
    }
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w<CR>";
      options = {
        silent = true;
        desc = "Write file";
      };
    }

    # Select all
    {
      mode = "n";
      key = "<C-a>";
      action = "ggVG";
      options.desc = "Select all";
    }
    {
      mode = "i";
      key = "<C-a>";
      action = "<Esc>ggVG";
      options.desc = "Select all";
    }

    # Undo & Redo
    {
      mode = "n";
      key = "<C-z>";
      action = "u";
      options.desc = "Undo";
    }
    {
      mode = "i";
      key = "<C-z>";
      action = "<C-o>u";
      options.desc = "Undo";
    }
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-S-z>";
      action = "<Esc><C-r>";
      options.desc = "Redo";
    }
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-S-r>";
      action = "<Esc><C-r>";
      options.desc = "Redo";
    }

    # Copy / Cut line / Paste
    {
      mode = "v";
      key = "<C-c>";
      action = "\"+y";
      options.desc = "Copy selection";
    }
    {
      mode = "v";
      key = "<C-x>";
      action = "\"+d";
      options.desc = "Cut selection";
    }
    {
      mode = "n";
      key = "<C-x>";
      action = "\"+dd";
      options.desc = "Cut current line";
    }
    {
      mode = "i";
      key = "<C-x>";
      action = "<Esc>\"+ddi";
      options.desc = "Cut current line";
    }
    {
      mode = "v";
      key = "<C-S-v>";
      action = "\"+p";
      options.desc = "Paste clipboard";
    }

    # Duplicate line up/down
    {
      mode = "n";
      key = "<C-A-down>";
      action = "yyp";
      options.desc = "Duplicate line down";
    }
    {
      mode = "n";
      key = "<C-A-up>";
      action = "yyP";
      options.desc = "Duplicate line up";
    }
    {
      mode = "i";
      key = "<C-A-down>";
      action = "<Esc>yypi";
      options.desc = "Duplicate line down";
    }
    {
      mode = "i";
      key = "<C-A-up>";
      action = "<Esc>yyPi";
      options.desc = "Duplicate line up";
    }
    {
      mode = "v";
      key = "<C-A-down>";
      action = "y'>p";
      options.desc = "Duplicate selection down";
    }
    {
      mode = "v";
      key = "<C-A-up>";
      action = "y'<P";
      options.desc = "Duplicate selection up";
    }

    # Move lines & indentation
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>m .+1<CR>==";
      options.desc = "Move line down";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>m .-2<CR>==";
      options.desc = "Move line up";
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move selection down";
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move selection up";
    }
    {
      mode = "v";
      key = "<Tab>";
      action = ">gv";
      options.desc = "Indent selection";
    }
    {
      mode = "v";
      key = "<S-Tab>";
      action = "<gv";
      options.desc = "Outdent selection";
    }

    # Buffer & Window navigation
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "Previous buffer";
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>bdelete<CR>";
      options.desc = "Close buffer";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Go to left window";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Go to lower window";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Go to upper window";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Go to right window";
    }

    # Leader shortcuts
    {
      mode = "n";
      key = "<leader>/";
      action = "gcc";
      options = {
        remap = true;
        desc = "Toggle comment";
      };
    }
    {
      mode = "v";
      key = "<leader>/";
      action = "gc";
      options = {
        remap = true;
        desc = "Toggle comment";
      };
    }
    {
      mode = "n";
      key = "<leader>ch";
      action = "<cmd>nohlsearch<CR>";
      options.desc = "Clear search highlight";
    }
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>q<CR>";
      options.desc = "Quit Neovim";
    }
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }
  ];
}
