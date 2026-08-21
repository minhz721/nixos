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
  };
};
}
