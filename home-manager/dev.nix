{
  pkgs,
  pkgsUnstable,
  fenix,
  ...
}:
let
  toolchain = fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.withComponents [
    "cargo"
    "rustc"
    "clippy"
    "rustfmt"
    "rust-analyzer"
    "rust-src"
  ];
in
{
  _module.args.rustToolchain = toolchain;

  home.packages = [
    toolchain
    pkgs.gcc
  ]
  ++ (with pkgsUnstable; [
    # Rust tools
    bacon
    cargo-nextest
    cargo-expand
    cargo-audit
    cargo-deny
    cargo-machete

    # CLI tools
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

    # Nix Ecosystem
    nixd
    nixfmt

    # Web & Scripting
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

    # Lua
    lua-language-server
    stylua

    # Build & Config Tools
    gnumake
    taplo
  ]);

  xdg.configFile."biome/biome.json".text = builtins.toJSON {
    "$schema" = "https://biomejs.dev";
    formatter = {
      enabled = true;
      indentStyle = "tab";
      indentWidth = 4;
    };
    javascript.formatter.semicolons = "always";
    overrides = [
      {
        includes = [
          "**/*.yaml"
          "**/*.yml"
        ];
        formatter = {
          indentStyle = "space";
          indentWidth = 2;
        };
      }
    ];
  };
}
