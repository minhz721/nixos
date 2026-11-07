{
  pkgs,
  fenix,
  ...
}: {
  home.packages = with pkgs; [
    (fenix.packages.${pkgs.stdenv.hostPlatform.system}.combine [
      fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.cargo
      fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.rustc
      fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.clippy
      fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.rustfmt
      fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.rust-analyzer
    ])
    bacon
    cargo-nextest
    cargo-expand
    cargo-audit
    cargo-deny
    cargo-machete
    gcc
  ];
}
