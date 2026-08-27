{
  programs.nixvim.keymaps = [
    # Save
    {
      mode = ["n" "i" "v"];
      key = "<C-s>";
      action = "<Esc><cmd>w<CR>";
      options = {
        silent = true;
        desc = "Save file";
      };
    }

    # Select all
    {
      mode = ["n"];
      key = "<C-a>";
      action = "ggVG";
      options.desc = "Select all";
    }
    {
      mode = ["i"];
      key = "<C-a>";
      action = "<Esc>ggVG";
      options.desc = "Select all";
    }

    # Undo
    {
      mode = ["n" "i" "v"];
      key = "<C-z>";
      action = "<Esc>u";
      options.desc = "Undo";
    }

    # Redo
    {
      mode = ["n" "i" "v"];
      key = "<C-S-z>";
      action = "<Esc><C-r>";
      options.desc = "Redo";
    }

    # Clear search
    {
      mode = "n";
      key = "<leader>nh";
      action = "<cmd>nohlsearch<CR>";
      options.desc = "Clear search highlight";
    }

    # Quit
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>q<CR>";
      options.desc = "Quit Neovim";
    }

    # Move line down
    {
      mode = ["n" "v"];
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move line down";
    }

    # Move line up
    {
      mode = ["n" "v"];
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move line up";
    }

    # Copy
    {
      mode = "v";
      key = "<C-c>";
      action = "\"+y";
      options.desc = "Copy selection";
    }

    # Cut
    {
      mode = "v";
      key = "<C-x>";
      action = "\"+d";
      options.desc = "Cut selection";
    }

    # Paste
    {
      mode = "v";
      key = "<C-v>";
      action = "\"+p";
      options.desc = "Paste clipboard";
    }

    # Indent
    {
      mode = "v";
      key = "<Tab>";
      action = ">gv";
      options.desc = "Indent selection";
    }

    # Outdent
    {
      mode = "v";
      key = "<S-Tab>";
      action = "<gv";
      options.desc = "Outdent selection";
    }

    # Comment divider
    {
      mode = "n";
      key = "<leader>-";
      action = "o# ============================================================================<CR># ───  ────────────────────────────────────────────────────────────<CR># ============================================================================";
      options.desc = "Insert comment divider";
    }

    {
      mode = "n";
      key = "<leader>_";
      action = "o# ────────────────────────────────────────────────────────────────────────────";
      options.desc = "Insert small divider";
    }

    # Terminal
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }
  ];
}
