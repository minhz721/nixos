{ config, pkgs, ... }:

{
    users.users."leomin" = {
        isNormalUser = true;
        description = "leomin";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };
}