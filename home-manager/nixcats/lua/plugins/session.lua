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

	map("n", "<leader>Sr", function()
		persistence.load()
	end, { desc = "Restore session (cwd)" })
	map("n", "<leader>Sl", function()
		persistence.load({ last = true })
	end, { desc = "Restore last session" })
	map("n", "<leader>Ss", function()
		persistence.select()
	end, { desc = "Select session" })
	map("n", "<leader>Sd", function()
		persistence.stop()
	end, { desc = "Don't save current session" })
end
