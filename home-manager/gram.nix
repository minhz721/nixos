{pkgs, ...}: {
  home.packages = with pkgs; [
    gram
  ];

  xdg.configFile."gram/keymap.jsonc".text = builtins.toJSON [
    {
      context = "Editor";
      bindings = {
        "ctrl-alt-down" = "editor::DuplicateLineDown";
        "ctrl-alt-up" = "editor::DuplicateLineUp";
      };
    }
    {
      context = "Terminal";
      bindings = {
        # "ctrl-c" = "terminal::Copy";
        "ctrl-v" = "terminal::Paste";
      };
    }
  ];

  xdg.configFile."gram/settings.jsonc".text = builtins.toJSON {
    restore_on_startup = "last_session";
    base_keymap = "VSCode";
    icon_theme = {
      mode = "dark";
      light = "Gram (Default)";
      dark = "Gram (Default)";
    };

    theme = {
      mode = "dark";
      light = "Catppuccin Mocha";
      dark = "Catppuccin Mocha";
    };

    ui_font_family = "Maple Mono";
    ui_font_size = 14.0;
    buffer_font_family = "Maple Mono";
    buffer_font_size = 14.0;
    format_on_save = "on";

    lsp = {
      nil = {
        binary.path = "${pkgs.nil}/bin/nil";
      };
      pyright = {
        binary.path = "${pkgs.pyright}/bin/pyright-langserver";
      };
      bash-language-server = {
        binary.path = "${pkgs.bash-language-server}/bin/bash-language-server";
        arguments = ["start"];
      };
      vscode-json-language-server = {
        binary.path = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
        arguments = ["--stdio"];
      };
      yaml-language-server = {
        binary.path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
        arguments = ["--stdio"];
      };
      dockerfile-language-server = {
        binary.path = "${pkgs.dockerfile-language-server}/bin/docker-language-server";
        arguments = ["--stdio"];
      };
      marksman = {
        binary.path = "${pkgs.marksman}/bin/marksman";
      };
      sqls = {
        binary.path = "${pkgs.sqls}/bin/sqls";
      };
      rust-analyzer = {
        binary.path = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        initialization_options = {
          inlayHints = {
            maxLength = null;
            lifetimeElisionHints = {
              enable = "skip_trivial";
              useParameterNames = true;
            };
            closureReturnTypeHints = {
              enable = "always";
            };
          };
        };
      };
    };

    languages = {
      Rust = {
        formatter = {
          external = {
            command = "rustfmt";
            arguments = [
              "--emit"
              "stdout"
            ];
          };
        };
      };

      JavaScript = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--stdin-filepath"
              "{buffer_path}"
            ];
          };
        };
      };
      TypeScript = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--stdin-filepath"
              "{buffer_path}"
            ];
          };
        };
      };
      TSX = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--stdin-filepath"
              "{buffer_path}"
            ];
          };
        };
      };
      HTML = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--parser"
              "html"
            ];
          };
        };
      };
      CSS = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--parser"
              "css"
            ];
          };
        };
      };
      JSON = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--parser"
              "json"
            ];
          };
        };
      };
      Nix = {
        formatter = {
          external = {
            command = "alejandra";
            arguments = ["-"];
          };
        };
      };
      Python = {
        formatter = {
          external = {
            command = "ruff";
            arguments = [
              "format"
              "-"
            ];
          };
        };
      };
      Bash = {
        formatter = {
          external = {
            command = "shfmt";
            arguments = [
              "-i"
              "2"
              "-"
            ];
          };
        };
      };
      Markdown = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--parser"
              "markdown"
            ];
          };
        };
      };
      SQL = {
        formatter = {
          external = {
            command = "sqlfluff";
            arguments = [
              "format"
              "-"
            ];
          };
        };
      };
    };
  };
}
