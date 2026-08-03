{ pkgs, ... }:

{
  home.file.".local/share/nemo/actions/ghostty.nemo_action" = {
    source = ./ghostty.nemo_action;
  };

  dconf.settings = {
    "org/nemo/preferences" = {
      default-folder-viewer = "list-view";
      show-hidden-files = true;
    };

    "org/nemo/preferences/menu-config" = {
      background-menu-open-in-terminal = false;
      selection-menu-open-in-terminal = false;
    };

    "org/nemo/search" = {
      search-reverse-sort = false;
      search-sort-column = "name";
    };

    "org/nemo/window-state" = {
      sidebar-bookmark-breakpoint = 5;
      start-with-sidebar = true;
    };
  };
}
