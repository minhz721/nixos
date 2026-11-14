{
  pkgs,
  lib,
  ...
}: let
  resurrectScripts = "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts";

  # Bọc lệnh tmux trong "...", tự escape " và \
  q = command: "\"${lib.escape ["\"" "\\"] command}\"";

  cwd = "-c '#{pane_current_path}'";

  # Các lệnh dùng chung cho prefix-bind, Alt-bind và which-key menu
  cmd = {
    splitDown = "split-window -v ${cwd}";
    splitRight = "split-window -h ${cwd}";
    yazi = "split-window -h -b -l 25% ${cwd} 'yazi'";
    newWindow = "new-window ${cwd}";
    newSession = "command-prompt -p 'New Session Name:' \"new-session -s '%%'\"";
    renameSession = "command-prompt -I '#S' \"rename-session '%%'\"";
    renameWindow = "command-prompt -I '#W' \"rename-window '%%'\"";
  };

  # Alt-bind kiểu Zellij: nếu pane đang chạy Helix thì chuyển phím cho Helix,
  # ngược lại tmux xử lý.
  alt = key: command: "bind -n ${key} if-shell -F \"$is_hx\" \"send-keys ${key}\" ${q command}";

  altBindings =
    {
      # Điều hướng
      "M-Left" = "select-pane -L";
      "M-Right" = "select-pane -R";
      "M-Up" = "select-pane -U";
      "M-Down" = "select-pane -D";

      # Pane
      "M-n" = cmd.splitDown;
      "M-p" = cmd.splitRight;
      "M-x" = "kill-pane";
      "M-e" = cmd.yazi;
      "M-f" = "resize-pane -Z";

      # Window / tab
      "M-t" = cmd.newWindow;
      "M-q" = "kill-window";

      # Session
      "M-s" = "choose-tree -sZ";
      "M-w" = cmd.newSession;
      "M-r" = cmd.renameSession;
      "M-d" = "detach-client";

      # Resize
      "M-S-Left" = "resize-pane -L 5";
      "M-S-Right" = "resize-pane -R 5";
      "M-S-Up" = "resize-pane -U 5";
      "M-S-Down" = "resize-pane -D 5";
    }
    # Alt+1..9 chọn window
    // lib.listToAttrs (lib.genList (
        i: let
          n = toString (i + 1);
        in
          lib.nameValuePair "M-${n}" "select-window -t ${n}"
      )
      9);

  altBinds = lib.concatStringsSep "\n" (lib.mapAttrsToList alt altBindings);

  # --- Which-key menu (Ctrl+g Space) ---
  header = color: title: "${q "#[fg=${color}]── ${title} ──"} \"\" \"\"";
  item = label: key: command: "${q label} ${key} ${q command}";
  separator = "\"\"";

  menu = lib.concatStringsSep " \\\n        " [
    (header "#fab387" "TOOLS (CÔNG CỤ)")
    (item "Yazi File Tree 25% (Ctrl+g e)" "e" cmd.yazi)
    separator
    (header "#a6e3a1" "PANES (CỬA SỔ CHIA)")
    (item "Split Vertical (Ctrl+g p)" "p" cmd.splitRight)
    (item "Split Horizontal (Ctrl+g n)" "n" cmd.splitDown)
    (item "Zoom / Unzoom Pane (Ctrl+g f)" "f" "resize-pane -Z")
    (item "Close Pane (Ctrl+g x)" "x" "kill-pane")
    separator
    (header "#89b4fa" "TABS / WINDOWS")
    (item "New Tab (Ctrl+g t)" "t" cmd.newWindow)
    (item "Rename Tab (Ctrl+g ,)" "," cmd.renameWindow)
    (item "Close Tab (Ctrl+g q)" "q" "kill-window")
    separator
    (header "#f9e2af" "SESSIONS (PHIÊN LÀM VIỆC)")
    (item "Switch Session (Ctrl+g s)" "s" "choose-tree -sZ")
    (item "New Session (Ctrl+g w)" "w" cmd.newSession)
    (item "Rename Session (Ctrl+g r)" "r" cmd.renameSession)
    (item "Detach Session (Ctrl+g d)" "d" "detach-client")
    separator
    (header "#f38ba8" "KHÁC & LƯU SESSION")
    (item "Copy Mode (Ctrl+g v)" "v" "copy-mode")
    (item "Save Session (Ctrl+g Ctrl+s)" "C-s" "run-shell '${resurrectScripts}/save.sh'")
    (item "Restore Session (Ctrl+g Ctrl+r)" "C-r" "run-shell '${resurrectScripts}/restore.sh'")
    (item "Exit Menu (Esc)" "Escape" "")
  ];
in {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "emacs";
    terminal = "tmux-256color";
    shortcut = "g"; # prefix = Ctrl+g

    # Home-manager chạy plugin TRƯỚC extraConfig, nên option của plugin
    # phải đặt trong extraConfig của chính plugin (chạy ngay trước plugin đó).
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_text " #W "
          set -g @catppuccin_window_current_text "  #[bold]#W  "
          set -g @catppuccin_date_time_text "%H:%M %d-%m-%Y"
          # Đổi màu ô session khi đang bấm prefix
          set -g @catppuccin_session_color "#{?client_prefix,#{E:@thm_red},#{E:@thm_green}}"
        '';
      }

      yank

      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-processes 'hx yazi'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }

      # continuum phải load cuối cùng, và status-right phải được đặt
      # TRƯỚC nó (continuum chèn hook auto-save vào status-right).
      {
        plugin = continuum;
        extraConfig = ''
          set -g status-left ""
          set -g status-right-length 100
          set -g status-right "#{E:@catppuccin_status_directory}#{E:@catppuccin_status_session}#{E:@catppuccin_status_date_time}"

          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];

    extraConfig = ''
      # =====================================================================
      # TERMINAL: phím mở rộng cho Helix + true color
      # =====================================================================
      set -g extended-keys on
      set -as terminal-features 'xterm*:extkeys'
      set -as terminal-features 'alacritty*:extkeys'
      set -as terminal-features '*:RGB'

      set -g renumber-windows on
      set -g status-position top

      # =====================================================================
      # NHẬN DIỆN HELIX (không spawn process như ps)
      # =====================================================================
      %hidden is_hx="#{||:#{==:#{pane_current_command},hx},#{==:#{pane_current_command},.hx-wrapped}}"

      # =====================================================================
      # PREFIX (Ctrl+g) BINDINGS
      # =====================================================================
      bind n ${cmd.splitDown}
      bind p ${cmd.splitRight}
      bind x kill-pane
      bind e ${cmd.yazi}
      bind f resize-pane -Z

      bind t ${cmd.newWindow}
      bind q kill-window

      bind s choose-tree -sZ
      bind w ${cmd.newSession}
      bind r ${cmd.renameSession}
      bind d detach-client

      bind v copy-mode

      # =====================================================================
      # ALT BINDINGS (kiểu Zellij, nhường phím cho Helix)
      # =====================================================================
      ${altBinds}

      # =====================================================================
      # WHICH-KEY POPUP MENU (Ctrl+g -> Space)
      # =====================================================================
      set -g menu-style "bg=#1e1e2e,fg=#cdd6f4"
      set -g menu-selected-style "bg=#89b4fa,fg=#1e1e2e,bold"
      set -g menu-border-style "fg=#89b4fa"
      set -g menu-border-lines "rounded"

      bind Space display-menu -T ${q "#[align=centre,bold,fg=#cba6f7]  Tmux Which-Key (Prefix: Ctrl+g)  "} -x C -y C \
        ${menu}
    '';
  };
}
