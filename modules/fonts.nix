{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono.truetype
  ];
}
