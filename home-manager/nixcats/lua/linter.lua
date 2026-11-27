local lint = require("lint")

lint.linters_by_ft = {
	markdown = { "markdownlint-cli2" },
	nix = { "statix", "deadnix" },
}

local group = vim.api.nvim_create_augroup("NvimLint", {
	clear = true,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
	group = group,
	callback = function(args)
		if vim.bo[args.buf].buftype == "" then
			lint.try_lint()
		end
	end,
})
