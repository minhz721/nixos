let
  indentTab = {
    tab-width = 4;
    unit = "\t";
  };

  indentSpaces = n: {
    tab-width = n;
    unit = builtins.concatStringsSep "" (builtins.genList (_: " ") n);
  };

  prettier = {
    command = "prettier";
    args = [
      "--stdin-filepath"
      "%{buffer_name}"
      "--use-tabs"
      "--tab-width"
      "4"
      "--config-precedence"
      "prefer-file"
    ];
  };

  prettierYaml = {
    command = "prettier";
    args = [
      "--stdin-filepath"
      "%{buffer_name}"
    ];
  };

  webLanguage = name: servers: {
    inherit name;
    language-servers = servers;
    auto-format = true;
    indent = indentTab;
    formatter = prettier;
  };

  sharedKeys = {
    "C-a" = "select_all";
    "C-s" = [":write" "normal_mode"];
    "C-c" = ":clipboard-yank";
    "C-v" = ":clipboard-paste-after";
    "C-z" = "undo";
    "C-S-r" = "redo";
    "C-S-z" = "redo";
  };
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    themes.dark_plus_custom = {
      inherits = "dark_plus";
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
      theme = "dark_plus_custom";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        true-color = true;
        bufferline = "multiple";
        completion-timeout = 5;
        completion-replace = true;
        popup-border = "all";

        indent-guides.render = true;
        soft-wrap = {
          enable = true;
          wrap-at-text-width = false;
        };
        lsp = {
          display-progress-messages = true;
          auto-signature-help = true;
          display-inlay-hints = true;
          snippets = true;
        };
        inline-diagnostics = {
          cursor-line = "warning";
          max-diagnostics = 5;
        };
        statusline.mode = {
          normal = "NORMAL";
          insert = "INSERT";
          select = "SELECT";
        };
      };

      keys = {
        normal =
          sharedKeys
          // {
            # Buffers
            "tab" = ":buffer-next";
            "S-tab" = ":buffer-previous";
            "C-A-down" = ["extend_line_below" "yank" "paste_after"];
            "C-A-up" = ["extend_line_below" "yank" "paste_before"];
            "C-x" = ["goto_line_start" "extend_to_line_bounds" "delete_selection"];

            "," = {
              "w" = ":write";
              "q" = ":quit";
              "f" = "file_picker";
              "e" = "file_explorer_in_current_directory";
              "b" = "buffer_picker";
              "/" = "toggle_comments";
              "r" = ":reload";
            };
          };

        insert = {
          "C-a" = "select_all";
          "C-s" = [":write" "normal_mode"];
          "C-c" = ":clipboard-yank";
          "C-v" = ":clipboard-paste-after";
          "C-A-down" = ["normal_mode" "extend_line_below" "yank" "paste_after" "insert_mode"];
          "C-A-up" = ["normal_mode" "extend_line_below" "yank" "paste_before" "insert_mode"];
          "C-z" = ["normal_mode" "undo" "insert_mode"];
          "C-S-z" = ["normal_mode" "redo" "insert_mode"];
          "C-S-r" = ["normal_mode" "redo" "insert_mode"];
          "C-x" = ["normal_mode" "goto_line_start" "extend_to_line_bounds" "delete_selection" "insert_mode"];
          "tab" = "insert_tab";
          "S-tab" = "unindent";
        };

        select =
          sharedKeys
          // {
            "C-A-down" = ["yank" "paste_after"];
            "C-A-up" = ["yank" "paste_before"];
            "C-x" = ["delete_selection"];
          };
      };
    };

    languages = {
      language-server = {
        vtsls = {
          command = "vtsls";
          args = ["--stdio"];
        };
        emmet-lsp = {
          command = "emmet-language-server";
          args = ["--stdio"];
          config = {
            showAbbreviationSuggestions = true;
            showExpandedAbbreviation = "always";
            showSuggestionsAsSnippets = true;
            includeLanguages = {
              jsx = "javascriptreact";
              tsx = "typescriptreact";
            };
          };
        };
        ty = {
          command = "ty";
          args = ["server"];
        };
        ruff = {
          command = "ruff";
          args = ["server"];
        };
        nixd.command = "nixd";
        rust-analyzer.config = {
          check = {
            command = "clippy";
            extraArgs = ["--all-targets"];
          };
          cargo = {
            allFeatures = true;
            buildScripts.enable = true;
          };
          procMacro.enable = true;
          inlayHints = {
            bindingModeHints.enable = true;
            closingBraceHints.enable = true;
            closureReturnTypeHints.enable = "with_block";
            discriminantHints.enable = "fieldless";
            lifetimeElisionHints.enable = "skip_trivial";
            typeHints.enable = true;
          };
        };
      };

      language = [
        (webLanguage "typescript" ["vtsls"])
        (webLanguage "tsx" ["vtsls" "emmet-lsp"])
        (webLanguage "javascript" ["vtsls"])
        (webLanguage "jsx" ["vtsls" "emmet-lsp"])
        (webLanguage "html" ["vscode-html-language-server" "emmet-lsp"])
        (webLanguage "css" ["vscode-css-language-server" "emmet-lsp"])
        (webLanguage "json" ["vscode-json-language-server"])

        {
          name = "bash";
          auto-format = true;
          indent = indentTab;
          formatter = {
            command = "shfmt";
            args = ["-i" "0"];
          };
        }

        {
          name = "python";
          auto-format = true;
          language-servers = ["ty" "ruff"];
          indent = indentSpaces 4;
          formatter = {
            command = "ruff";
            args = ["format" "--stdin-filename" "%{buffer_name}" "-"];
          };
        }
        {
          name = "rust";
          auto-format = true;
          indent = indentSpaces 4;
        }
        {
          name = "nix";
          language-servers = ["nixd"];
          auto-format = true;
          indent = indentSpaces 2;
          formatter.command = "alejandra";
        }
        {
          name = "yaml";
          auto-format = true;
          indent = indentSpaces 2;
          formatter = prettierYaml;
        }
        {
          name = "toml";
          auto-format = true;
          indent = indentSpaces 2;
          formatter = {
            command = "taplo";
            args = ["fmt" "-"];
          };
        }
        {
          name = "kdl";
          auto-format = true;
          indent = indentSpaces 4;
          formatter = {
            command = "kdlfmt";
            args = ["format" "-"];
          };
        }
      ];
    };
  };
}
