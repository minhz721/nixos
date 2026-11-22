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
    bacon
    cargo-nextest
    cargo-expand
    cargo-audit
    cargo-deny
    cargo-machete
  ]);
}
