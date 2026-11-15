{
  lib,
  pkgs,
  ...
}: let
  fmt = command: arguments: {external = {inherit command arguments;};};
  prettier = fmt "prettier" ["--stdin-filepath" "{buffer_path}"];
in {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "vscode-dark-modern" #
      "nix"
      "toml"
      "dockerfile"
      "kdl"
      "html"
    ];

    userKeymaps = [
      {
        context = "Editor";
        bindings = {
          "ctrl-v" = "editor::Paste";
          "ctrl-alt-down" = "editor::DuplicateLineDown";
          "ctrl-alt-up" = "editor::DuplicateLineUp";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "ctrl-v" = "project_panel::Paste";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-v" = "terminal::Paste";
        };
      }
    ];

    userSettings = {
      auto_update = false;
      restore_on_startup = "last_session";
      base_keymap = "VSCode";
      project_panel.dock = "left";
      agent = {
        dock = "right";
        threads_sidebar.position = "right";
      };

      theme = {
        mode = "dark";
        light = "VSCode Dark Modern";
        dark = "VSCode Dark Modern";
      };
      icon_theme = {
        mode = "dark";
        light = "Zed (Default)";
        dark = "Zed (Default)";
      };
      ui_font_family = "Maple Mono";
      ui_font_size = 14.0;
      buffer_font_family = "Maple Mono";
      buffer_font_size = 14.0;
      colorize_brackets = true;
      format_on_save = "on";
      tab_size = 2;

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      lsp = {
        nixd.binary.path = lib.getExe pkgs.nixd;

        ruff.binary = {
          path = lib.getExe pkgs.ruff;
          arguments = ["server"];
        };
        ty = {
          binary = {
            path = lib.getExe pkgs.ty;
            arguments = ["server"];
          };
          initialization_options.experimental.useUv = "on";
        };

        bash-language-server.binary = {
          path = lib.getExe pkgs.bash-language-server;
          arguments = ["start"];
        };
        vscode-json-language-server.binary = {
          path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-json-language-server";
          arguments = ["--stdio"];
        };
        taplo.binary = {
          path = lib.getExe pkgs.taplo;
          arguments = ["lsp" "stdio"];
        };
        dockerfile-language-server.binary = {
          path = lib.getExe pkgs.dockerfile-language-server;
          arguments = ["--stdio"];
        };

        rust-analyzer.initialization_options.inlayHints = {
          maxLength = null;
          lifetimeElisionHints = {
            enable = "skip_trivial";
            useParameterNames = true;
          };
          closureReturnTypeHints.enable = "always";
        };
      };

      languages =
        lib.genAttrs ["JavaScript" "TypeScript" "TSX" "HTML" "CSS" "JSON" "YAML"] (_: {
          formatter = prettier;
        })
        // {
          Python = {
            language_servers = ["ty" "ruff"];
            formatter = fmt "ruff" ["format" "--stdin-filename" "{buffer_path}" "-"];
          };
          TOML = {
            language_servers = ["taplo"];
            formatter = fmt "taplo" ["fmt" "-"];
          };
          Nix.formatter = fmt "alejandra" ["-"];
          KDL.formatter = fmt "kdlfmt" ["format" "-"];
          Bash.formatter = fmt "shfmt" ["-i" "2" "-"];
        };
    };
  };
}
