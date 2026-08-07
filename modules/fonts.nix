{pkgs, ...}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
    liberation_ttf
    nerd-fonts.fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    nerd-fonts.jetbrains-mono
    monaspace
  ];
}
