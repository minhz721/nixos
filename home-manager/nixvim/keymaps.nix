{
  programs.nixvim = {
    keymaps = [
      # ============================================================================
      # ─── NORMAL MODE ────────────────────────────────────────────────────────────
      # ============================================================================
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<CR>";
        options.desc = "Save file";
      }
      {
        mode = "n";
        key = "<C-a>";
        action = "ggVG";
        options.desc = "Select all contents";
      }
      {
        mode = "n";
        key = "<C-z>";
        action = "u";
        options.desc = "Undo last change";
      }
      {
        mode = "n";
        key = "<C-S-z>";
        action = "<C-r>";
        options.desc = "Redo last undo";
      }
      {
        mode = "n";
        key = "<Tab>";
        action = ">>_"; 
        options.desc = "Indent current line";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<<_"; 
        options.desc = "Outdent current line";
      }
      {
        mode = "n";
        key = "<A-j>";
        action = ":m .+1<CR>==";
        options.desc = "Move current line down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = ":m .-2<CR>==";
        options.desc = "Move current line up";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>noh<CR>";
        options.desc = "Clear search highlights";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit Neovim";
      }

      # ─── Custom Comment Dividers ────────────────────────────────────────────────
      {
        mode = "n";
        key = "<leader>-";
        action = "o# ============================================================================<CR># ───  ────────────────────────────────────────────────────────────<CR># ============================================================================<Esc>k$h";
        options.desc = "Insert large block comment divider";
      }
      {
        mode = "n";
        key = "<leader>_";
        action = "o# ───  ────────────────────────────────────────────────────────────────<Esc>10hi";
        options.desc = "Insert single line comment divider";
      }

      # ─── File Navigation & Search ────────────────────────────────────────────────
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Toggle file explorer tree";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>FzfLua files<CR>";
        options.desc = "Find files by name";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>FzfLua live_grep<CR>";
        options.desc = "Search text across project";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>FzfLua buffers<CR>";
        options.desc = "List active buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>FzfLua help_tags<CR>";
        options.desc = "Search help documentation";
      }

      # ─── LSP Core Actions ────────────────────────────────────────────────────────
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "Show symbol references";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Show hover information";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Rename symbol smartly";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Trigger code actions";
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        options.desc = "Format active buffer";
      }

      # ─── Terminal Integration ────────────────────────────────────────────────────
      {
        mode = "n";
        key = "<C-`>";
        action = "<cmd>ToggleTerm<CR>";
        options.desc = "Toggle floating terminal";
      }

      # ============================================================================
      # ─── INSERT MODE ────────────────────────────────────────────────────────────
      # ============================================================================
      {
        mode = "i";
        key = "<C-s>";
        action = "<Esc><cmd>w<CR>a";
        options.desc = "Save file and return to text insert";
      }
      {
        mode = "i";
        key = "<C-a>";
        action = "<Esc>ggVG";
        options.desc = "Select all contents from insert mode";
      }
      {
        mode = "i";
        key = "<C-z>";
        action = "<Esc>ua"; 
        options.desc = "Undo last change and resume insert";
      }
      {
        mode = "i";
        key = "<C-S-z>";
        action = "<Esc><C-r>a";
        options.desc = "Redo last undo and resume insert";
      }
      {
        mode = "i";
        key = "<Tab>";
        action = "<C-t>"; 
        options.desc = "Indent current line forward";
      }
      {
        mode = "i";
        key = "<S-Tab>";
        action = "<C-d>"; 
        options.desc = "Outdent current line backward";
      }

      # ============================================================================
      # ─── VISUAL MODE ────────────────────────────────────────────────────────────
      # ============================================================================
      {
        mode = "v";
        key = "<C-s>";
        action = "<cmd>w<CR>";
        options.desc = "Save file from visual mode";
      }
      {
        mode = "v";
        key = "<C-z>";
        action = "u";
        options.desc = "Undo last change";
      }
      {
        mode = "v";
        key = "<C-S-z>";
        action = "<C-r>";
        options.desc = "Redo last undo";
      }
      {
        mode = "v";
        key = "<Tab>";
        action = ">gv"; 
        options.desc = "Indent selected block and keep selection";
      }
      {
        mode = "v";
        key = "<S-Tab>";
        action = "<gv"; 
        options.desc = "Outdent selected block and keep selection";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move selected block down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move selected block up";
      }

      # ============================================================================
      # ─── TERMINAL MODE ──────────────────────────────────────────────────────────
      # ============================================================================
      {
        mode = "t";
        key = "<C-z>";
        action = "<C-\\><C-n>u";
        options.desc = "Undo last change from terminal pane";
      }
      {
        mode = "t";
        key = "<C-S-z>";
        action = "<C-\\><C-n><C-r>";
        options.desc = "Redo last undo from terminal pane";
      }
    ];
  };
}
