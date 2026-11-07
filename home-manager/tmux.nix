{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "emacs";
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      yank
      resurrect
      continuum
    ];

    extraConfig = ''
      # =====================================================================
      # THEME: CATPPUCCIN MOCHA CONFIGURATION (MINIMALIST TEXT STYLE)
      # =====================================================================
      set -g @catppuccin_flavor 'mocha'
      set -g @catppuccin_window_status_style "rounded"

      # Configure modules and set custom 24h & DD-MM-YYYY date time format
      set -g @catppuccin_status_modules_right "directory session date_time"
      set -g @catppuccin_date_time_text "%H:%M %d-%m-%Y"

      # Remove rounded capsule icons and switch to a clean separator style
      set -g @catppuccin_status_left_separator  " │ "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "all"
      set -g @catppuccin_status_connect_separator "yes"

      set -g status-position top

      # =====================================================================
      # CHANGE PREFIX KEY (ZELLIJ LOCK MODE STYLE)
      # =====================================================================
      set -g prefix C-g
      unbind C-b
      bind C-g send-prefix

      # =====================================================================
      # NAVIGATION: ALT + ARROW KEYS
      # =====================================================================
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # =====================================================================
      # SPLIT / CLOSE PANES (ZELLIJ LAYOUT STYLE)
      # =====================================================================
      bind -n M-n split-window -v -c "#{pane_current_path}"
      bind -n M-p split-window -h -c "#{pane_current_path}"
      bind -n M-x kill-pane

      # =====================================================================
      # WINDOWS / TABS (ZELLIJ TAB MODE STYLE)
      # =====================================================================
      bind -n M-t new-window -c "#{pane_current_path}"
      bind -n M-q kill-window

      # Quick window switching via Alt + Number
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      # =====================================================================
      # SESSIONS (ZELLIJ SESSION MODE STYLE)
      # =====================================================================
      bind -n M-s choose-tree -sZ
      bind -n M-w command-prompt -p "New Session Name:" "new-session -s '%%'"
      bind -n M-r command-prompt -I "#S" "rename-session '%%'"
      bind -n M-d detach-client

      # =====================================================================
      # RESIZE PANES: ALT + SHIFT + ARROW KEYS
      # =====================================================================
      bind -n M-S-Left resize-pane -L 5
      bind -n M-S-Right resize-pane -R 5
      bind -n M-S-Up resize-pane -U 5
      bind -n M-S-Down resize-pane -D 5
      bind -n M-f resize-pane -Z

      # =====================================================================
      # PLUGIN CONFIGURATIONS
      # =====================================================================
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
    '';
  };
}
