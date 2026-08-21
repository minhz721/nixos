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

      # shadow = true;
      # shadowOpacity = 0.75;

      fading = true;
      fade-delta = 5;
      fade-in-step = 0.04;
      fade-out-step = 0.04;

      # corner-radius = 10;
      # round-borders = 4;

      # rounded-corners-exclude = [
      #   "window_type = 'dock'"
      #   "window_type = 'desktop'"
      #   "class_g = 'i3bar'"
      # ];

      blur = {
        method = "dual_kawase";
        strength = 5;
      };
    };
  };
}
