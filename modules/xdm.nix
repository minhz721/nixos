{
  pkgs,
  inputs,
  ...
}: let
  xdm = pkgs.callPackage "${inputs.nix-xdm}/derivation.nix" {};
in {
  environment.systemPackages = [
    xdm
  ];
}