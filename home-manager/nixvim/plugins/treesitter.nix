{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          # Core
          lua
          vim
          nix

          # zig
          zig

          # Web
          javascript
          typescript
          tsx
          html
          css
          json
          svelte

          # Config / DevOps
          bash
          dockerfile
          yaml
          toml

          # Data / Docs
          markdown
          markdown_inline

          # Python
          python

          # Rust
          rust

          # Zig
          zig

          # Sql
          sql
        ];
      };
      # Rainbow brackets / parentheses
      rainbow-delimiters = {
        enable = true;
      };
      # Better Markdown rendering
      render-markdown = {
        enable = true;

        settings = {
          heading = {
            sign = true;
            icons = [
              "1 "
              "2 "
              "3 "
              "4 "
              "5 "
              "6 "
            ];
          };
          checkbox = {
            enabled = true;
            unchecked = {
              icon = "󰄱 ";
            };
            checked = {
              icon = "󰱒 ";
            };
          };
        };
      };
    };
  };
}
