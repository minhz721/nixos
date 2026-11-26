if vim.fn.has("nvim-0.12") == 1 and pcall(vim.cmd, "packadd nvim.undotree") then
	vim.keymap.set("n", "<leader>u", "<cmd>Undotree<CR>", { desc = "Toggle undo tree" })
else
	vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle undo tree" })
end
