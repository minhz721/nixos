if vim.loader then
	vim.loader.enable()
end

require("options")
require("keymaps")
require("autocmds")
require("plugins")

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		require("lsp")
		require("linter")
	end,
})
