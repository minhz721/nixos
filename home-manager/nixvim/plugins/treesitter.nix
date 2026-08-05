{pkgs, ...}: {
  programs.nixvim = {
    plugins.treesitter = {
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

        # API testing
        # http
      ];
    };
  };
}
