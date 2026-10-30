{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      project_panel = {
        dock = "left";
      };

      ui_font_family = "Maple Mono";
      ui_font_size = 14.0;
      buffer_font_size = 14.0;
      buffer_font_family = "Maple Mono";

      theme = {
        mode = "system";
        light = "One Light";
        dark = "VSCode Dark Modern";
      };

      agent = {
        dock = "right";
        sidebar_side = "right";
        favorite_models = [ ];
        model_parameters = [ ];
      };
    };
  };
}
