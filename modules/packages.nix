{ config, pkgs, inputs, ...}:

{
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
        thunar
        # nautilus
        vscode
        # Custom external inputs
        inputs.custom-packages.packages."x86_64-linux".thorium-avx2
        inputs.custom-packages.packages."x86_64-linux".ab-download-manager

        # =========================================================================
        # Development Frameworks, Runtimes & Compilers
        # =========================================================================
        git
        python3
        nodejs
        tk
        dotnetCorePackages.sdk_8_0
        glib
        steam-run

        # =========================================================================
        # Terminal Enhancements, Shells & CLI Utilities
        # =========================================================================
        bat
        fzf
        btop
        vim-full
    ];

}
