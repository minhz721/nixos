{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./options.nix
    ./globals.nix
    ./keymaps.nix
    ./autocmds.nix
    ./colorscheme.nix
    ./packages.nix
    ./lsp.nix
    ./linter.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    nixpkgs.pkgs = pkgs;
  };
}