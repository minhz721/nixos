{pkgsUnstable, ...}: {
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
    kdlfmt
    taplo
  ];

  # Global Biome fallback config (Tab width 4 for code, 2 spaces for YAML/MD)
  xdg.configFile."biome/biome.json".text = builtins.toJSON {
    "$schema" = "https://biomejs.dev";
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
    overrides = [
      {
        includes = ["*.yml" "*.yaml" "*.md"];
        formatter = {
          indentStyle = "space";
          indentWidth = 2;
        };
      }
    ];
  };
}
