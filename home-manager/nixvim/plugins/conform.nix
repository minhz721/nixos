{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          javascript = [
            "prettier"
          ];

          javascriptreact = [
            "prettier"
          ];

          typescript = [
            "prettier"
          ];

          typescriptreact = [
            "prettier"
          ];

          html = [
            "prettier"
          ];

          css = [
            "prettier"
          ];

          json = [
            "prettier"
          ];

          python = [
            "black"
            "isort"
          ];

          lua = [
            "stylua"
          ];

          bash = [
            "shfmt"
          ];

          nix = [
            "alejandra"
          ];
        };

        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
      };
    };
  };
}