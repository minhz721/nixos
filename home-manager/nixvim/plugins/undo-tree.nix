{ config, pkgs, ... }:

{
  programs.nixvim = {
    # https://github.io
    plugins.undotree = {
      enable = true;
      
      settings = {
        # Visual layout configuration parameters
        WindowLayout = 1;              # Style 1: Opens the undo tree panel on the left side
        ShortIndicators = true;        # Uses short letters (like 's' for seconds) to save screen space
        DiffpanelHeight = 10;          # Height allocated for the diff comparison block at the bottom
        SetFocusWhenToggle = true;     # Instantly moves your cursor focus into the undotree panel upon toggling
      };
    };

    # Custom global shortcut to toggle the Undotree panel open/close
    # Match VS Code style mechanics or standard Vim diagnostics layout
    keymaps = [
      {
        mode = "n";
        key = "<leader>u";             # Press Space + u to toggle the Undo Tree layout
        action = "<cmd>UndotreeToggle<CR>";
        options = {
          silent = true;
          desc = "Toggle Undotree historical timelines panel";
        };
      }
    ];
  };
}
