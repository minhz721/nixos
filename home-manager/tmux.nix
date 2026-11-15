{
  pkgs,
  lib,
  ...
}: let
  resurrectScripts = "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts";
  # Wrap tmux command in "...", auto-escape " and \
  q = command: "\"${lib.escape ["\"" "\\"] command}\"";
  cwd = "-c '#{pane_current_path}'";
  # Common commands for Alt-binds and the which-key menu
  cmd = {
    splitDown = "split-window -v ${cwd}";
    splitRight = "split-window -h ${cwd}";
    yazi = "split-window -h -b -l 25% ${cwd} 'yazi'";
    newWindow = "new-window ${cwd}";
    newSession = "command-prompt -p 'New Session Name:' \"new-session -s '%%'\"";
    renameSession = "command-prompt -I '#S' \"rename-session '%%'\"";
    renameWindow = "command-prompt -I '#W' \"rename-window '%%'\"";
  };
  # Zellij-style Alt-binds: if the pane is running Helix, send keys to Helix,
  # otherwise let tmux handle it.
  alt = key: command: "bind -n ${key} if-shell -F \"$is_hx\" \"send-keys ${key}\" ${q command}";
  altBindings =
    {
      # Navigation
      "M-Left" = "select-pane -L";
      "M-Right" = "select-pane -R";
      "M-Up" = "select-pane -U";
      "M-Down" = "select-pane -D";
      # Panes
      "M-n" = cmd.splitDown;
      "M-p" = cmd.splitRight;
      "M-x" = "kill-pane";
      "M-e" = cmd.yazi;
      "M-f" = "resize-pane -Z";
      # Windows / Tabs
      "M-t" = cmd.newWindow;
      "M-q" = "kill-window";
      # Sessions
      "M-s" = "choose-tree -sZ";
      "M-w" = cmd.newSession;
      "M-r" = cmd.renameSession;
      "M-d" = "detach-client";
      # Resizing
      "M-S-Left" = "resize-pane -L 5";
      "M-S-Right" = "resize-pane -R 5";
      "M-S-Up" = "resize-pane -U 5";
      "M-S-Down" = "resize-pane -D 5";
    }
    # Alt+1..9 select window
    // lib.listToAttrs (lib.genList (
        i: let
          n = toString (i + 1);
        in
          lib.nameValuePair "M-${n}" "select-window -t ${n}"
      )
      9);

  altBinds = lib.concatStringsSep "\n" (lib.mapAttrsToList alt altBindings);

  # --- Which-key menu (Alt+Space) ---
  header = color: title: "${q "#[fg=${color}]── ${title} ──"} \"\" \"\"";
  item = label: key: command: "${q label} ${key} ${q command}";
  separator = "\"\"";

  menu = lib.concatStringsSep " \\\n        " [
    (header "#fab387" "TOOLS")
    (item "Yazi File Tree 25% (Alt+e)" "e" cmd.yazi)
    separator
    (header "#a6e3a1" "PANES")
    (item "Split Vertical (Alt+p)" "p" cmd.splitRight)
    (item "Split Horizontal (Alt+n)" "n" cmd.splitDown)
    (item "Zoom / Unzoom Pane (Alt+f)" "f" "resize-pane -Z")
    (item "Close Pane (Alt+x)" "x" "kill-pane")
    separator
    (header "#89b4fa" "TABS / WINDOWS")
    (item "New Tab (Alt+t)" "t" cmd.newWindow)
    (item "Rename Tab (Alt+,)" "," cmd.renameWindow)
    (item "Close Tab (Alt+q)" "q" "kill-window")
    separator
    (header "#f9e2af" "SESSIONS")
    (item "Switch Session (Alt+s)" "s" "choose-tree -sZ")
    (item "New Session (Alt+w)" "w" cmd.newSession)
    (item "Rename Session (Alt+r)" "r" cmd.renameSession)
    (item "Detach Session (Alt+d)" "d" "detach-client")
    separator
    (header "#f38ba8" "OTHER & SESSION RESURRECT")
    (item "Copy Mode (Alt+v)" "v" "copy-mode")
    (item "Save Session" "C-s" "run-shell '${resurrectScripts}/save.sh'")
    (item "Restore Session" "C-r" "run-shell '${resurrectScripts}/restore.sh'")
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

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_text " #W "
          set -g @catppuccin_window_current_text "  #[bold]#W  "
          set -g @catppuccin_date_time_text "%H:%M %d-%m-%Y"
          set -g @catppuccin_session_color "#{E:@thm_green}"
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
      # TERMINAL: extended keys for Helix + true color
      # =====================================================================
      set -g extended-keys on
      set -as terminal-features 'xterm*:extkeys'
      set -as terminal-features 'alacritty*:extkeys'
      set -as terminal-features '*:RGB'

      set -g renumber-windows on
      set -g status-position top

      # =====================================================================
      # HELIX DETECTION (avoid spawning processes like ps)
      # =====================================================================
      %hidden is_hx="#{||:#{==:#{pane_current_command},hx},#{==:#{pane_current_command},.hx-wrapped}}"

      # =====================================================================
      # ALT BINDINGS (Zellij-style, passing keys to Helix when active)
      # =====================================================================
      ${altBinds}

      # =====================================================================
      # WHICH-KEY POPUP MENU (Alt + Space)
      # =====================================================================
      set -g menu-style "bg=#1e1e2e,fg=#cdd6f4"
      set -g menu-selected-style "bg=#89b4fa,fg=#1e1e2e,bold"
      set -g menu-border-style "fg=#89b4fa"
      set -g menu-border-lines "rounded"

      bind -n M-Space display-menu -T ${q "#[align=centre,bold,fg=#cba6f7]  Tmux Menu (Alt-based)  "} -x C -y C \
        ${menu}
    '';
  };
}
