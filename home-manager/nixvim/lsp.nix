{ ... }: {
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      # FIXED: Disable automatic signatureHelp requests on client capability initialization
      onAttach = ''
        if client.server_capabilities then
          client.server_capabilities.signatureHelpProvider = false
        end
      '';

      # Core standard LSP shortcuts (Manual diagnostics trigger)
      keymaps = {
        silent = true;
        lspBuf = {
          "gd" = "definition";         # Go to definition
          "gD" = "declaration";        # Go to declaration
          "gi" = "implementation";     # Go to implementation
          "K"  = "hover";              # Show hover documentation popup
        };
      };

      servers = {
        ts_ls = {
          enable = true;
        };

        html = {
          enable = true;
        };

        cssls = {
          enable = true;
        };

        pyright = {
          enable = true;
        };

        bashls = {
          enable = true;
        };

        dockerls = {
          enable = true;
        };

        nil_ls = {
          enable = true;

          settings = {
            formatting = {
              command = [
                "alejandra"
              ];
            };
          };
        };

        lua_ls = {
          enable = true;

          settings = {
            Lua = {
              diagnostics = {
                globals = [
                  "vim"
                ];
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
