{ config, pkgs, ... }:

{
  programs.nixvim = {
    # https://github.io
    plugins.conform-nvim = {
      enable = true;

      settings = {
        # Array matching specific filetypes to their dedicated global CLI code formatters
        formatters_by_ft = {
          # Frontend web ecosystem handled globally via Prettier
          javascript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescript = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          html = [ "prettier" ];
          css = [ "prettier" ];
          json = [ "prettier" ];
          svelte = [ "prettier" ];     # Auto-formats Svelte reactive components layout
          markdown = [ "prettier" ];   # Formats .md files and nested code blocks safely

          # Python structural sorting and styling standardization
          python = [ "isort" "black" ]; # First sorts imports, then reformats layout colors

          # Embedded Lua scripting code standardizer
          lua = [ "stylua" ];

          # POSIX Shell and Bash automation script formatter
          bash = [ "shfmt" ];

          # Purely functional configuration syntax layout standardizer
          nix = [ "alejandra" ];

          # Database schema syntax checking engine (Ensure sqlfluff is in packages.nix)
          sql = [ "sqlfluff" ];
        };

        # Automation block triggering code format actions instantly upon file save
        format_on_save = {
          lsp_fallback = true;         # Fallback smoothly to standard LSP formatting if tool fails
          timeout_ms = 500;            # Maximum duration allowed for execution before interrupting
        };
      };
    };
  };
}
