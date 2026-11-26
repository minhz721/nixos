local map = vim.keymap.set

map("n", "<leader>gv", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: open" })
map("n", "<leader>gV", "<cmd>DiffviewClose<CR>", { desc = "Diffview: close" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diffview: file history" })

local ok, conflict = pcall(require, "git-conflict")
if ok then
	conflict.setup({ default_mappings = false })

	map("n", "<leader>gco", "<cmd>GitConflictChooseOurs<CR>", { desc = "Conflict: choose ours" })
	map("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<CR>", { desc = "Conflict: choose theirs" })
	map("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<CR>", { desc = "Conflict: choose both" })
	map("n", "<leader>gc0", "<cmd>GitConflictChooseNone<CR>", { desc = "Conflict: choose none" })
	map("n", "]x", "<cmd>GitConflictNextConflict<CR>", { desc = "Next conflict" })
	map("n", "[x", "<cmd>GitConflictPrevConflict<CR>", { desc = "Previous conflict" })
	map("n", "<leader>gcl", "<cmd>GitConflictListQf<CR>", { desc = "Conflicts to quickfix" })
end
