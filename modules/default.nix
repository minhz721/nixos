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
    ./virt-manager.nix
    ./docker.nix

    ./xdm.nix

    # ./qtile.nix

    ./i3.nix

    # ./sway.nix
  ];
}
