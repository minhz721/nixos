vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.cursorline = true
opt.termguicolors = true
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 8
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.updatetime = 250
opt.completeopt = { "menu", "menuone", "noselect" }
opt.mouse = "a"
opt.wrap = false
opt.signcolumn = "yes"
opt.conceallevel = 0
opt.pumheight = 15
opt.swapfile = false

-- Treesitter folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldenable = true

-- Theme VSCode
require("vscode").setup({
  style = "dark",
  transparent = false,
})
vim.cmd.colorscheme("vscode")
