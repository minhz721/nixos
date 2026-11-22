{
  config,
  pkgsUnstable,
  rustToolchain,
  ...
}:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 2000;
          lsp_format = "fallback";
        };
        formatters_by_ft = {
          javascript = [ "biome" ];
          javascriptreact = [ "biome" ];
          typescript = [ "biome" ];
          typescriptreact = [ "biome" ];
          json = [ "biome" ];
          jsonc = [ "biome" ];
          css = [ "biome" ];
          html = [ "biome" ];
          nix = [ "nixfmt" ];
          python = [ "ruff_format" ];
          rust = [ "rustfmt" ];
          sh = [ "shfmt" ];
          bash = [ "shfmt" ];
          toml = [ "taplo" ];
        };
        formatters = {
          biome = {
            command = "${pkgsUnstable.biome}/bin/biome";
            args.__raw = ''
              function(_, ctx)
                local args = { "format", "--stdin-file-path", "$FILENAME" }
                if not vim.fs.root(ctx.filename, { "biome.json", "biome.jsonc" }) then
                  vim.list_extend(args, { "--config-path", "${config.xdg.configHome}/biome" })
                end
                return args
              end
            '';
          };
          nixfmt = {
            command = "${pkgsUnstable.nixfmt}/bin/nixfmt";
          };
          rustfmt = {
            command = "${rustToolchain}/bin/rustfmt";
          };
          shfmt = {
            command = "${pkgsUnstable.shfmt}/bin/shfmt";
            prepend_args = [
              "-i"
              "0"
            ];
          };
          taplo = {
            command = "${pkgsUnstable.taplo}/bin/taplo";
          };
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>fm";
        action.__raw = ''
          function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end
        '';
        options.desc = "Format buffer";
      }
    ];
  };
}
