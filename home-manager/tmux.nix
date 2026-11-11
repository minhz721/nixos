{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "emacs";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      yank
      resurrect
      continuum
    ];

    extraConfig = ''
      # =====================================================================
      # EXTENDED KEYS SUPPORT FOR HELIX
      # =====================================================================
      set -g extended-keys on
      set -g xterm-keys on
      set -as terminal-features 'xterm*:extkeys'
      set -as terminal-features ',*:RGB'

      # =====================================================================
      # THEME: CATPPUCCIN MOCHA CONFIGURATION
      # =====================================================================
      set -g @catppuccin_flavor 'mocha'
      set -g @catppuccin_window_status_style "rounded"

       set -g @catppuccin_window_current_text "  #[bold]#W  "
      set -g @catppuccin_window_default_text " #W "

      set -g @catppuccin_status_modules_right "directory session date_time"
      set -g @catppuccin_date_time_text "%H:%M %d-%m-%Y"
      set -g @catppuccin_status_left_separator  " │ "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "all"
      set -g @catppuccin_status_connect_separator "yes"
      set -g status-position top

      # =====================================================================
      # PREFIX & SMART HELIX DETECTION
      # =====================================================================
      set -g prefix C-g
      unbind C-b
      bind C-g send-prefix

      is_hx="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?hx$'"

      # Navigation
      bind -n M-Left  if-shell "$is_hx" "send-keys M-Left"  "select-pane -L"
      bind -n M-Right if-shell "$is_hx" "send-keys M-Right" "select-pane -R"
      bind -n M-Up    if-shell "$is_hx" "send-keys M-Up"    "select-pane -U"
      bind -n M-Down  if-shell "$is_hx" "send-keys M-Down"  "select-pane -D"

      bind Left  select-pane -L
      bind Right select-pane -R
      bind Up    select-pane -U
      bind Down  select-pane -D

      # Panes
      bind -n M-n if-shell "$is_hx" "send-keys M-n" "split-window -v -c '#{pane_current_path}'"
      bind -n M-p if-shell "$is_hx" "send-keys M-p" "split-window -h -c '#{pane_current_path}'"
      bind -n M-x if-shell "$is_hx" "send-keys M-x" "kill-pane"

      bind n split-window -v -c "#{pane_current_path}"
      bind p split-window -h -c "#{pane_current_path}"
      bind x kill-pane

      # Windows / Tabs
      bind -n M-t if-shell "$is_hx" "send-keys M-t" "new-window -c '#{pane_current_path}'"
      bind -n M-q if-shell "$is_hx" "send-keys M-q" "kill-window"

      bind t new-window -c "#{pane_current_path}"
      bind q kill-window

      bind -n M-1 if-shell "$is_hx" "send-keys M-1" "select-window -t 1"
      bind -n M-2 if-shell "$is_hx" "send-keys M-2" "select-window -t 2"
      bind -n M-3 if-shell "$is_hx" "send-keys M-3" "select-window -t 3"
      bind -n M-4 if-shell "$is_hx" "send-keys M-4" "select-window -t 4"
      bind -n M-5 if-shell "$is_hx" "send-keys M-5" "select-window -t 5"
      bind -n M-6 if-shell "$is_hx" "send-keys M-6" "select-window -t 6"
      bind -n M-7 if-shell "$is_hx" "send-keys M-7" "select-window -t 7"
      bind -n M-8 if-shell "$is_hx" "send-keys M-8" "select-window -t 8"
      bind -n M-9 if-shell "$is_hx" "send-keys M-9" "select-window -t 9"

      # Sessions
      bind -n M-s if-shell "$is_hx" "send-keys M-s" "choose-tree -sZ"
      bind -n M-w if-shell "$is_hx" "send-keys M-w" "command-prompt -p 'New Session Name:' 'new-session -s \"%%\"'"
      bind -n M-r if-shell "$is_hx" "send-keys M-r" "command-prompt -I '#S' 'rename-session \"%%\"'"
      bind -n M-d if-shell "$is_hx" "send-keys M-d" "detach-client"

      bind s choose-tree -sZ
      bind w command-prompt -p "New Session Name:" "new-session -s '%%'"
      bind r command-prompt -I "#S" "rename-session '%%'"
      bind d detach-client

      # Resize & Zoom
      bind -n M-S-Left  if-shell "$is_hx" "send-keys M-S-Left"  "resize-pane -L 5"
      bind -n M-S-Right if-shell "$is_hx" "send-keys M-S-Right" "resize-pane -R 5"
      bind -n M-S-Up    if-shell "$is_hx" "send-keys M-S-Up"    "resize-pane -U 5"
      bind -n M-f       if-shell "$is_hx" "send-keys M-f"       "resize-pane -Z"

      bind f resize-pane -Z

      # =====================================================================
      # WHICH-KEY POPUP MENU (CTRL + G --> SPACE)
      # =====================================================================
      set -g menu-style "bg=#1e1e2e,fg=#cdd6f4"
      set -g menu-selected-style "bg=#89b4fa,fg=#1e1e2e,bold"
      set -g menu-border-style "fg=#89b4fa"
      set -g menu-border-lines "rounded"

      bind Space display-menu -T "#[align=centre,bold,fg=#cba6f7]    Tmux Which-Key " -x C -y C \
        "#[fg=#a6e3a1]── PANES (CỬA SỔ CHIA) ──" "" "" \
        "Split Vertical (Chia dọc)"       p "split-window -h -c '#{pane_current_path}'" \
        "Split Horizontal (Chia ngang)"   n "split-window -v -c '#{pane_current_path}'" \
        "Zoom / Unzoom Pane (Phóng to)"   f "resize-pane -Z" \
        "Close Pane (Đóng pane)"          x "kill-pane" \
        "" \
        "#[fg=#89b4fa]── TABS / WINDOWS ──" "" "" \
        "New Tab (Tab mới)"               t "new-window -c '#{pane_current_path}'" \
        "Rename Tab (Đổi tên tab)"        , "command-prompt -I '#W' 'rename-window \"%%\"'" \
        "Close Tab (Đóng tab)"            q "kill-window" \
        "" \
        "#[fg=#f9e2af]── SESSIONS (PHIÊN LÀM VIỆC) ──" "" "" \
        "Switch Session (Danh sách)"      s "choose-tree -sZ" \
        "New Session (Tạo mới)"           w "command-prompt -p 'New Session Name:' 'new-session -s \"%%\"'" \
        "Rename Session (Đổi tên)"        r "command-prompt -I '#S' 'rename-session \"%%\"'" \
        "Detach Session (Thoát ngầm)"     d "detach-client" \
        "" \
        "#[fg=#f38ba8]── KHÁC ──" "" "" \
        "Copy Mode (Cuộn / Copy)"         v "copy-mode" \
        "Exit Menu (Thoát menu)"          Escape ""

      # =====================================================================
      # PLUGIN CONFIGURATIONS
      # =====================================================================
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
    '';
  };
}
