local map = vim.keymap.set

require("snacks").setup({
	explorer = { enabled = true, replace_netrw = false },
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
	bufdelete = { enabled = true },
	rename = { enabled = true },
	gitbrowse = { enabled = true },
})

map("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Toggle file explorer" })
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
map("n", "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git browse" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete buffer" })
map({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next reference" })
map({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev reference" })
