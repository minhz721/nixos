local has_lazydev = pcall(require, "lazydev")

local sources = {
	default = { "lsp", "snippets", "path", "buffer" },
}
if has_lazydev then
	sources.per_filetype = { lua = { inherit_defaults = true, "lazydev" } }
	sources.providers = {
		lazydev = {
			name = "LazyDev",
			module = "lazydev.integrations.blink",
			score_offset = 100,
		},
	}
end

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = { nerd_font_variant = "mono" },
	completion = {
		accept = { auto_brackets = { enabled = true } },
		documentation = { auto_show = true, auto_show_delay_ms = 50 },
		menu = { border = "rounded" },
		ghost_text = { enabled = true },
	},
	sources = sources,
	signature = { enabled = true },
})
