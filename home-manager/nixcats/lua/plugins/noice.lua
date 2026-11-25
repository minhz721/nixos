require("noice").setup({
	lsp = {
		progress = {
			enabled = false,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
	},
	popupmenu = {
		enabled = true,
		backend = "nui",
	},
	messages = {
		enabled = true,
		view = "mini",
		view_warn = "mini",
		view_error = "notify",
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = { "wmsg", "emsg" },
				find = "FetchWorkspaceError",
			},
			opts = { skip = true },
		},
	},
	presets = {
		bottom_search = true,
		command_palette = false,
		long_message_to_split = true,
		lsp_doc_border = true,
	},
})
