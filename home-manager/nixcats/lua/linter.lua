local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" },
  bash = { "shellcheck" },
  sh = { "shellcheck" },
}

-- Binaries are supplied by NixCats lspsAndRuntimeDeps and are on PATH.
-- Do not read nixCats("settings.*") here: absent settings may resolve to
-- category booleans rather than executable path strings.
lint.linters.ruff.cmd = "ruff"
lint.linters.shellcheck.cmd = "shellcheck"

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
