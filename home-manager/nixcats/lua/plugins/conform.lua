local map = vim.keymap.set
local loaded = false

local function setup_conform()
	if loaded then
		return
	end
	loaded = true

	local rust_tc = nixCats("settings.rustToolchainPath") or ""
	local biome_cfg = nixCats("settings.biomeConfigDir") or vim.fn.expand("~/.config/biome")

	require("conform").setup({
		format_on_save = {
			timeout_ms = 2000,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			javascript = { "biome" },
			javascriptreact = { "biome" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			json = { "biome" },
			jsonc = { "biome" },
			css = { "biome" },
			html = { "biome" },
			yaml = { "biome" },
			nix = { "nixfmt" },
			lua = { "stylua" },
			python = { "ruff_format" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			toml = { "taplo" },
		},
		formatters = {
			biome = {
				command = nixCats("settings.biomeBin") or "biome",
				args = function(_, ctx)
					local args = { "format", "--stdin-file-path", "$FILENAME" }
					if biome_cfg ~= "" and not vim.fs.root(ctx.filename, { "biome.json", "biome.jsonc" }) then
						vim.list_extend(args, { "--config-path", biome_cfg })
					end
					return args
				end,
			},
			nixfmt = { command = nixCats("settings.nixfmtBin") or "nixfmt" },
			stylua = { command = nixCats("settings.styluaBin") or "stylua" },
			rustfmt = { command = rust_tc ~= "" and (rust_tc .. "/bin/rustfmt") or "rustfmt" },
			shfmt = {
				command = nixCats("settings.shfmtBin") or "shfmt",
				prepend_args = { "-i", "0" },
			},
			taplo = { command = nixCats("settings.taploBin") or "taplo" },
		},
	})
end

vim.api.nvim_create_autocmd("BufWritePre", {
	once = true,
	callback = setup_conform,
})

map({ "n", "v" }, "<leader>fm", function()
	setup_conform()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
