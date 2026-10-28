{...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          # Web / JavaScript & TypeScript (Powered by Bun)
          javascript = ["bun_format"];
          javascriptreact = ["bun_format"];
          typescript = ["bun_format"];
          typescriptreact = ["bun_format"];
          
          # Web / Document Formats (Fallback to Prettier)
          html = ["prettier"];
          css = ["prettier"];
          json = ["prettier"];
          svelte = ["prettier"];
          markdown = ["prettier"];

          # Python (Optimized via Ruff through UV backend)
          python = ["ruff_format"];

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

        # Custom formatters execution strategies
        formatters = {
          ruff_format = {
            command = "uvx";
            args = [ "ruff" "format" "--stdin-filename" "$FILENAME" "-" ];
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
