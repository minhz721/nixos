vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		require("colorizer").setup({
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				RRGGBBAA = true,
				names = false,
				mode = "background",
				tailwind = false,
			},
		})
	end,
})
