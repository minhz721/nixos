local map = vim.keymap.set

require("noice").setup({
	notify = { enabled = true, view = "mini" },
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
		signature = { enabled = false },
	},
	presets = {
		bottom_search = false,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = true,
		lsp_doc_border = true,
	},
})

map("n", "<leader>nd", "<cmd>Noice dismiss<CR>", { desc = "Dismiss Noice messages" })
map("n", "<leader>nl", "<cmd>Noice last<CR>", { desc = "Last Noice message" })
map("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "Noice history" })
