{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      maple-mono.NF
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Maple Mono NF"];
        sansSerif = ["Maple Mono NF"];
      };
    };
  };
}
