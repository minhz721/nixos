{ pkgsUnstable, ... }: {
  home.packages = with pkgsUnstable; [
    # CLI tools
    fzf
    fd
    ripgrep
    zoxide
    curl
    jq
    yq
    bat

    # Development Applications & CLI
    lazydocker
    lazygit
    lazysql

    # Runtimes & Toolchains
    uv
    bun
    nodejs

    # Nix Ecosystem (Flake-aware LSP & official RFC formatter)
    nixd
    nixfmt

    # Web & Scripting (Pure Rust Biome v2)
    vtsls
    vscode-langservers-extracted
    emmet-language-server
    biome

    # Python & Shell
    ruff
    ty
    bash-language-server
    shellcheck
    shfmt

    # Build & Config Tools
    gnumake
    taplo
  ];

  xdg.configFile."biome/biome.json".text = builtins.toJSON {
    "$schema" = "https://biomejs.dev/schemas/2.0.0/schema.json";
    formatter = {
      enabled = true;
      indentStyle = "tab";
      indentWidth = 4;
    };
    javascript = {
      formatter = {
        semicolons = "always";
      };
    };
  };
}
