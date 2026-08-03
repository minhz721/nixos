{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      settings = {
        highlight = {
          enable = true;
        };

        indent = {
          enable = true;
        };
      };

      nixvimInjections = true;
    };

    plugins.treesitter.settings.ensure_installed = [
      "javascript"
      "typescript"
      "tsx"
      "html"
      "css"
      "python"
      "bash"
      "dockerfile"
      "nix"
      "lua"
      "json"
      "yaml"
      "toml"
      "markdown"
      "markdown_inline"
      "regex"
      "vim"
      "vimdoc"
    ];
  };
}