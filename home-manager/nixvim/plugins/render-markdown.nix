{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.render-markdown = {
      enable = true;
      
      settings = {
        enabled = true;
        
        heading = {
          sign = true;
          icons = [ "1 " "2 " "3 " "4 " "5 " "6 " ];
        };
        
        checkbox = {
          enabled = true;
          unchecked = { icon = "   "; };
          checked = { icon = " "; };
        };
      };
    };

    plugins.treesitter = {
      enable = true;
      settings.ensure_installed = [ "markdown" "markdown_inline" ];
    };
  };
}
