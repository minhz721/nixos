{ config, pkgs, ... }:

{
  programs.nixvim = {
    filetype = {
      pattern = {
        "docker-compose%.yml" = "yaml.docker-compose";
        "docker-compose%.yaml" = "yaml.docker-compose";
        "compose%.yml" = "yaml.docker-compose";
        "compose%.yaml" = "yaml.docker-compose";
      };
    };

    plugins.lsp = {
      enable = true;

      # Standard keymaps initialized dynamically upon server attachment
      keymaps = {
        silent = true;
        lspBuf = {
          "gd" = "definition";         # Jump to source definition
          "gD" = "declaration";        # Jump to declaration
          "gi" = "implementation";     # Jump to implementation
          "K"  = "hover";              # Trigger documentation lookup popup
        };
      };

      servers = {
        # Svelte frontend component syntax and reactive diagnostics engine
        svelte = {
          enable = true;
        };

        # Infrastructure orchestration and docker schema validator
        docker_compose_language_service = {
          enable = true;
        };

        # Tailwind CSS intelligent design utility classes analyzer
        tailwindcss = {
          enable = true;
        };

        # Rust systems development language server protocol engine
        rust_analyzer = {
          enable = true;
          installCargo = false;        # Rely on local project nix-shell Cargo binary
          installRustc = false;        # Rely on local project nix-shell Rustc compiler
        };

        # Relational database structured query analyzer
        sqls = {
          enable = true;
        };

        # JavaScript and TypeScript code safety analyzer
        ts_ls = {
          enable = true;
        };

        # HyperText Markup Language structures formatting validation
        html = {
          enable = true;
        };

        # Cascading Style Sheets rules layout optimizer
        cssls = {
          enable = true;
        };

        # Python structural semantics validation engine
        pyright = {
          enable = true;
        };

        # POSIX Shell and Bash scripting validation engine
        bashls = {
          enable = true;
        };

        # Isolated environment setup blueprint diagnostic compiler
        dockerls = {
          enable = true;
        };

        # Purely functional configuration language layout paired with Alejandra
        nil_ls = {
          enable = true;
          settings = {
            formatting = {
              command = [ "alejandra" ];
            };
          };
        };

        # Scripting automation platform context specifically tuned for Neovim config
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = {
                globals = [ "vim" ];   # Suppress warnings on global 'vim' keyword namespace
              };
              workspace = {
                checkThirdParty = false;
              };
              telemetry = {
                enable = false;
              };
              format = {
                enable = false;
              };
            };
          };
        };
      };
    };
  };
}
