local map = vim.keymap.set

-- File operations
map({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>write<CR>", {
	silent = true,
	desc = "Save file",
})
map({ "n", "v" }, "<leader>w", "<cmd>write<CR>", {
	silent = true,
	desc = "Write file",
})

-- Select all
map({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select all" })

-- Undo & Redo
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map({ "n", "i" }, "<C-S-z>", "<Esc><C-r>", { desc = "Redo" })
map({ "n", "i" }, "<C-S-r>", "<Esc><C-r>", { desc = "Redo" })

-- Copy / Cut / Paste
map("v", "<C-c>", '"+y', { desc = "Copy selection" })
map("v", "<C-x>", '"+d', { desc = "Cut selection" })
map("n", "<C-x>", '"+dd', { desc = "Cut current line" })
map("i", "<C-x>", '<Esc>"+ddi', { desc = "Cut current line" })
map("v", "<C-v>", '"+P', { desc = "Paste clipboard over selection" })

-- Delete without overwriting system clipboard (khi bật unnamedplus)
map({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
map({ "n", "v" }, "D", '"_D', { desc = "Delete to end of line without yanking" })
map({ "n", "v" }, "x", '"_x', { desc = "Delete character without yanking" })
map({ "n", "v" }, "c", '"_c', { desc = "Change without yanking" })
map({ "n", "v" }, "C", '"_C', { desc = "Change to end of line without yanking" })
map("x", "p", "P", { desc = "Paste over selection without overwriting yank" })

-- Duplicate line up/down
map("n", "<C-A-down>", "<cmd>t.<cr>", { desc = "Duplicate line down" })
map("n", "<C-A-up>", "<cmd>t.-1<cr>", { desc = "Duplicate line up" })
map("i", "<C-A-down>", "<Esc><cmd>t.<cr>gi", { desc = "Duplicate line down" })
map("i", "<C-A-up>", "<Esc><cmd>t.-1<cr>gi", { desc = "Duplicate line up" })
map("v", "<C-A-down>", ":t'><cr>gv", { silent = true, desc = "Duplicate selection down" })
map("v", "<C-A-up>", ":t'<-1<cr>gv", { silent = true, desc = "Duplicate selection up" })

-- Move lines & indentation
map("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true, desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true, desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move selection up" })
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Outdent selection" })

-- Buffer navigation & close all
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", {
	desc = "Next buffer",
})
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", {
	desc = "Previous buffer",
})
map("n", "<leader>ba", "<cmd>%bdelete<CR>", {
	silent = true,
	desc = "Close all open buffers",
})

-- Leader shortcuts
map("n", "<leader>/", "gcc", {
	remap = true,
	desc = "Toggle comment",
})
map("v", "<leader>/", "gc", {
	remap = true,
	desc = "Toggle comment",
})
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit Neovim" })
