local map = vim.keymap.set

local function setting(key, default)
	local v = nixCats("settings." .. key)
	return (type(v) == "string" and v ~= "") and v or default
end

local rust_tc = setting("rustToolchainPath", "")
local biome_cfg = setting("biomeConfigDir", vim.fn.expand("~/.config/biome"))

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
		python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
		rust = { "rustfmt" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		toml = { "taplo" },
	},
	formatters = {
		biome = {
			command = setting("biomeBin", "biome"),
			args = function(_, ctx)
				local args = { "format", "--stdin-file-path", "$FILENAME" }
				if biome_cfg ~= "" and not vim.fs.root(ctx.filename, { "biome.json", "biome.jsonc" }) then
					vim.list_extend(args, { "--config-path", biome_cfg })
				end
				return args
			end,
		},
		nixfmt = { command = setting("nixfmtBin", "nixfmt") },
		stylua = { command = setting("styluaBin", "stylua") },
		rustfmt = { command = rust_tc ~= "" and (rust_tc .. "/bin/rustfmt") or "rustfmt" },
		shfmt = {
			command = setting("shfmtBin", "shfmt"),
			prepend_args = { "-i", "0" },
		},
		taplo = { command = setting("taploBin", "taplo") },
	},
})

map({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
