{...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          # Web
          javascript = ["prettier"];
          javascriptreact = ["prettier"];
          typescript = ["prettier"];
          typescriptreact = ["prettier"];
          html = ["prettier"];
          css = ["prettier"];
          json = ["prettier"];
          svelte = ["prettier"];
          markdown = ["prettier"];

          # Python
          python = [
            "isort"
            "black"
          ];

          # Lua
          lua = ["stylua"];

          # Shell
          sh = ["shfmt"];

          bash = ["shfmt"];

          # Nix
          nix = ["alejandra"];

          # SQL
          sql = ["sqlfluff"];

          # Rust
          rust = ["rustfmt"];

          # Zig
          zig = ["zigfmt"];
        };

        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
      };
    };
  };
}
