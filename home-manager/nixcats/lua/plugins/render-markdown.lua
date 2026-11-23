vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	once = true,
	callback = function()
		require("render-markdown").setup({
			file_types = { "markdown" },
			heading = {
				sign = true,
				icons = { "   ", "   ", "   ", "   ", "   ", "   " },
			},
			code = {
				sign = true,
				style = "full",
				width = "block",
				border = "thin",
			},
			checkbox = {
				enabled = true,
				unchecked = { icon = "   " },
				checked = { icon = "   " },
			},
			bullet = {
				enabled = true,
				icons = { "●", "○", "◆", "◇" },
			},
		})
	end,
})
