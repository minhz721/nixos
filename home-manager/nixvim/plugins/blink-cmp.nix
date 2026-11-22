{ ... }: {
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
              auto_show_delay_ms = 50;
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

      luasnip = {
        enable = true;
        fromLua = [ ];
        fromSnipmate = [ ];
      };

      friendly-snippets = {
        enable = true;
      };
    };

    autoCmd = [
      {
        event = [ "InsertEnter" ];
        once = true;
        callback.__raw = ''
          function()
            local ok, loader = pcall(require, "luasnip.loaders.from_vscode")
            if ok then
              loader.lazy_load()
            end
          end
        '';
      }
    ];
  };
}
