local function close_buffer(bufnum)
	if not vim.api.nvim_buf_is_valid(bufnum) then
		return
	end
	vim.schedule(function()
		if not vim.api.nvim_buf_is_valid(bufnum) then
			return
		end
		local ok, snacks = pcall(require, "snacks")
		if ok then
			snacks.bufdelete(bufnum)
		else
			pcall(vim.cmd, "bdelete " .. bufnum)
		end
	end)
end

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		show_buffer_close_icons = true,
		show_close_icon = false,
		always_show_bufferline = true,
		close_command = close_buffer,
		right_mouse_command = close_buffer,
		offsets = {
			{ filetype = "snacks_layout_box" },
		},
	},
})
