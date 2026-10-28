{...}: {
  programs.nixvim = {
    plugins = {
      # Next-generation autocompletion engine optimized for performance
      blink-cmp = {
        enable = true;
        settings = {
          # Keybinding presets configuration
          keymap = {
            preset = "super-tab";
          };

          # Font configuration for icons inside completion menu
          appearance = {
            nerd_font_variant = "mono";
          };

          # Core completion behavior and visual styles
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

          # Snippet expansion engine integration
          snippets = {
            preset = "luasnip";
          };

          # Aggregated sources optimized for local runtime environments (bun / uv / cargo)
          sources = {
            default = [
              "lsp"
              "snippets"
              "path"
              "buffer"
            ];
          };

          # Function signature help configuration
          signature = {
            enabled = true;
          };
        };
      };

      # LuaSnip engine required by blink-cmp preset fallback
      luasnip.enable = true;
    };
  };
}
