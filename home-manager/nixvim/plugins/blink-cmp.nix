{...}: {
  programs.nixvim = {
    plugins = {
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "super-tab";
          };
          appearance = {
            nerd_font_variant = "mono";
          };
          completion = {
            accept = {
              auto_brackets = {
                enabled = true;
              };
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
            };
            menu = {
              border = "rounded";
            };
            ghost_text = {
              enabled = true;
            };
          };
          snippets = {
            preset = "luasnip";
          };
          sources = {
            default = [
              "lsp"
              "snippets"
              "path"
              "buffer"
            ];
          };
          signature = {
            enabled = true;
          };
        };
      };
      luasnip.enable = true;
    };
  };
}
