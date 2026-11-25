local map = vim.keymap.set

if vim.fn.has("nvim-0.11") ~= 1 then
	vim.notify("This LSP configuration requires Neovim 0.11 or newer.", vim.log.levels.ERROR)
	return
end

local group = vim.api.nvim_create_augroup("UserLspKeymaps", {
	clear = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(ev)
		local opts = {
			buffer = ev.buf,
			silent = true,
		}

		map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)
		map("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "<leader>rn", vim.lsp.buf.rename, opts)
		map("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", opts)
		map("n", "<leader>ds", "<cmd>FzfLua lsp_document_symbols<CR>", opts)
		map("n", "<leader>ws", "<cmd>FzfLua lsp_workspace_symbols<CR>", opts)
		map("n", "<leader>d", vim.diagnostic.open_float, opts)

		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
	end,
})

local flake_dir = vim.fn.expand("~/nixos")
local nixos_expr = string.format('(builtins.getFlake "%s").nixosConfigurations.leomin.options', flake_dir)
local hm_expr = string.format(
	'(builtins.getFlake "%s").nixosConfigurations.leomin.options.home-manager.users.type.getSubOptions []',
	flake_dir
)

local servers = {
	nixd = {
		cmd = { "nixd" },
		filetypes = { "nix" },
		root_markers = { "flake.nix", ".git" },
		settings = {
			nixd = {
				nixpkgs = {
					expr = string.format('import (builtins.getFlake "%s").inputs.nixpkgs-unstable { }', flake_dir),
				},
				formatting = {
					command = { "nixfmt" },
				},
				options = {
					nixos = {
						expr = nixos_expr,
					},
					home_manager = {
						expr = hm_expr,
					},
				},
			},
		},
	},

	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = {
			".luarc.json",
			".luarc.jsonc",
			".stylua.toml",
			"stylua.toml",
			".git",
		},
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = {
					globals = { "nixCats", "Snacks" },
				},
				workspace = {
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
				hint = {
					enable = true,
				},
			},
		},
	},

	vtsls = {
		cmd = { "vtsls", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		root_markers = {
			"tsconfig.json",
			"jsconfig.json",
			"package.json",
			".git",
		},
	},

	biome = {
		cmd = { "biome", "lsp-proxy" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"json",
			"jsonc",
			"css",
			"yaml",
		},
		root_markers = {
			"biome.json",
			"biome.jsonc",
		},
	},

	html = {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
	},

	cssls = {
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
	},

	jsonls = {
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
	},

	emmet_language_server = {
		cmd = { "emmet-language-server", "--stdio" },
		filetypes = {
			"html",
			"css",
			"javascriptreact",
			"typescriptreact",
		},
		init_options = {
			showAbbreviationSuggestions = true,
			showExpandedAbbreviation = "always",
			showSuggestionsAsSnippets = true,
			includeLanguages = {
				jsx = "javascriptreact",
				tsx = "typescriptreact",
			},
		},
	},

	ty = {
		cmd = { "ty", "server" },
		filetypes = { "python" },
		root_markers = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			".git",
		},
	},

	ruff = {
		cmd = { "ruff", "server" },
		filetypes = { "python" },
		root_markers = {
			"pyproject.toml",
			"ruff.toml",
			".ruff.toml",
			".git",
		},
	},

	taplo = {
		cmd = { "taplo", "lsp", "stdio" },
		filetypes = { "toml" },
	},
}

for name, config in pairs(servers) do
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end
