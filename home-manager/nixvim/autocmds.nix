{
  programs.nixvim = {
    autoCmd = [
      # Highlight yanked text briefly
      {
        event = ["TextYankPost"];
        pattern = ["*"];
        command = "silent! lua vim.highlight.on_yank()";
      }
      # Close help windows with 'q'
      {
        event = ["FileType"];
        pattern = ["help"];
        command = "nnoremap <buffer> q :close<CR>";
      }
      # Disable automatic comment continuation on new lines
      {
        event = ["BufEnter"];
        pattern = ["*"];
        command = "set formatoptions-=cro";
      }
      # Enable LSP inlay hints automatically (like Helix display-inlay-hints)
      {
        event = ["LspAttach"];
        pattern = ["*"];
        callback.__raw = ''
          function(args)
            if vim.lsp.inlay_hint then
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
          end
        '';
      }
      # Hard Tabs (width 4) for Web & Bash (matching Helix indentTab)
      {
        event = ["FileType"];
        pattern = ["javascript" "javascriptreact" "typescript" "typescriptreact" "html" "css" "json" "sh" "bash"];
        command = "setlocal noexpandtab tabstop=4 shiftwidth=4";
      }
      # 4 Spaces for Rust, Python, KDL
      {
        event = ["FileType"];
        pattern = ["rust" "python" "kdl"];
        command = "setlocal expandtab tabstop=4 shiftwidth=4";
      }
      # 2 Spaces for Nix, YAML, TOML
      {
        event = ["FileType"];
        pattern = ["nix" "yaml" "toml"];
        command = "setlocal expandtab tabstop=2 shiftwidth=2";
      }
    ];
  };
}
