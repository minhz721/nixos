{
  pkgs,
  lib,
  ...
}: let
  prettierFormatter = {
    command = "prettier";
    args = ["--stdin-filepath" "%{buffer_name}"];
  };
in {
  home.packages = with pkgs; [
    # Runtimes and toolchains
    uv
    bun
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    cargo-watch
    cargo-nextest
    gnumake

    # Language servers
    nil
    lua-language-server
    vtsls
    emmet-language-server
    pyright
    bash-language-server
    vscode-langservers-extracted
    yaml-language-server
    svelte-language-server
    dockerfile-language-server-nodejs
    marksman
    sqls

    # Formatters and linters
    ruff
    prettier
    alejandra
    stylua
    shfmt
    shellcheck
    hadolint
    statix
    deadnix
    sqlfluff
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    themes.catppuccin_mocha_custom = {
      inherits = "catppuccin_mocha";

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
          inlay-hints-length-limit = 50;
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
          "tab" = ":buffer-next";
          "S-tab" = ":buffer-previous";
          "C-a" = "select_all";
          "C-s" = [ ":w" "normal_mode" ];

          "y" = [ "yank" ":clipboard-yank" ];
          "p" = [ "paste_after" ":clipboard-paste-after" ];
          "P" = [ "paste_before" ":clipboard-paste-before" ];
          "R" = [ "replace" ":clipboard-paste-replace" ];

          # Leader
          "," = {
            w = ":w";
            q = ":q";
            f = "file_picker";
            b = "buffer_picker";
            s = "symbol_picker";
          };
        };

        insert = {
          "C-s" = [ ":w" "normal_mode" ];
          "C-a" = "select_all";
        };

        select = {
          "y" = [ "yank" ":clipboard-yank" ];
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
            showSuggestionsAsSnippets = false;
            includeLanguages = {
              jsx = "javascriptreact";
              tsx = "typescriptreact";
            };
          };
        };
      };

      language = [
        {
          name = "nix";
          scope = "source.nix";
          language-servers = ["nil"];
          auto-format = true;
          formatter.command = "alejandra";
        }
        {
          name = "lua";
          scope = "source.lua";
          language-servers = ["lua-language-server"];
          auto-format = true;
          formatter = {
            command = "stylua";
            args = ["-"];
          };
        }

        # TypeScript / TSX
        {
          name = "typescript";
          language-servers = ["vtsls"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "tsx";
          language-servers = ["vtsls" "emmet-lsp"];
          auto-format = true;
          formatter = prettierFormatter;
        }

        # JavaScript / JSX
        {
          name = "javascript";
          language-servers = ["vtsls"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "jsx";
          language-servers = ["vtsls" "emmet-lsp"];
          auto-format = true;
          formatter = prettierFormatter;
        }

        {
          name = "html";
          scope = "text.html.basic";
          language-servers = ["vscode-html-language-server" "emmet-lsp"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "css";
          scope = "source.css";
          language-servers = ["vscode-css-language-server" "emmet-lsp"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "json";
          scope = "source.json";
          language-servers = ["vscode-json-language-server"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "yaml";
          scope = "source.yaml";
          language-servers = ["yaml-language-server"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "svelte";
          scope = "source.svelte";
          language-servers = ["svelteserver" "emmet-lsp"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "python";
          scope = "source.python";
          language-servers = ["pyright"];
          auto-format = true;
          formatter = {
            command = "ruff";
            args = ["format" "--stdin-filename" "%{buffer_name}" "-"];
          };
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
        {
          name = "dockerfile";
          scope = "source.dockerfile";
          language-servers = ["docker-langserver"];
        }
        {
          name = "rust";
          scope = "source.rust";
          language-servers = ["rust-analyzer"];
          auto-format = true;
        }
        {
          name = "markdown";
          scope = "text.html.markdown";
          language-servers = ["marksman"];
          auto-format = true;
          formatter = prettierFormatter;
        }
        {
          name = "sql";
          scope = "source.sql";
          language-servers = ["sqls"];
        }
      ];
    };
  };
}
