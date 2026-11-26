-- Core UI plugins loaded immediately
require("plugins.bufferline")
require("plugins.lualine")
require("plugins.snacks")
require("plugins.noice")
require("plugins.which-key")
require("plugins.session")

-- 1. VeryLazy: Load non-critical keymaps and tools after UI renders
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		local lazy_plugins = {
			"flash.nvim",
			"fzf-lua",
			"trouble.nvim",
			"undotree",
			"grug-far.nvim",
			"refactoring.nvim",
			"diffview.nvim",
		}
		for _, p in ipairs(lazy_plugins) do
			pcall(vim.cmd.packadd, p)
		end

		require("plugins.flash")
		require("plugins.fzf-lua")
		require("plugins.trouble")
		require("plugins.undo-tree")
		require("plugins.refactor")
	end,
})

vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
		end)
	end,
})

-- 2. BufReadPre / BufNewFile: Load LSP, formatters, linters, Git, and navigation on file open
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		local file_plugins = {
			"gitsigns.nvim",
			"git-conflict.nvim",
			"nvim-lspconfig",
			"conform.nvim",
			"nvim-lint",
			"rainbow-delimiters.nvim",
			"nvim-ts-autotag",
			"nvim-surround",
			"ts-comments.nvim",
			"todo-comments.nvim",
			"nvim-colorizer.lua",
			"rustaceanvim",
			"crates.nvim",
			"inc-rename.nvim",
			"dropbar.nvim",
			"nvim-treesitter-context",
			"mini.ai",
			"nvim-treesitter-textobjects",
		}
		for _, p in ipairs(file_plugins) do
			pcall(vim.cmd.packadd, p)
		end

		require("lsp")
		require("linter")
		require("plugins.gitsigns")
		require("plugins.git")
		require("plugins.conform")
		require("plugins.editing")
		require("plugins.colorizer")
		require("plugins.rust")
		require("plugins.navigation")
	end,
})

-- 3. InsertEnter: Load completion engine on entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		pcall(vim.cmd.packadd, "blink.cmp")
		pcall(vim.cmd.packadd, "friendly-snippets")
		pcall(vim.cmd.packadd, "nvim-autopairs")

		require("plugins.blink-cmp")
	end,
})

-- 4. FileType: Load render-markdown only for Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	once = true,
	callback = function()
		pcall(vim.cmd.packadd, "render-markdown.nvim")
		require("plugins.render-markdown")
	end,
})
