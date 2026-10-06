{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    settings = {
      use-damage = true;
      xrender-sync-fence = true;

      fading = true;
      fade-delta = 2;
      fade-in-step = 0.08;
      fade-out-step = 0.08;
      no-fading-openclose = false;
      blur = {
        method = "dual_kawase";
        strength = 4;
      };
    };
  };
}
