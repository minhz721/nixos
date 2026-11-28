{ pkgs, pkgsUnstable, ... }:

let
  rustToolchain = pkgs.symlinkJoin {
    name = "rust-toolchain";

    paths = with pkgsUnstable; [
      cargo
      rustc
      clippy
      rustfmt
      rust-analyzer
    ];
  };
in
{
  home.packages = [
    rustToolchain
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
    ripgrep
    curl
    yq

    # Terminal utilities
    bottom

    # Development Applications
    lazydocker
    lazygit
    lazysql

    # Runtimes & Toolchains
    uv
    bun
    nodejs

    # Nix Ecosystem
    nil
    nixfmt

    # Web & Scripting
    vtsls
    biome

    # Python & Shell
    ruff
    ty
    shfmt

    # Build & Config Tools
    gnumake
    taplo
  ]);

  # Biome
  xdg.configFile."biome/biome.json".text = builtins.toJSON {
    formatter = {
      enabled = true;
      indentStyle = "tab";
      indentWidth = 4;
    };

    html.formatter.enabled = true;
    javascript.formatter.semicolons = "always";

    overrides = [
      {
        includes = [
          "**/*.yaml"
          "**/*.yml"
          "**/*.md"
        ];

        formatter = {
          indentStyle = "space";
          indentWidth = 2;
        };
      }
    ];
  };
}
