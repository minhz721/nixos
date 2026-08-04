{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    ripgrep
    fd
    curl
    wget

    nodejs
    typescript
    typescript-language-server
    prettier

    vscode-langservers-extracted

    python3
    pyright
    ruff
    black
    isort

    bash-language-server
    shellcheck
    shfmt

    dockerfile-language-server
    hadolint

    nil
    alejandra
    nixfmt
    statix
    deadnix

    lua-language-server
    stylua

    gcc
    gnumake

    nerd-fonts.jetbrains-mono
    tree-sitter
  ];
}