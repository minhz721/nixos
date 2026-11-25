vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("nvim-autopairs").setup({ check_ts = true })
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		require("nvim-ts-autotag").setup({})
		require("nvim-surround").setup({})
		require("ts-comments").setup({})
		require("todo-comments").setup({
			highlight = { multiline = true },
			search = { command = "rg" },
		})
	end,
})
