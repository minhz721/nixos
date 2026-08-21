{
  config,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    settings = {
      use-damage = true;
      xrender-sync-fence = true;

      fading = true;
      fade-in-step = 0.04;
      fade-out-step = 0.04;
      fade-delta = 5;
      # inactive-opacity = 0.75;
      # active-opacity = 1.0;
      # frame-opacity = 1.0;
    };
  };
}
