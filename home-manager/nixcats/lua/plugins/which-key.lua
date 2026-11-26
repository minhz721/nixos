require("which-key").setup({
  preset = "classic",
  delay = 300,
  filter = function(mapping)
    if mapping.lhs and mapping.lhs:match("^z") then
      local keep = { za = true, zc = true, zo = true, zM = true, zR = true }
      return keep[mapping.lhs] == true
    end
    return true
  end,
  spec = {
    { "<leader>f", group = "Find (FzfLua)" },
    { "<leader>x", group = "Diagnostics (Trouble)" },
    { "<leader>n", group = "Notifications (Noice)" },
    { "<leader>g", group = "Git" },
    { "<leader>gc", group = "Conflict" },
    { "<leader>c", group = "Code" },
    { "<leader>d", group = "Debug" },
    { "<leader>s", group = "Search / Replace" },
    { "<leader>S", group = "Session" },
    { "<leader>R", group = "Rust" },
    { "<leader>b", group = "Buffer" },
    { "z", group = "Fold" },
    { "za", desc = "Toggle fold" },
    { "zc", desc = "Close fold" },
    { "zo", desc = "Open fold" },
    { "zM", desc = "Close all folds" },
    { "zR", desc = "Open all folds" },
  },
})
