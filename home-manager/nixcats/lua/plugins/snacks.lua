local map = vim.keymap.set

require("snacks").setup({
  explorer = { enabled = true, replace_netrw = false },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  indent = { enabled = true, char = "│", animate = { enabled = false } },
  scroll = {
    enabled = true,
    animate = { duration = { step = 10, total = 100 }, easing = "linear" },
  },
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  words = { enabled = true },
})

map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Toggle file explorer" })
map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next reference" })
map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev reference" })
