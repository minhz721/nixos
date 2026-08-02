{ config, pkgs, ... }:

{
    
    # Enable CUPS to print documents.
    # services.printing.enable = true;

    services.udisks2.enable = true;
    services.gvfs.enable = true; 
    services.devmon.enable = true; 

    # Security / authentication
    security.polkit.enable = true;

    # GNOME keyring (password storage)
    services.gnome.gnome-keyring.enable = true;
    
    # Nix store optimization and garbage collection
    nix.settings.auto-optimise-store = true; 

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    }; 

    # fish
    programs.fish.enable = true;
    users.extraUsers.leomin = {
        shell = pkgs.fish;
    };

    # Enable dconf for GTK/Nemo settings
    programs.dconf.enable = true;

    # Install firefox.
    programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    
}