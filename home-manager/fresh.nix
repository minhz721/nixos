{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  biomeConfigDir = "${config.xdg.configHome}/biome";

  biomeFormatter = {
    command = lib.getExe pkgsUnstable.biome;
    args = [
      "format"
      "--stdin-file-path"
      "{file}"
      "--config-path"
      biomeConfigDir
    ];
    stdin = true;
  };
in
{
  programs.fresh-editor = {
    enable = true;
    package = pkgsUnstable.fresh-editor;

    # Ensure all CLI tools, LSPs, and formatters are on Fresh's PATH
    extraPackages = with pkgsUnstable; [
      rust-analyzer
      rustfmt
      nixd
      nixfmt
      vtsls
      biome
      vscode-langservers-extracted
      ruff
      ty
      taplo
      shfmt
      stylua
      ripgrep
      fd
    ];

    settings = {
      theme = "dark";
      check_for_updates = false;
      show_welcome = false;
      editor = {
        tab_size = 4;
        use_tabs = false;
        line_numbers = true;
        relative_line_numbers = true;
        line_wrap = true;
        auto_indent = true;
        bracket_matching = true;
        highlight_current_line = true;
      };

      file_explorer = {
        respect_gitignore = true;
      };

      # LSP servers
      lsp = {
        rust = {
          command = lib.getExe pkgsUnstable.rust-analyzer;
          args = [ ];
        };
        nix = {
          command = lib.getExe pkgsUnstable.nixd;
          args = [ ];
        };
        typescript = {
          command = lib.getExe pkgsUnstable.vtsls;
          args = [ "--stdio" ];
        };
        javascript = {
          command = lib.getExe pkgsUnstable.vtsls;
          args = [ "--stdio" ];
        };
        python = [
          {
            command = lib.getExe pkgsUnstable.ty;
            args = [ "server" ];
          }
          {
            command = lib.getExe pkgsUnstable.ruff;
            args = [ "server" ];
          }
        ];
        toml = {
          command = lib.getExe pkgsUnstable.taplo;
          args = [
            "lsp"
            "stdio"
          ];
        };
        json = {
          command = lib.getExe' pkgsUnstable.vscode-langservers-extracted "vscode-json-language-server";
          args = [ "--stdio" ];
        };
        html = {
          command = lib.getExe' pkgsUnstable.vscode-langservers-extracted "vscode-html-language-server";
          args = [ "--stdio" ];
        };
        css = {
          command = lib.getExe' pkgsUnstable.vscode-langservers-extracted "vscode-css-language-server";
          args = [ "--stdio" ];
        };
        # Disable built-in LSP defaults where you only want formatting
        lua = {
          enabled = false;
        };
        bash = {
          enabled = false;
        };
        yaml = {
          enabled = false;
        };
        markdown = {
          enabled = false;
        };
      };

      # Per-language indentation & format-on-save rules
      languages = {
        rust = {
          tab_size = 4;
          use_tabs = false;
          format_on_save = true;
          formatter = {
            command = lib.getExe pkgsUnstable.rustfmt;
            args = [ "--edition=2021" ];
            stdin = true;
          };
        };

        python = {
          tab_size = 4;
          use_tabs = false;
          format_on_save = true;
          formatter = {
            command = lib.getExe pkgsUnstable.ruff;
            args = [
              "format"
              "--stdin-filename"
              "{file}"
              "-"
            ];
            stdin = true;
          };
        };

        nix = {
          tab_size = 2;
          use_tabs = false;
          format_on_save = true;
          formatter = {
            command = lib.getExe pkgsUnstable.nixfmt;
            args = [ ];
            stdin = true;
          };
        };

        lua = {
          tab_size = 2;
          use_tabs = false;
          format_on_save = true;
          formatter = {
            command = lib.getExe pkgsUnstable.stylua;
            args = [
              "--stdin-filepath"
              "{file}"
              "-"
            ];
            stdin = true;
          };
        };

        toml = {
          tab_size = 2;
          use_tabs = false;
          format_on_save = true;
          formatter = {
            command = lib.getExe pkgsUnstable.taplo;
            args = [
              "fmt"
              "-"
            ];
            stdin = true;
          };
        };

        yaml = {
          tab_size = 2;
          use_tabs = false;
          format_on_save = true;
          formatter = biomeFormatter;
        };

        markdown = {
          tab_size = 2;
          use_tabs = false;
          format_on_save = false;
          formatter = biomeFormatter;
        };

        bash = {
          tab_size = 4;
          use_tabs = true;
          format_on_save = true;
          formatter = {
            command = lib.getExe pkgsUnstable.shfmt;
            args = [
              "-i"
              "0"
            ];
            stdin = true;
          };
        };

        javascript = {
          tab_size = 4;
          use_tabs = true;
          format_on_save = true;
          formatter = biomeFormatter;
        };

        typescript = {
          tab_size = 4;
          use_tabs = true;
          format_on_save = true;
          formatter = biomeFormatter;
        };

        tsx = {
          tab_size = 4;
          use_tabs = true;
          format_on_save = true;
          formatter = biomeFormatter;
        };

        json = {
          tab_size = 4;
          use_tabs = true;
          format_on_save = true;
          formatter = biomeFormatter;
        };

        html = {
          tab_size = 4;
          use_tabs = true;
          format_on_save = true;
          formatter = biomeFormatter;
        };

        css = {
          tab_size = 4;
          use_tabs = true;
          format_on_save = true;
          formatter = biomeFormatter;
        };
      };
    };
  };
}
