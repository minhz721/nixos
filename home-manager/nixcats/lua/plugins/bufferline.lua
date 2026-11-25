require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		show_buffer_close_icons = true,
		show_close_icon = false,
		always_show_bufferline = true,
		close_command = function(bufnum)
			if vim.api.nvim_buf_is_valid(bufnum) then
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(bufnum) then
						Snacks.bufdelete(bufnum)
					end
				end)
			end
		end,
		right_mouse_command = function(bufnum)
			if vim.api.nvim_buf_is_valid(bufnum) then
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(bufnum) then
						Snacks.bufdelete(bufnum)
					end
				end)
			end
		end,
	},
})
