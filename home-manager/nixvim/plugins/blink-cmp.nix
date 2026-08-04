{ config, pkgs, ... }:

{
  programs.nixvim = {
    # https://github.io
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "super-tab";        # Enforce robust VS Code style Super-Tab controls
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
          preset = "luasnip";          # Link seamlessly to Luasnip engine
        };

        sources = {
          default = [ "lsp" "path" "snippets" "buffer" ];
        };

        signature = {
          enabled = true;
        };
      };
    };

    # Snippets manager engine dependencies feeding into blink-cmp
    plugins.luasnip.enable = true;
  };
}
