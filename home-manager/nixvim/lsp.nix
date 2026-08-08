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
        # Nix
        nil_ls = {
          enable = true;
          settings = {
            formatting.command = ["alejandra"];
          };
        };

        # Lua
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics.globals = ["vim"];
              workspace.checkThirdParty = false;
              telemetry.enable = false;
              format.enable = false;
            };
          };
        };

        # Web
        ts_ls.enable = true;
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        tailwindcss.enable = true;

        # Python
        pyright.enable = true;

        # Shell
        bashls.enable = true;

        # Docker
        dockerls.enable = true;
        docker_compose_language_service.enable = true;

        # Rust
        rust_analyzer = {
          enable = true;

          installCargo = false;
          installRustc = false;
        };

        # Markdown
        marksman.enable = true;

        # SQL
        sqls.enable = true;

        # Frontend
        svelte.enable = true;

        # zig
        zls.enable = true;
      };
    };
  };
}
