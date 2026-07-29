{ config, pkgs, ... }:

{
    imports = [
        ./ghostty.nix
        ./fish.nix
        ./git.nix
        ./niri
        ./fuzzel
        ./waybar
        ./gtk.nix
        ./nemo
        ./flameshot
    ];
  
    home.username = "leomin";
    home.homeDirectory = "/home/leomin";

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
        fastfetch
        neovim

        #  
        discord
        telegram-desktop
        brave
        zathura
        mpv
        imv
        mission-center
        dbeaver-bin
        localsend

        #
        xclip
        keyd
        zoxide
        starship

        #
        lazydocker
        lazygit
        lazysql

        #
        python3
        nodejs
        tk
        ffmpeg
        fish
    ];

    
    programs.home-manager.enable = true;

    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "26.05";
}