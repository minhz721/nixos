local group = vim.api.nvim_create_augroup("UserAutocmds", {
  clear = true,
})

-- Highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    if vim.hl and vim.hl.on_yank then
      vim.hl.on_yank()
    elseif vim.highlight and vim.highlight.on_yank then
      vim.highlight.on_yank()
    end
  end,
})

-- Close help with q.
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "help",
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = args.buf,
      silent = true,
      desc = "Close help window",
    })
  end,
})

-- Avoid continuing comments on a new line.
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  callback = function(args)
    vim.bo[args.buf].formatoptions = vim.bo[args.buf].formatoptions:gsub("[cro]", "")
  end,
})

-- Enable inlay hints when the attached LSP supports them.
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

local function set_indent(width, expandtab)
  vim.opt_local.expandtab = expandtab
  vim.opt_local.tabstop = width
  vim.opt_local.shiftwidth = width
  vim.opt_local.softtabstop = width
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "html",
    "css",
    "json",
    "jsonc",
    "sh",
    "bash",
  },
  callback = function()
    set_indent(4, false)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "rust", "python", "kdl" },
  callback = function()
    set_indent(4, true)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "nix", "yaml", "toml", "lua" },
  callback = function()
    set_indent(2, true)
  end,
})
