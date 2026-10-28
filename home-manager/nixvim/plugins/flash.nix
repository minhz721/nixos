{...}: {
  programs.nixvim = {
    # High-performance motion engine for ultra-fast screen navigation
    plugins.flash = {
      enable = true;
      
      settings = {
        # Visual configurations for jump labels
        labels = "asdfghjklqwertyuiopzxcvbnm";
        search = {
          # Automatically trigger flash when typing search patterns
          multi_window = true;
          forward = true;
          wrap = true;
        };
      };
    };

    # Precision keyboard mappings for immediate motion execution
    keymaps = [
      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action.__raw = ''function() require("flash").jump() end'';
        options = {
          desc = "Flash jump navigation";
          silent = true;
        };
      }
      {
        mode = [ "n" "x" "o" ];
        key = "S";
        action.__raw = ''function() require("flash").treesitter() end'';
        options = {
          desc = "Flash Treesitter scope selection";
          silent = true;
        };
      }
    ];
  };
}
