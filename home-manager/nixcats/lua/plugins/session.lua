local map = vim.keymap.set

vim.opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"help",
	"globals",
	"skiprtp",
	"folds",
}

local ok, persistence = pcall(require, "persistence")
if ok then
	persistence.setup({})

	map("n", "<leader>ql", function()
		persistence.load({ last = true })
	end, { desc = "Restore last session" })
	map("n", "<leader>qs", function()
		persistence.select()
	end, { desc = "Select session" })
	map("n", "<leader>qd", function()
		persistence.stop()
	end, { desc = "Don't save current session" })
end
