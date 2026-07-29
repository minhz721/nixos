{ config, pkgs, ...}:

{
    imports = [
        ./audio.nix
        ./bootloader.nix
        ./locales.nix
        ./network.nix
        ./packages.nix
        ./sddm.nix
        ./service.nix
        ./user.nix
        ./fonts.nix
        ./niri.nix
        ./bluetooth.nix
    ];
}