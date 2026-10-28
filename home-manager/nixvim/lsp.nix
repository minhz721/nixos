{...}: {
  programs.nixvim = {
    filetype.pattern = {
      "docker-compose%.yml" = "yaml.docker-compose";
      "docker-compose%.yaml" = "yaml.docker-compose";
      "compose%.yml" = "yaml.docker-compose";
      "compose%.yaml" = "yaml.docker-compose";
    };

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
        # Nix Configuration
        nil_ls = {
          enable = true;
          settings = {
            formatting.command = ["alejandra"];
          };
        };

        # Lua Development
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics.globals = ["vim"];
              workspace.checkThirdParty = false;
              telemetry.enable = false;
              format.enable = false; # Let conform-nvim handle formatting
            };
          };
        };

        # Web & JavaScript Ecosystem (Optimized for Bun via vtsls)
        vtsls = {
          enable = true;
        };
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        tailwindcss.enable = true;

        # Python Development (Configured to resolve uv local virtual environments)
        pyright = {
          enable = true;
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true;
                useLibraryCodeForTypes = true;
                diagnosticMode = "openFilesOnly";
              };
            };
          };
        };

        # Shell Scripting
        bashls.enable = true;

        # Docker Containment
        dockerls.enable = true;
        docker_compose_language_service.enable = true;

        # Rust Systems Programming (Utilizes external system toolchain)
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };

        # Document Formats
        marksman.enable = true;

        # Database Languages
        sqls.enable = true;

        # Frontend Frameworks
        svelte.enable = true;

        # Low-level Languages
        zls.enable = true;
      };
    };
  };
}
