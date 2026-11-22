{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      preset = "classic";
      delay = 300;
      filter = ''
        function(mapping)
          if mapping.lhs and mapping.lhs:match("^z") then
            local keep = {
              za = true,
              zc = true,
              zo = true,
              zM = true,
              zR = true,
            }
            return keep[mapping.lhs] == true
          end
          return true
        end
      '';
      spec = [
        {
          __unkeyed-1 = "<leader>f";
          group = "Find (FzfLua)";
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "Diagnostics (Trouble)";
        }
        {
          __unkeyed-1 = "<leader>n";
          group = "Notifications (Noice)";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "Code";
        }

        # Code Folding
        {
          __unkeyed-1 = "z";
          group = "Fold";
        }
        {
          __unkeyed-1 = "za";
          desc = "Toggle fold";
        }
        {
          __unkeyed-1 = "zc";
          desc = "Close fold";
        }
        {
          __unkeyed-1 = "zo";
          desc = "Open fold";
        }
        {
          __unkeyed-1 = "zM";
          desc = "Close all folds";
        }
        {
          __unkeyed-1 = "zR";
          desc = "Open all folds";
        }
      ];
    };
  };
}
