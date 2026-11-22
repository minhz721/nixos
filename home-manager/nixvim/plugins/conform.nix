{
  pkgs,
  pkgsUnstable,
  rustToolchain,
  ...
}:
let
  biomeConfigDir = pkgs.writeTextDir "biome.json" ''
    {
      "$schema": "https://biomejs.dev/schemas/2.0.0/schema.json",
      "formatter": {
        "enabled": true,
        "indentStyle": "tab",
        "indentWidth": 4
      }
    }
  '';
in
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
            args = [
              "format"
              "--stdin-file-path"
              "$FILENAME"
              "--config-path"
              biomeConfigDir
            ];
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
