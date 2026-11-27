local map = vim.keymap.set

if vim.fn.has("nvim-0.11") ~= 1 then
  vim.notify("This LSP configuration requires Neovim 0.11 or newer.", vim.log.levels.ERROR)
  return
end

-- Use fzf-lua when it is loaded, otherwise fall back to the native LSP function.
local function pick(fzf_fn, native)
  return function()
    local ok, fzf = pcall(require, "fzf-lua")
    if ok and type(fzf[fzf_fn]) == "function" then
      fzf[fzf_fn]()
    else
      native()
    end
  end
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

    map("n", "gd", pick("lsp_definitions", vim.lsp.buf.definition), opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", pick("lsp_implementations", vim.lsp.buf.implementation), opts)
    map("n", "gr", pick("lsp_references", vim.lsp.buf.references), opts)
    map("n", "gy", pick("lsp_typedefs", vim.lsp.buf.type_definition), opts)
    map("n", "K", vim.lsp.buf.hover, opts)

    map("n", "<leader>rn", function()
      if vim.fn.exists(":IncRename") == 2 then
        vim.api.nvim_feedkeys(":IncRename " .. vim.fn.expand("<cword>"), "n", false)
      else
        vim.lsp.buf.rename()
      end
    end, opts)

    map("n", "<leader>ca", pick("lsp_code_actions", vim.lsp.buf.code_action), opts)
    map("n", "<leader>cd", vim.diagnostic.open_float, opts)

    map("n", "<leader>ih", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts)

    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts)
  end,
})

local rust_analyzer_settings = {
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
}

local servers = {
  nil_ls = {
    cmd = { "nil" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
    settings = {
      ["nil"] = {
        formatting = { command = { "nixfmt" } },
        -- statix / deadnix (nvim-lint) already report these.
        diagnostics = { ignored = { "unused_binding", "unused_with" } },
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

vim.g.rustaceanvim = {
  server = {
    default_settings = rust_analyzer_settings,
  },
}
local has_rustaceanvim = #vim.api.nvim_get_runtime_file("ftplugin/rust.lua", false) > 0

if not has_rustaceanvim then
  servers.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
    settings = rust_analyzer_settings,
  }
end

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
