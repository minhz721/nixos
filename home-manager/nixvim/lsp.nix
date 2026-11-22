{
  config,
  pkgsUnstable,
  rustToolchain,
  ...
}:
let
  flakePath = "${config.home.homeDirectory}/nixos";
  hostName = config.home.username;
in
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      keymaps = {
        silent = true;
        lspBuf = {
          gd = "definition";
          gD = "declaration";
          gi = "implementation";
          gr = "references";
          K = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
      };

      servers = {
        # Rust (Fenix toolchain)
        rust_analyzer = {
          enable = true;
          package = rustToolchain;
          installCargo = false;
          installRustc = false;
          settings = {
            "rust-analyzer" = {
              check = {
                command = "clippy";
                extraArgs = [ "--all-targets" ];
              };
              cargo = {
                allFeatures = true;
                buildScripts.enable = true;
                sysrootSrc = "${rustToolchain}/lib/rustlib/src/rust/library";
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
        };

        # Nix (Flake-aware nixd + nixfmt)
        nixd = {
          enable = true;
          package = pkgsUnstable.nixd;
          settings = {
            formatting.command = [ "nixfmt" ];
            options = {
              nixos.expr = "(builtins.getFlake \"${flakePath}\").nixosConfigurations.${hostName}.options";
              home-manager.expr = "(builtins.getFlake \"${flakePath}\").nixosConfigurations.${hostName}.options.home-manager.users.type.getSubOptions []";
            };
          };
        };

        # Web / JS / TS / HTML / CSS / JSON (vtsls + biome)
        vtsls = {
          enable = true;
          package = pkgsUnstable.vtsls;
        };
        biome = {
          enable = true;
          package = pkgsUnstable.biome;
        };
        html = {
          enable = true;
          package = pkgsUnstable.vscode-langservers-extracted;
        };
        cssls = {
          enable = true;
          package = pkgsUnstable.vscode-langservers-extracted;
        };
        jsonls = {
          enable = true;
          package = pkgsUnstable.vscode-langservers-extracted;
        };
        emmet_language_server = {
          enable = true;
          package = pkgsUnstable.emmet-language-server;
          extraOptions = {
            init_options = {
              showAbbreviationSuggestions = true;
              showExpandedbreviation = "always";
              showSuggestionsAsSnippets = true;
              includeLanguages = {
                jsx = "javascriptreact";
                tsx = "typescriptreact";
              };
            };
          };
        };

        # Python (ty + ruff)
        ty = {
          enable = true;
          package = pkgsUnstable.ty;
        };
        ruff = {
          enable = true;
          package = pkgsUnstable.ruff;
        };

        # Shell & Config
        bashls = {
          enable = true;
          package = pkgsUnstable.bash-language-server;
        };
        taplo = {
          enable = true;
          package = pkgsUnstable.taplo;
        };
        yamlls.enable = true;
      };
    };
  };
}
