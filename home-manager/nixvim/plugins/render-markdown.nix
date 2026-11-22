{
  programs.nixvim.plugins.render-markdown = {
    enable = true;
    settings = {
      file_types = [ "markdown" ];
      heading = {
        sign = true;
        icons = [
          "󰲡 "
          "󰲣 "
          "󰲥 "
          "󰲧 "
          "󰲩 "
          "󰲫 "
        ];
      };
      code = {
        sign = true;
        style = "full";
        width = "block";
        border = "thin";
      };
      checkbox = {
        enabled = true;
        unchecked.icon = "󰄱 ";
        checked.icon = "󰄲 ";
      };
      bullet = {
        enabled = true;
        icons = [
          "●"
          "○"
          "◆"
          "◇"
        ];
      };
    };
  };
}
