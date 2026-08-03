{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
        };

        appearance = {
          nerd_font_variant = "mono";
        };

        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };

          menu = {
            border = "rounded";
          };
        };

        snippets = {
          preset = "luasnip";
        };

        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };

        signature = {
          enabled = true;
        };
      };
    };

    plugins.luasnip.enable = true;
  };
}