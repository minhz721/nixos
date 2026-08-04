{ config, pkgs, ... }:

{
  programs.nixvim = {
    # https://github.io
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;       # Smart microsecond rendering code colors
        indent.enable = true;          # Semantic context indent matching upon Return key
      };

      # Exact immutable grammar parsers package array managed cleanly via Nix Store
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        lua
        vim
        nix
        javascript
        typescript
        tsx
        html
        css
        json
        bash
        python
        dockerfile
        markdown
        markdown_inline
        svelte                         # Included svelte syntax highlighting parser
      ];
    };
  };
}
