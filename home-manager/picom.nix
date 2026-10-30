{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    settings = {
      use-damage = true;
      xrender-sync-fence = true;

      fading = true;
      fade-delta = 4;
      no-fading-openclose = true;
      blur = {
        method = "dual_kawase";
        strength = 6;
      };
    };
  };
}
