local map = vim.keymap.set
local loaded = false

local function fzf(cmd)
	return function()
		if not loaded then
			loaded = true
			require("fzf-lua").setup({
				winopts = { height = 0.85, width = 0.80, border = "rounded" },
				previewer = { builtin = { syntax = true } },
			})
		end
		if cmd == "TodoFzfLua" then
			pcall(vim.cmd.packadd, "todo-comments.nvim")
			pcall(require("todo-comments").setup, {
				highlight = { multiline = true },
				search = { command = "rg" },
			})
		end
		vim.cmd(cmd)
	end
end

-- Files / text
map("n", "<leader>ff", fzf("FzfLua files"), { desc = "Find files" })
map("n", "<leader>fg", fzf("FzfLua live_grep"), { desc = "Search project" })
map("n", "<leader>fc", fzf("FzfLua grep_curbuf"), { desc = "Search current file" })
map("n", "<leader>fb", fzf("FzfLua buffers"), { desc = "Find buffers" })
map("n", "<leader>fh", fzf("FzfLua helptags"), { desc = "Search help tags" })
map("n", "<leader>fr", fzf("FzfLua oldfiles"), { desc = "Recent files" })
map("n", "<leader>fw", fzf("FzfLua grep_cword"), { desc = "Search current word" })
map("n", "<leader>fk", fzf("FzfLua keymaps"), { desc = "Search keymaps" })
map("n", "<leader>fR", fzf("FzfLua resume"), { desc = "Resume last search" })

-- LSP / diagnostics / TODO
map("n", "<leader>fs", fzf("FzfLua lsp_document_symbols"), { desc = "Document symbols" })
map("n", "<leader>fS", fzf("FzfLua lsp_live_workspace_symbols"), { desc = "Workspace symbols" })
map("n", "<leader>fd", fzf("FzfLua diagnostics_document"), { desc = "Document diagnostics" })
map("n", "<leader>fD", fzf("FzfLua diagnostics_workspace"), { desc = "Workspace diagnostics" })
map("n", "<leader>ft", fzf("TodoFzfLua"), { desc = "TODO comments" })
