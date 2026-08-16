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
    ./virt-manager.nix

    ./xdm.nix

    # qtile
    ./qtile.nix

    # ./i3.nix

    # sway
    # ./sway.nix
  ];
}
