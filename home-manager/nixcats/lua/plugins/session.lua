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

	map("n", "<leader>pl", function()
		persistence.load({ last = true })
	end, { desc = "Restore last session" })
	map("n", "<leader>ps", function()
		persistence.select()
	end, { desc = "Select session" })
	map("n", "<leader>pd", function()
		persistence.stop()
	end, { desc = "Don't save current session" })
end
