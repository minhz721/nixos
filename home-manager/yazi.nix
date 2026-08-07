{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_dir_first = true;
        linemode = "size";
      };

      preview = {
        wrap = "yes";
        tab_size = 2;
      };
    };
  };
}