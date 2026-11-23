vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = { preset = "super-tab" },
			appearance = { nerd_font_variant = "mono" },
			completion = {
				accept = { auto_brackets = { enabled = true } },
				documentation = { auto_show = true, auto_show_delay_ms = 50 },
				menu = { border = "rounded" },
				ghost_text = { enabled = true },
			},
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
			},
			signature = { enabled = true },
		})
	end,
})
