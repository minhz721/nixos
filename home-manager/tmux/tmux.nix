# home.nix
{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    mouse = true;         
    baseIndex = 1;         
    keyMode = "vi";  
    clock24 = true;     

    extraConfig = ''
      # Clipboard
      set -g set-clipboard on
      set-option -g renumber-windows on
      set -g allow-passthrough on

      # Catppuccin Mocha
      set -g @catppuccin_flavor 'mocha'
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_status_modules_right "directory session date_time"
      set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"

      # Resurrect & Continuum
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
    '';

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator  
      yank                
      catppuccin          
      resurrect           
      continuum           
    ];
  };
}
