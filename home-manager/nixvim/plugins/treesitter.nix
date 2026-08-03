{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.nixvim = {
    # https://nix-community.github.io/nixvim/plugins/treesitter/index.html
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };

      settings.ensure_installed = [
        "bash"
        "html"
        "lua"
        "markdown"
        "nix"
        "python"
        "javascript"
        "typescript"
        "tsx"
        "css"
        "json"
        "yaml"
        "dockerfile"
        "vim"
        "vimdoc"
      ];

    };
  };
}
