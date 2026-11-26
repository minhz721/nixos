{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  fmt = command: arguments: { external = { inherit command arguments; }; };
  biomeConfigDir = "${config.xdg.configHome}/biome";

  biomeFmt = fmt (lib.getExe pkgsUnstable.biome) [
    "format"
    "--stdin-file-path"
    "{buffer_path}"
    "--config-path"
    biomeConfigDir
  ];
in
{
  home.packages = with pkgsUnstable; [
    gram
  ];

  # Local theme placed in ~/.config/gram/themes/
  xdg.configFile."gram/themes/vscode-dark-modern.json".source = ./vscode-dark-modern.json;

  xdg.configFile."gram/keymap.jsonc".text = builtins.toJSON [
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
    {
      context = "Terminal && text_selected";
      bindings = {
        "ctrl-c" = "terminal::Copy";
      };
    }
  ];

  xdg.configFile."gram/settings.jsonc".text = builtins.toJSON {
    restore_on_startup = "last_session";
    base_keymap = "VSCode";
    project_panel.dock = "left";

    icon_theme = {
      mode = "dark";
      light = "Gram (Default)";
      dark = "Gram (Default)";
    };

    theme = {
      mode = "dark";
      light = "VSCode Dark Modern";
      dark = "VSCode Dark Modern";
    };

    ui_font_family = "Maple Mono NF";
    ui_font_size = 14.0;
    buffer_font_family = "Maple Mono NF";
    buffer_font_size = 14.0;
    colorize_brackets = true;
    format_on_save = "on";
    tab_size = 4;
    hard_tabs = true;
    show_completions_on_input = true;

    node = {
      path = lib.getExe pkgsUnstable.nodejs;
      npm_path = lib.getExe' pkgsUnstable.nodejs "npm";
    };

    lsp = {
      nixd = {
        binary.path = lib.getExe pkgsUnstable.nixd;
        settings.formatting.command = [ (lib.getExe pkgsUnstable.nixfmt) ];
      };
      biome = {
        binary.path = lib.getExe pkgsUnstable.biome;
        settings.config_path = biomeConfigDir;
      };
      vtsls = {
        binary.path = lib.getExe pkgsUnstable.vtsls;
      };
      ruff.binary = {
        path = lib.getExe pkgsUnstable.ruff;
        arguments = [ "server" ];
      };
      ty = {
        binary = {
          path = lib.getExe pkgsUnstable.ty;
          arguments = [ "server" ];
        };
        initialization_options.experimental.useUv = "on";
      };
      rust-analyzer = {
        binary.path = lib.getExe pkgsUnstable.rust-analyzer;
        initialization_options.inlayHints = {
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

    languages =
      lib.genAttrs [ "JavaScript" "TypeScript" "TSX" "HTML" "CSS" "JSON" ] (_: {
        language_servers = [
          "vtsls"
          "biome"
          "..."
        ];
        formatter = biomeFmt;
      })
      // {
        Python = {
          hard_tabs = false;
          tab_size = 4;
          language_servers = [
            "ty"
            "ruff"
          ];
          formatter = fmt (lib.getExe pkgsUnstable.ruff) [
            "format"
            "--stdin-filename"
            "{buffer_path}"
            "-"
          ];
        };
        Rust = {
          hard_tabs = false;
          tab_size = 4;
        };
        TOML = {
          hard_tabs = false;
          tab_size = 2;
          language_servers = [ "taplo" ];
          formatter = fmt (lib.getExe pkgsUnstable.taplo) [
            "fmt"
            "-"
          ];
        };
        Nix = {
          hard_tabs = false;
          tab_size = 2;
          language_servers = [ "nixd" ];
          formatter = fmt (lib.getExe pkgsUnstable.nixfmt) [ ];
        };
        YAML = {
          hard_tabs = false;
          tab_size = 2;
          formatter = biomeFmt;
        };
        Bash.formatter = fmt (lib.getExe pkgsUnstable.shfmt) [
          "-i"
          "0"
        ];
        Lua = {
          hard_tabs = false;
          tab_size = 2;
          language_servers = [ ];
          formatter = fmt (lib.getExe pkgsUnstable.stylua) [
            "--stdin-filepath"
            "{buffer_path}"
            "-"
          ];
        };
      };
  };
}
