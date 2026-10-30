{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    themes.catppuccin_mocha_custom = {
      inherits = "catppuccin_mocha";

      "ui.background" = {};

      # TODO / FIXME / NOTE / HACK
      "comment.note" = {
        fg = "#89b4fa";
        modifiers = ["bold"];
      };
      "comment.warning" = {
        fg = "#f9e2af";
        modifiers = ["bold"];
      };
      "comment.error" = {
        fg = "#f38ba8";
        modifiers = ["bold"];
      };

      "special" = {
        fg = "#f9e2af";
        modifiers = ["bold"];
      };
      "markup.heading.marker" = {
        fg = "#f38ba8";
        modifiers = ["bold"];
      };
    };

    settings = {
      theme = "catppuccin_mocha_custom";

      editor = {
        # General editing
        line-number = "relative";
        scrolloff = 8;
        mouse = true;
        cursorline = true;
        cursorcolumn = false;
        color-modes = true;
        bufferline = "multiple";
        text-width = 100;
        indent-heuristic = "hybrid";
        continue-comments = false;

        # Completion
        auto-completion = true;
        completion-trigger-len = 2;
        completion-timeout = 5;
        completion-replace = true;
        preview-completion-insert = true;
        path-completion = true;
        auto-info = true;

        # File handling
        insert-final-newline = true;
        atomic-save = true;
        trim-trailing-whitespace = true;

        # Visual feedback
        popup-border = "all";
        end-of-line-diagnostics = "disable";

        gutters = [
          "diagnostics"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];

        statusline = {
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        soft-wrap = {
          enable = true;
          wrap-at-text-width = true;
          max-wrap = 25;
          max-indent-retain = 40;
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        lsp = {
          enable = true;
          display-messages = true;
          display-progress-messages = true;
          auto-signature-help = true;
          display-signature-help-docs = true;
          display-inlay-hints = true;
          inlay-hints-length-limit = 10;
          snippets = true;
          goto-reference-include-declaration = true;
          display-color-swatches = true;
        };

        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "disable";
          max-diagnostics = 5;
        };

        indent-guides = {
          render = true;
          character = "│";
          skip-levels = 0;
        };

        file-picker = {
          hidden = true;
          follow-symlinks = true;
          git-ignore = false;
          git-exclude = true;
          git-global = true;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "file-modification-indicator"
          ];
          center = ["version-control"];
          right = [
            "diagnostics"
            "workspace-diagnostics"
            "selections"
            "position"
            "position-percentage"
            "file-encoding"
            "file-line-ending"
          ];
          separator = "│";
        };
      };

      keys = {
        normal = {
          # Buffers
          "tab" = ":buffer-next";
          "S-tab" = ":buffer-previous";

          "C-a" = "select_all";
          "C-s" = [":write" "normal_mode"];
          "C-c" = ":clipboard-yank";
          "C-p" = ":clipboard-paste-after";

          "y" = ["yank" ":clipboard-yank"];
          "p" = ["paste_after" ":clipboard-paste-after"];
          "P" = ["paste_before" ":clipboard-paste-before"];
          "R" = ["replace_with_yanked"];

          "C-A-down" = ["extend_line_below" "yank" "paste_after"];
          "C-A-up" = ["extend_line_below" "yank" "paste_before"];

          "C-/" = "toggle_comments";
          "C-z" = "undo";

          "C-d" = ["extend_line_below" "delete_selection"];

          "," = {
            "w" = ":write";
            "q" = ":quit";
            "f" = "file_picker";
            "b" = "buffer_picker";
            "s" = "symbol_picker";
            "/" = "global_search";
          };
        };

        insert = {
          "C-a" = "select_all";
          "C-s" = [":write" "normal_mode"];
          "C-c" = ":clipboard-yank";
          "C-p" = ":clipboard-paste-after";

          "C-/" = "toggle_comments";
          "C-z" = ["normal_mode" "undo" "insert_mode"];

          "C-d" = ["normal_mode" "kill_to_line_start" "kill_to_line_end" "insert_mode"];
        };

        select = {
          "C-a" = "select_all";
          "C-s" = [":write" "normal_mode"];
          "C-c" = ":clipboard-yank";
          "C-p" = ":clipboard-paste-after";

          "y" = ["yank" ":clipboard-yank"];
          "p" = ["paste_after" ":clipboard-paste-after"];
          "P" = ["paste_before" ":clipboard-paste-before"];
          "R" = ["replace_with_yanked"];

          "C-A-down" = ["yank" "paste_after"];
          "C-A-up" = ["yank" "paste_before"];

          "C-/" = "toggle_comments";
          "C-z" = "undo";

          "C-d" = "delete_selection";
        };
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          scope = "source.nix";
          language-servers = ["nil"];
          auto-format = true;
          formatter.command = "alejandra";
        }
        {
          name = "bash";
          scope = "source.bash";
          language-servers = ["bash-language-server"];
          auto-format = true;
          formatter = {
            command = "shfmt";
            args = ["-i" "2"];
          };
        }
      ];
    };
  };
}
