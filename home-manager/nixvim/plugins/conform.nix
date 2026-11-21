{
  config,
  pkgsUnstable,
  ...
}: let
  biomeConfigDir = "${config.xdg.configHome}/biome";
in {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          # Web & Markup (Biome v2 handles JS/TS/JSX/TSX/JSON/CSS/HTML/YAML/MD)
          javascript = ["biome"];
          javascriptreact = ["biome"];
          typescript = ["biome"];
          typescriptreact = ["biome"];
          json = ["biome"];
          jsonc = ["biome"];
          css = ["biome"];
          html = ["biome"];
          yaml = ["biome"];
          markdown = ["biome"];

          # Python, Shell & Systems
          python = ["ruff_format"];
          sh = ["shfmt"];
          bash = ["shfmt"];
          nix = ["nixfmt"];
          rust = ["rustfmt"];
          toml = ["taplo"];
          kdl = ["kdlfmt"];
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
          shfmt = {
            prepend_args = ["-i" "0"];
          };
        };

        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
      };
    };
  };
}
