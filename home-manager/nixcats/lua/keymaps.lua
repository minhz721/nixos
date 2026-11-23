local map = vim.keymap.set

-- File operations
map({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>write<CR>", {
	silent = true,
	desc = "Save file",
})
map("n", "<leader>w", "<cmd>write<CR>", {
	silent = true,
	desc = "Write file",
})

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })

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
map("v", "<C-S-v>", '"+p', { desc = "Paste clipboard" })

-- Duplicate line up/down
map("n", "<C-A-down>", "yyp", { desc = "Duplicate line down" })
map("n", "<C-A-up>", "yyP", { desc = "Duplicate line up" })
map("i", "<C-A-down>", "<Esc>yypi", { desc = "Duplicate line down" })
map("i", "<C-A-up>", "<Esc>yyPi", { desc = "Duplicate line up" })
map("v", "<C-A-down>", "y'>p", { desc = "Duplicate selection down" })
map("v", "<C-A-up>", "y'<P", { desc = "Duplicate selection up" })

-- Move lines & indentation
map("n", "<A-j>", "<cmd>move .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>move .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Outdent selection" })

-- Buffer & Window navigation
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", {
	desc = "Next buffer",
})
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", {
	desc = "Previous buffer",
})
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Leader shortcuts
map("n", "<leader>/", "gcc", {
	remap = true,
	desc = "Toggle comment",
})
map("v", "<leader>/", "gc", {
	remap = true,
	desc = "Toggle comment",
})
map("n", "<leader>ch", "<cmd>nohlsearch<CR>", {
	desc = "Clear search highlight",
})
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit Neovim" })
