{
  programs.nixvim = {
    autoCmd = [
      {
        event = [
          "BufWritePre"
        ];
        pattern = [
          "*"
        ];
        command = "silent! lua vim.lsp.buf.format({ async = false })";
      }

      {
        event = [
          "TextYankPost"
        ];
        pattern = [
          "*"
        ];
        command = "silent! lua vim.highlight.on_yank()";
      }

      {
        event = [
          "FileType"
        ];
        pattern = [
          "help"
        ];
        command = "nnoremap <buffer> q :close<CR>";
      }

      {
        event = [
          "BufEnter"
        ];
        pattern = [
          "*"
        ];
        command = "set formatoptions-=cro";
      }
    ];
  };
}
