{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./audio.nix
    ./bootloader.nix
    ./locales.nix
    ./network.nix
    ./packages.nix
    ./service.nix
    ./user.nix
    ./fonts.nix
    ./bluetooth.nix
    ./keyd.nix
    ./xdm.nix
    # ./gaming.nix
    # niri
    # ./niri.nix
    # ./greetd.nix

    # qtile
    ./qtile.nix
  ];
}
