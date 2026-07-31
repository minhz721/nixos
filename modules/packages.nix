{ config, pkgs, inputs, ...}:

{
    services.udisks2.enable = true;

    # Enable dconf for GTK/Nemo settings
    programs.dconf.enable = true;

    # Install firefox.
    programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
        git
        ghostty
        librewolf
        vscode
        #
        gnome-disk-utility
        polkit_gnome
        ntfs3g
        exfatprogs
        dconf-editor
        unzip
        nemo
        nemo-with-extensions
        nemo-fileroller

        # Installs Thorium AVX2 system-wide
        inputs.custom-packages.packages."x86_64-linux".thorium-avx2

        # bluetooth
        bluez
        blueman
    ];
}