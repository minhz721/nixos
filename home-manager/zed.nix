{pkgs, ...}: {
  home.packages = with pkgs; [
    zed-editor
  ];

  xdg.configFile."zed/keymap.json".text = builtins.toJSON [
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
        "ctrl-v" = "terminal::Paste";
      };
    }
  ];

  xdg.configFile."zed/themes/vscode-dark.json".source =
    ./vscode-dark.json;

  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    restore_on_startup = "last_session";
    base_keymap = "VSCode";
    icon_theme = {
      mode = "dark";
      light = "Zed (Default)";
      dark = "Zed (Default)";
    };

    theme = {
      mode = "dark";
      light = "VSCode Dark";
      dark = "VSCode Dark";
    };

    ui_font_family = "Maple Mono";
    ui_font_size = 14.0;
    buffer_font_family = "Maple Mono";
    buffer_font_size = 14.0;
    format_on_save = "on";
    tab_size = 2;
    colorize_brackets = true;

    language_models = {
      openai_compatible = {
        OmniRoute = {
          api_url = "http://localhost:20128/v1";
          available_models = [
            {
              name = "ten-model-hoac-combo-tren-omniroute";
              display_name = "OmniRoute Default";
              max_tokens = 128000;
              capabilities = {
                tools = true;
                images = false;
                parallel_tool_calls = true;
                prompt_cache_key = false;
              };
            }
          ];
        };
      };
    };

    lsp = {
      nixd = {
        binary.path = "${pkgs.nixd}/bin/nixd";
      };
      # Python
      ruff = {
        binary = {
          path = "${pkgs.ruff}/bin/ruff";
          arguments = ["server"];
        };
      };
      ty = {
        binary = {
          path = "${pkgs.ty}/bin/ty";
          arguments = ["server"];
        };
        initialization_options = {
          experimental = {
            useUv = "on";
          };
        };
      };
      # Web & Config LSPs
      bash-language-server = {
        binary.path = "${pkgs.bash-language-server}/bin/bash-language-server";
        arguments = ["start"];
      };
      vscode-json-language-server = {
        binary.path = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
        arguments = ["--stdio"];
      };
      # TOML
      taplo = {
        binary.path = "${pkgs.taplo}/bin/taplo";
        arguments = ["lsp" "stdio"];
      };
      dockerfile-language-server = {
        binary.path = "${pkgs.dockerfile-language-server}/bin/docker-language-server";
        arguments = ["--stdio"];
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
      YAML = {
        formatter = {
          external = {
            command = "prettier";
            arguments = [
              "--parser"
              "yaml"
            ];
          };
        };
      };
      TOML = {
        language_servers = ["taplo"];
        formatter = {
          external = {
            command = "taplo";
            arguments = [
              "fmt"
              "-"
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
      KDL = {
        formatter = {
          external = {
            command = "kdlfmt";
            arguments = ["format" "-"];
          };
        };
      };
      Python = {
        language_servers = [
          "ty"
          "ruff"
        ];
        formatter = {
          external = {
            command = "ruff";
            arguments = [
              "format"
              "--stdin-filename"
              "{buffer_path}"
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
    };
  };
}
