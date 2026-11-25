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
          ts-comments-nvim
          todo-comments-nvim
          undotree
          nvim-colorizer-lua
          flash-nvim
          fzf-lua
          trouble-nvim
          render-markdown-nvim
          rustaceanvim
          crates-nvim
          lazydev-nvim
          SchemaStore-nvim
        ];

        ide = with pkgsUnstable.vimPlugins; [
          persistence-nvim
          grug-far-nvim
        ];
      };

      lspsAndRuntimeDeps = {
        general = with pkgsUnstable; [
          # LSP servers
          nixd
          lua-language-server
          vtsls
          biome
          vscode-langservers-extracted
          emmet-language-server
          ty
          ruff
          taplo

          # Formatters / linters / CLI tools
          nixfmt
          stylua
          shfmt
          markdownlint-cli2
          statix
          deadnix
          yamllint
          wl-clipboard
          ripgrep
          fd
          fzf
          git
          lazygit
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
          ide = true;
        };
      };
    };
  };
}
