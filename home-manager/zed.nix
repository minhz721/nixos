{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    userSettings = {
      format_on_save = "on";
      # -----------------------------------------------------------------
      # UI, Font & Theme
      # -----------------------------------------------------------------
      project_panel = {
        dock = "left";
      };
      ui_font_family = "Maple Mono";
      ui_font_size = 14.0;
      buffer_font_size = 14.0;
      buffer_font_family = "Maple Mono";
      theme = {
        mode = "system";
        light = "One Light";
        dark = "VSCode Dark Modern";
      };
      agent = {
        dock = "right";
        sidebar_side = "right";
        favorite_models = [];
        model_parameters = [];
      };
      # -----------------------------------------------------------------
      # LSP
      # -----------------------------------------------------------------
      lsp = {
        # Nix
        nil.binary.path = "${pkgs.nil}/bin/nil";
        # Python (dùng pyright & ruff)
        pyright.binary.path = "${pkgs.pyright}/bin/pyright-langserver";
        ruff.binary.path = "${pkgs.ruff}/bin/ruff";
        # JS / TS / JSX / TSX
        vtsls.binary.path = "${pkgs.vtsls}/bin/vtsls";
        # Rust
        rust-analyzer = {
          binary.path = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          initialization_options = {
            check = {
              command = "clippy";
            };
          };
        };
        # Lua, Bash, Markdown, SQL
        lua-language-server.binary.path = "${pkgs.lua-language-server}/bin/lua-language-server";
        bash-language-server.binary.path = "${pkgs.bash-language-server}/bin/bash-language-server";
        yaml-language-server.binary.path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
        marksman.binary.path = "${pkgs.marksman}/bin/marksman";
        sqls.binary.path = "${pkgs.sqls}/bin/sqls";
        # HTML / CSS / JSON
        vscode-html-language-server.binary.path = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
        vscode-css-language-server.binary.path = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
        vscode-json-language-server.binary.path = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      };
      # -----------------------------------------------------------------
      # LSP + Formatter
      # -----------------------------------------------------------------
      languages = {
        Nix = {
          language_servers = ["nil"];
          formatter = {
            external = {
              command = "${pkgs.alejandra}/bin/alejandra";
              args = ["--quiet" "-"];
            };
          };
        };
        Python = {
          language_servers = ["pyright" "ruff"];
          formatter = {
            external = {
              command = "${pkgs.ruff}/bin/ruff";
              args = ["format" "--stdin-filename" "$FILENAME" "-"];
            };
          };
        };
        Rust = {
          language_servers = ["rust-analyzer"];
        };
        JavaScript = {
          language_servers = ["vtsls"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        TypeScript = {
          language_servers = ["vtsls"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        TSX = {
          language_servers = ["vtsls"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        JSX = {
          language_servers = ["vtsls"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        HTML = {
          language_servers = ["vscode-html-language-server"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        CSS = {
          language_servers = ["vscode-css-language-server"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        JSON = {
          language_servers = ["vscode-json-language-server"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        YAML = {
          language_servers = ["yaml-language-server"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        Markdown = {
          language_servers = ["marksman"];
          formatter = {
            external = {
              command = "${pkgs.bun}/bin/bun";
              args = ["x" "prettier" "--stdin-filepath" "$FILENAME"];
            };
          };
        };
        Lua = {
          language_servers = ["lua-language-server"];
          formatter = {
            external = {
              command = "${pkgs.stylua}/bin/stylua";
              args = ["-"];
            };
          };
        };
        Bash = {
          language_servers = ["bash-language-server"];
          formatter = {
            external = {
              command = "${pkgs.shfmt}/bin/shfmt";
              args = ["-i" "2"];
            };
          };
        };
      };
    };
  };
}
