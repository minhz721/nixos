local map = vim.keymap.set
local loaded = false

local function flash_setup()
	if not loaded then
		loaded = true
		require("flash").setup({
			labels = "asdfghjklqwertyuiopzxcvbnm",
			search = { multi_window = true, forward = true, wrap = true },
		})
	end
end

map({ "n", "x", "o" }, "s", function()
	flash_setup()
	require("flash").jump()
end, { desc = "Flash jump navigation", silent = true })

map({ "n", "o" }, "S", function()
	flash_setup()
	require("flash").treesitter()
end, { desc = "Flash Treesitter scope selection", silent = true })
