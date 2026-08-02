{ config, pkgs, inputs, ...}:

{
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

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
        # =========================================================================
        # System Core, Utilities & Storage Management
        # =========================================================================
        home-manager
        polkit_gnome
        dconf-editor
        gnome-disk-utility
        ntfs3g
        exfatprogs
        exfat
        unzip
        ffmpeg

        # =========================================================================
        # Hardware & Connectivity (Bluetooth)
        # =========================================================================
        bluez
        blueman

        # =========================================================================
        # Graphic User Interface (GUI) Applications
        # =========================================================================
        ghostty
        librewolf
        flameshot
        nemo
        nemo-with-extensions
        nemo-fileroller
	      vscode
        # Custom external inputs
        inputs.custom-packages.packages."x86_64-linux".thorium-avx2

        # =========================================================================
        # Development Frameworks, Runtimes & Compilers
        # =========================================================================
        git
        python3
        nodejs
        tk
        dotnet-sdk_8
        dotnet-runtime_8

        # =========================================================================
        # Terminal Enhancements, Shells & CLI Utilities
        # =========================================================================
        fish
        starship
        eza
        zoxide
        bat
        fzf
        btop
        vim-full
    ];

}
