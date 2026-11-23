{
  inputs,
  pkgsUnstable,
  ...
}:
let
  treesitterWithGrammars = pkgsUnstable.vimPlugins.nvim-treesitter.withPlugins (
    grammars: with grammars; [
      # Core & Nix
      lua
      vim
      vimdoc
      nix

      # Web
      javascript
      typescript
      tsx
      html
      css
      json

      # Shell & Config
      bash
      yaml
      toml

      # Docs & Languages
      markdown
      markdown_inline
      python
      rust
    ]
  );
in
{
  imports = [
    inputs.nixCats.homeModule
  ];

  config.nixCats = {
    enable = true;
    packageNames = [ "nvim" ];

    # Neovim config root: init.lua at the root, modules under lua/.
    luaPath = ./.;

    categoryDefinitions.replace = _: {
      startupPlugins = {
        general = with pkgsUnstable.vimPlugins; [
          nvim-web-devicons
          vscode-nvim
          lualine-nvim
          bufferline-nvim
          which-key-nvim
          gitsigns-nvim
          snacks-nvim
          noice-nvim
          nui-nvim
          nvim-lspconfig
          blink-cmp
          friendly-snippets
          conform-nvim
          nvim-lint
          treesitterWithGrammars
          rainbow-delimiters-nvim
          nvim-autopairs
          nvim-ts-autotag
          nvim-surround
          comment-nvim
          todo-comments-nvim
          undotree
          nvim-colorizer-lua
          flash-nvim
          fzf-lua
          trouble-nvim
          render-markdown-nvim
        ];
      };

      # Keep external tools in the NixCats package so LSP/formatters/linters
      # are available on Neovim's PATH without per-tool nixCats settings.
      lspsAndRuntimeDeps = {
        general = with pkgsUnstable; [
          # LSP servers
          rust-analyzer
          nixd
          lua-language-server
          vtsls
          biome
          vscode-langservers-extracted
          emmet-language-server
          ty
          ruff
          bash-language-server
          taplo

          # Formatters / linters / supporting tools
          nixfmt
          shellcheck
        ];
      };
    };

    packageDefinitions.replace = {
      nvim = { ... }: {
        settings = {
          aliases = [ "vim" ];
        };

        categories = {
          general = true;
        };
      };
    };
  };
}
