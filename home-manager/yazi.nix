{
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

      opener = {
        imv = [
          {
            run = ''imv "$@"'';
            orphan = true;
            desc = "Open with imv";
          }
        ];

        mpv = [
          {
            run = ''mpv "$@"'';
            orphan = true;
            desc = "Open with mpv";
          }
        ];

        zathura = [
          {
            run = ''zathura "$@"'';
            orphan = true;
            desc = "Open with zathura";
          }
        ];
      };

      open = {
        prepend_rules = [
          {
            mime = "image/*";
            use = "imv";
          }

          {
            mime = "video/*";
            use = "mpv";
          }

          {
            mime = "audio/*";
            use = "mpv";
          }

          {
            mime = "application/pdf";
            use = "zathura";
          }
        ];
      };
    };
  };
}