vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					buildScripts = {
						enable = false,
					},
				},
				checkOnSave = false,
				inlayHints = {
					maxLength = nil,
					lifetimeElisionHints = {
						enable = "skip_trivial",
						useParameterNames = true,
					},
					closureReturnTypeHints = {
						enable = "always",
					},
				},
			},
		},
	},
}

local rust_group = vim.api.nvim_create_augroup("nixcats_rust_config", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = rust_group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or client.name ~= "rust-analyzer" then
			return
		end

		local fname = vim.api.nvim_buf_get_name(args.buf)
		if fname == "" then
			return
		end

		local has_cargo = vim.fs.find("Cargo.toml", {
			path = vim.fs.dirname(fname),
			upward = true,
		})[1] ~= nil

		if not has_cargo then
			client:stop()
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = rust_group,
	pattern = "toml",
	callback = function(args)
		if vim.fn.expand("%:t") == "Cargo.toml" then
			local crates = require("crates")
			crates.setup({
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			})
			vim.keymap.set("n", "<leader>cu", crates.update_crate, { buffer = args.buf, desc = "Update crate" })
			vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, { buffer = args.buf, desc = "Upgrade crate" })
			vim.keymap.set(
				"n",
				"<leader>ca",
				crates.update_all_crates,
				{ buffer = args.buf, desc = "Update all crates" }
			)
			vim.keymap.set("n", "<leader>cH", crates.open_homepage, { buffer = args.buf, desc = "Crate homepage" })
			vim.keymap.set("n", "<leader>cD", crates.open_documentation, { buffer = args.buf, desc = "Crate docs" })
		end
	end,
})
