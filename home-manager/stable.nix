{pkgs, ...}: {
  home.packages = with pkgs; [
    # Archive & System Utilities
    czkawka
    # File Managers
    yazi
    # Multimedia
    imv
    mpv
    ffmpeg
    cava
    # Disk / Filesystem GUI & Automount
    gnome-disk-utility
    # Desktop Applications
    zathura
    mission-center
    localsend
    # Communication & Applications
    telegram-desktop
    bruno
  ];
}
