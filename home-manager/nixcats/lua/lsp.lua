local map = vim.keymap.set

-- This configuration uses the native vim.lsp.config()/vim.lsp.enable()
-- API introduced in Neovim 0.11.
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

		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "<leader>rn", vim.lsp.buf.rename, opts)
		map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		map("n", "<leader>d", vim.diagnostic.open_float, opts)

		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
	end,
})

local servers = {
	rust_analyzer = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_markers = { "Cargo.toml", "rust-project.json", ".git" },
		settings = {
			["rust-analyzer"] = {
				check = {
					command = "check",
				},
				cargo = {
					allFeatures = true,
					buildScripts = { enable = true },
				},
				procMacro = { enable = true },
				inlayHints = {
					bindingModeHints = { enable = true },
					closingBraceHints = { enable = true },
					closureReturnTypeHints = { enable = "with_block" },
					discriminantHints = { enable = "fieldless" },
					lifetimeElisionHints = { enable = "skip_trivial" },
					typeHints = { enable = true },
				},
			},
		},
	},

	nixd = {
		cmd = { "nixd" },
		filetypes = { "nix" },
		root_markers = { "flake.nix", ".git" },
		settings = {
			nixd = {
				formatting = {
					command = { "nixfmt" },
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
					globals = { "vim", "nixCats", "Snacks" },
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

	bashls = {
		cmd = { "bash-language-server", "start" },
		filetypes = { "sh", "bash" },
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
