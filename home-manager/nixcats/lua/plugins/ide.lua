local map = vim.keymap.set

-- Session management (persistence.nvim)
require("persistence").setup({
	dir = vim.fn.stdpath("state") .. "/sessions/",
	need = 1,
	branch = true,
})

map("n", "<leader>Ss", function()
	require("persistence").load()
end, { desc = "Restore session (cwd)" })

map("n", "<leader>Sl", function()
	require("persistence").load({ last = true })
end, { desc = "Restore last session" })

map("n", "<leader>Sd", function()
	require("persistence").stop()
end, { desc = "Don't save current session" })

-- Search & Replace across project
local grug_setup_done = false
local function ensure_grug_far()
	local grug = require("grug-far")
	if not grug_setup_done then
		grug.setup({ transient = true })
		grug_setup_done = true
	end
	return grug
end

map("n", "<leader>rr", function()
	ensure_grug_far().open({ transient = true })
end, { desc = "Search & replace in project" })

map("n", "<leader>rw", function()
	ensure_grug_far().open({
		transient = true,
		prefills = { search = vim.fn.expand("<cword>") },
	})
end, { desc = "Search & replace current word" })

map("v", "<leader>rs", function()
	ensure_grug_far().with_visual_selection({ transient = true })
end, { desc = "Search & replace selection" })
