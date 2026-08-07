{pkgs, ...}: {
  home.packages = with pkgs; [
    # Tools
    git
    ripgrep
    fd
    curl
    wget

    # JavaScript / TypeScript
    nodejs
    typescript
    typescript-language-server
    prettier

    # Web LSP
    vscode-langservers-extracted

    # Python
    python3
    pyright
    ruff
    black
    isort

    # Shell
    bash-language-server
    shellcheck
    shfmt

    # Docker
    dockerfile-language-server
    hadolint

    # Nix
    nil
    alejandra
    statix
    deadnix

    # Lua
    lua-language-server
    stylua

    # Build tools
    gcc
    gnumake

    # SQL
    sqlfluff

    # tree-sitter
    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
