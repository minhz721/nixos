{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          theme = "OceanicNext"; # vscode
          globalstatus = true;
          section_separators = "";
          component_separators = "";
        };

        sections = {
          lualine_a = [
            "mode"
          ];

          lualine_b = [
            "branch"
            "diff"
          ];

          lualine_c = [
            "filename"
          ];

          lualine_x = [
            "diagnostics"
            "encoding"
            "filetype"
          ];

          lualine_y = [
            "progress"
          ];

          lualine_z = [
            "location"
          ];
        };
      };
    };
  };
}