local map = vim.keymap.set

require("nvim-ts-autotag").setup({})
require("nvim-surround").setup({})

local ok_tsc, tsc = pcall(require, "ts-comments")
if ok_tsc then
	tsc.setup({})
end

local ok_ai, ai = pcall(require, "mini.ai")
if ok_ai then
	ai.setup({
		n_lines = 500,
		custom_textobjects = {
			f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
			a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
		},
	})
end

require("todo-comments").setup({
	highlight = { multiline = true },
	search = { command = "rg" },
})

vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("nvim-autopairs").setup({ check_ts = true })
	end,
})

map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next TODO comment" })
map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous TODO comment" })
