local map = vim.keymap.set
local loaded = false

local function run_fzf(cmd)
	return function()
		if not loaded then
			loaded = true
			require("fzf-lua").setup({
				winopts = { height = 0.85, width = 0.80, border = "rounded" },
				previewer = { builtin = { syntax = true } },
			})
		end
		vim.cmd("FzfLua " .. cmd)
	end
end

map("n", "<leader>ff", run_fzf("files"), { desc = "Find files" })
map("n", "<leader>fg", run_fzf("live_grep"), { desc = "Search project" })
map("n", "<leader>fc", run_fzf("grep_curbuf"), { desc = "Search current file" })
map("n", "<leader>fb", run_fzf("buffers"), { desc = "Find buffers" })
map("n", "<leader>fh", run_fzf("helptags"), { desc = "Search help tags" })
map("n", "<leader>fr", run_fzf("oldfiles"), { desc = "Recent files" })
map("n", "<leader>fw", run_fzf("grep_cword"), { desc = "Search current word" })
map("n", "<leader>fk", run_fzf("keymaps"), { desc = "Search keymaps" })
