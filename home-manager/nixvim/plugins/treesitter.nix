{ pkgs, ... }:

{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    grammarPackages =
      with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
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
      ];
    settings = {
      highlight = {
        enable = true;
      };
      indent = {
        enable = true;
      };
    };
  };
}