{
  inputs,
  pkgsUnstable,
  ...
}:
let
  pick =
    names:
    builtins.filter (p: p != null) (
      map (
        n:
        pkgsUnstable.vimPlugins.${n} or (builtins.trace "nixcats: vimPlugins.${n} not found, skipped" null)
      ) names
    );

  grammars = [
    "bash"
    "css"
    "diff"
    "git_config"
    "gitcommit"
    "gitignore"
    "html"
    "javascript"
    "jsdoc"
    "json"
    "jsonc"
    "kdl"
    "lua"
    "luadoc"
    "markdown"
    "markdown_inline"
    "nix"
    "python"
    "query"
    "rust"
    "toml"
    "tsx"
    "typescript"
    "vim"
    "vimdoc"
    "yaml"
  ];

  treesitterWithGrammars = pkgsUnstable.vimPlugins.nvim-treesitter.withPlugins (
    p: builtins.filter (g: g != null) (map (n: p.${n} or null) grammars)
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
      # Core UI plugins loaded immediately at startup
      startupPlugins = {
        general = [
          treesitterWithGrammars
        ]
        ++ pick [
          "nvim-web-devicons"
          "vscode-nvim"
          "lualine-nvim"
          "bufferline-nvim"
          "which-key-nvim"
          "snacks-nvim"
          "noice-nvim"
          "nui-nvim"
        ];

        ide = pick [
          "persistence-nvim"
        ];
      };

      # Lazy-loaded plugins (BufRead, InsertEnter, VeryLazy, FileType)
      optionalPlugins = {
        general = pick [
          # BufRead / BufNewFile
          "gitsigns-nvim"
          "nvim-lspconfig"
          "conform-nvim"
          "nvim-lint"
          "rainbow-delimiters-nvim"
          "nvim-ts-autotag"
          "nvim-surround"
          "ts-comments-nvim"
          "todo-comments-nvim"
          "nvim-colorizer-lua"

          # InsertEnter
          "blink-cmp"
          "friendly-snippets"
          "nvim-autopairs"

          # VeryLazy / On-demand
          "flash-nvim"
          "fzf-lua"
          "trouble-nvim"
          "undotree"
          "render-markdown-nvim"
        ];

        ide = pick [
          "rustaceanvim"
          "crates-nvim"
          "diffview-nvim"
          "grug-far-nvim"
          "inc-rename.nvim"
        ];

        extras = pick [
          "git-conflict-nvim"
          "refactoring-nvim"
          "dropbar-nvim"
          "nvim-treesitter-context"
          "mini-ai"
          "nvim-treesitter-textobjects"
        ];
      };

      lspsAndRuntimeDeps = {
        general = with pkgsUnstable; [
          # LSP servers
          nixd
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
          curl
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
          extras = true;
        };
      };
    };
  };
}
