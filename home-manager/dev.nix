{
  pkgs,
  pkgsUnstable,
  ...
}:
let
  rustToolchain = with pkgsUnstable; [
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer
  ];
in
{
  _module.args.rustToolchain = rustToolchain;

  home.packages =
    rustToolchain
    ++ [
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
      fzf

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
