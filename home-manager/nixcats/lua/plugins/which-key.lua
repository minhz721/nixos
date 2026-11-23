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
    { "<leader>c", group = "Code" },
    { "z", group = "Fold" },
    { "za", desc = "Toggle fold" },
    { "zc", desc = "Close fold" },
    { "zo", desc = "Open fold" },
    { "zM", desc = "Close all folds" },
    { "zR", desc = "Open all folds" },
  },
})
