{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "${pkgs.fish}/bin/fish";
      default_layout = "compact";
      default_mode = "normal";
      mouse_mode = true;
      pane_viewport_serialization = true;
      theme = "catppuccin-mocha";
      copy_on_select = true;
      scroll_buffer_size = 10000;
      session_serialization = true;
      on_force_close = true;
      show_startup_tips = false;
    };
    extraConfig = ''
    '';
  };
}
