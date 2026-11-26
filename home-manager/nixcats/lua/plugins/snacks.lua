local map = vim.keymap.set

require("snacks").setup({
	explorer = { enabled = true, replace_netrw = true },
	input = { enabled = true },
	indent = { enabled = true, char = "│", animate = { enabled = false } },
	scroll = {
		enabled = true,
		animate = { duration = { step = 10, total = 100 }, easing = "linear" },
	},
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	words = { enabled = true },
	lazygit = { enabled = true },
})

map("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Toggle file explorer" })
map({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next reference" })
map({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev reference" })

map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
map("n", "<leader>gl", function()
	Snacks.lazygit.log()
end, { desc = "Lazygit log" })
map("n", "<leader>gf", function()
	Snacks.lazygit.log_file()
end, { desc = "Lazygit file history" })
map({ "n", "x" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Open in browser" })

map("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { desc = "Rename file (LSP)" })
