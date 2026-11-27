{
  pkgs,
  pkgsUnstable,
  config,
  ...
}:
let
  sublLsp = pkgs.fetchFromGitHub {
    owner = "sublimelsp";
    repo = "LSP";
    rev = "main";
    hash = "sha256-1wJ428ThxHGcSVO0uz+hpINvBkHhREA5LVBR+u3cd5c=";
  };

  sublFormatter = pkgs.fetchFromGitHub {
    owner = "bitst0rm-pub";
    repo = "Formatter";
    rev = "master";
    hash = "sha256-2zCQl4acGGCIRAAGATIRSjBrxcN2bJTl9OmHQpQgyak=";
  };

  sublNix = pkgs.fetchFromGitHub {
    owner = "wmertens";
    repo = "sublime-nix";
    rev = "master";
    hash = "sha256-1JYZ3A8Dg2h2iNTBpIgtRjHyKD/7GHoHidMf9CopMQE=";
  };

  sublDracula = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "sublime";
    rev = "master";
    hash = "sha256-7veVVrLPW3T7KkkelDmgPW5kp+b12naKSKwCXBgjL1k=";
  };
in
{
  home.packages = with pkgsUnstable; [
    sublime4
    maple-mono.NF
    nerd-fonts.symbols-only
    stylua
    lua-language-server
  ];

  xdg.configFile = {
    "sublime-text/Packages/LSP" = {
      source = sublLsp;
      recursive = true;
    };
    "sublime-text/Packages/Formatter" = {
      source = sublFormatter;
      recursive = true;
    };
    "sublime-text/Packages/Nix" = {
      source = sublNix;
      recursive = true;
    };
    "sublime-text/Packages/Dracula Color Scheme" = {
      source = sublDracula;
      recursive = true;
    };

    "stylua/stylua.toml".text = ''
      indent_type = "Spaces"
      indent_width = 2
      column_width = 100
    '';

    "sublime-text/Packages/User/Preferences.sublime-settings".text = builtins.toJSON {
      theme = "Adaptive.sublime-theme";
      color_scheme = "Packages/Dracula Color Scheme/Dracula.tmTheme";
      font_face = "Maple Mono NF";
      font_size = 11;
      font_options = [
        "gray_antialias"
        "subpixel_antialias"
      ];
      tab_size = 2;
      translate_tabs_to_spaces = true;
      ensure_newline_at_eof_on_save = true;
      trim_trailing_white_space_on_save = "all";
      hardware_acceleration = "opengl";
      word_wrap = false;
    };

    "sublime-text/Packages/User/LSP.sublime-settings".text = builtins.toJSON {
      show_diagnostics_panel_on_save = 0;
      lsp_format_on_save = true;
      clients = {
        nixd = {
          enabled = true;
          command = [ "nixd" ];
          selector = "source.nix";
          settings = {
            nixd = {
              formatting = {
                command = [ "nixfmt" ];
              };
            };
          };
        };
        rust-analyzer = {
          enabled = true;
          command = [ "rust-analyzer" ];
          selector = "source.rust";
        };
        lua-language-server = {
          enabled = true;
          command = [ "lua-language-server" ];
          selector = "source.lua";
        };
        vtsls = {
          enabled = true;
          command = [
            "vtsls"
            "--stdio"
          ];
          selector = "source.ts | source.tsx | source.js | source.jsx";
        };
        ruff = {
          enabled = true;
          command = [
            "ruff"
            "server"
          ];
          selector = "source.python";
        };
        taplo = {
          enabled = true;
          command = [
            "taplo"
            "lsp"
            "stdio"
          ];
          selector = "source.toml";
        };
      };
    };

    "sublime-text/Packages/User/Formatter.sublime-settings".text = builtins.toJSON {
      debug = false;
      format_on_save = true;
      formatters = {
        biome = {
          enabled = true;
          format_on_save = true;
          syntaxes = [
            "yaml"
            "json"
            "jsonc"
            "javascript"
            "typescript"
            "markdown"
            "html"
            "css"
          ];
          interpreter_path = [ ];
          executable_path = [ "biome" ];
          args = [
            "format"
            "--stdin-file-path"
            "$file"
          ];
        };
        shfmt = {
          enabled = true;
          format_on_save = true;
          syntaxes = [
            "shellscript"
            "bash"
          ];
          executable_path = [ "shfmt" ];
          args = [
            "-i"
            "2"
          ];
        };
        stylua = {
          enabled = true;
          format_on_save = true;
          syntaxes = [ "lua" ];
          executable_path = [ "stylua" ];
          args = [
            "--config-path"
            "${config.xdg.configHome}/stylua/stylua.toml"
            "-"
          ];
        };
      };
    };
  };
}
