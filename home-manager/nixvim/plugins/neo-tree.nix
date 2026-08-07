{
  programs.nixvim = {
    plugins.mini-icons = {
      enable = true;
      mockDevIcons = true;
    };
    plugins.neo-tree = {
      enable = true;

      settings = {
        # close_if_last_window = true;

        popup_border_style = "rounded";

        filesystem = {
          filtered_items = {
            hide_dotfiles = false;
            hide_gitignored = false;
          };

          follow_current_file = {
            enabled = true;
          };

          use_libuv_file_watcher = true;
        };

        # window = {
        #   width = 35;
        # };
      };
    };
  };
}
