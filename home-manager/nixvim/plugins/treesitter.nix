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
          # Core & Nix
          lua
          vim
          vimdoc
          nix

          # Web
          javascript
          typescript
          tsx
          html
          css
          json

          # Shell & Config
          bash
          yaml
          toml
          kdl

          # Docs & Languages
          markdown
          markdown_inline
          python
          rust
        ];
      };

      # Rainbow brackets
      rainbow-delimiters.enable = true;

      # Enhanced Markdown rendering
      render-markdown = {
        enable = true;
        settings = {
          heading = {
            sign = true;
            icons = ["1 " "2 " "3 " "4 " "5 " "6 "];
          };
          checkbox = {
            enabled = true;
            unchecked.icon = "   ";
            checked.icon = "   ";
          };
        };
      };
    };
  };
}
