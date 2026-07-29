{ config, pkgs, ... }:

{
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."leomin" = {
        isNormalUser = true;
        description = "leomin";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        #  thunderbird
        ];
    };
}