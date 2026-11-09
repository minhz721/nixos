let
  prettierFormatter = {
    command = "prettier";
    args = [
      "--stdin-filepath"
      "%{buffer_name}"
    ];
  };

  indentTab = {
    tab-width = 4;
    unit = "\t";
  };

  indentYaml = {
    tab-width = 2;
    unit = "  ";
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
        bufferline = "multiple";
        completion-timeout = 5;
        completion-replace = true;
        popup-border = "all";

        indent-guides = {
          render = true;
        };
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
        statusline = {
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
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
          "C-v" = ":clipboard-paste-after";
          "C-A-down" = ["extend_line_below" "yank" "paste_after"];
          "C-A-up" = ["extend_line_below" "yank" "paste_before"];
          "C-z" = "undo";
          "C-S-r" = "redo";
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
          "C-x" = ["normal_mode" "goto_line_start" "extend_to_line_bounds" "delete_selection" "insert_mode"];
          "tab" = "insert_tab";
          "S-tab" = "unindent";
        };

        select = {
          "C-a" = "select_all";
          "C-s" = [":write" "normal_mode"];
          "C-c" = ":clipboard-yank";
          "C-v" = ":clipboard-paste-after";
          "C-A-down" = ["yank" "paste_after"];
          "C-A-up" = ["yank" "paste_before"];
          "C-z" = "undo";
          "C-S-r" = "redo";
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
        taplo = {
          command = "taplo";
          args = ["lsp" "stdio"];
        };
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
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
        bash-language-server = {
          command = "bash-language-server";
          args = ["start"];
        };
        vscode-html-language-server = {
          command = "vscode-html-language-server";
          args = ["--stdio"];
        };
        vscode-css-language-server = {
          command = "vscode-css-language-server";
          args = ["--stdio"];
        };
        vscode-json-language-server = {
          command = "vscode-json-language-server";
          args = ["--stdio"];
        };
      };

      language = [
        {
          name = "python";
          auto-format = true;
          language-servers = ["ty" "ruff"];
          indent = indentTab;
          formatter = {
            command = "ruff";
            args = ["format" "-"];
          };
        }
        {
          name = "kdl";
          scope = "source.kdl";
          file-types = ["kdl"];
          auto-format = true;
          indent = indentTab;

          formatter = {
            command = "kdlfmt";
            args = ["format" "-"];
          };
        }
        {
          name = "nix";
          scope = "source.nix";
          language-servers = ["nixd"];
          auto-format = true;
          indent = indentTab;
          formatter.command = "alejandra";
        }
        {
          name = "typescript";
          language-servers = ["vtsls"];
          auto-format = true;
          indent = indentTab;
          formatter = prettierFormatter;
        }
        {
          name = "tsx";
          language-servers = ["vtsls" "emmet-lsp"];
          auto-format = true;
          indent = indentTab;
          formatter = prettierFormatter;
        }
        {
          name = "javascript";
          language-servers = ["vtsls"];
          auto-format = true;
          indent = indentTab;
          formatter = prettierFormatter;
        }
        {
          name = "jsx";
          language-servers = ["vtsls" "emmet-lsp"];
          auto-format = true;
          indent = indentTab;
          formatter = prettierFormatter;
        }
        {
          name = "html";
          scope = "text.html.basic";
          language-servers = [
            "vscode-html-language-server"
            "emmet-lsp"
          ];
          auto-format = true;
          indent = indentTab;
          formatter = prettierFormatter;
        }
        {
          name = "css";
          scope = "source.css";
          language-servers = [
            "vscode-css-language-server"
            "emmet-lsp"
          ];
          auto-format = true;
          indent = indentTab;
          formatter = prettierFormatter;
        }
        {
          name = "json";
          scope = "source.json";
          language-servers = ["vscode-json-language-server"];
          auto-format = true;
          indent = indentTab;
          formatter = prettierFormatter;
        }
        {
          name = "yaml";
          scope = "source.yaml";
          auto-format = true;
          indent = indentYaml;
          formatter = prettierFormatter;
        }
        {
          name = "toml";
          scope = "source.toml";
          language-servers = ["taplo"];
          auto-format = true;
          indent = indentTab;
          formatter = {
            command = "taplo";
            args = ["fmt" "-"];
          };
        }
        {
          name = "bash";
          scope = "source.bash";
          language-servers = ["bash-language-server"];
          auto-format = true;
          indent = indentTab;
          formatter = {
            command = "shfmt";
            args = ["-i" "2"];
          };
        }
        {
          name = "rust";
          scope = "source.rust";
          language-servers = ["rust-analyzer"];
          auto-format = true;
          indent = indentTab;
          formatter = {
            command = "rustfmt";
          };
        }
      ];
    };
  };
}
