return {
  {
    "MattesGroeger/vim-bookmarks",
    enabled = true,
    init = function()
      vim.g.bookmark_highlight_lines = 1
      vim.g.bookmark_center = 1
    end,
    config = function()
      vim.api.nvim_set_hl(0, "BookmarkSign", { link = "DiagnosticInfo" })
      vim.api.nvim_set_hl(0, "BookmarkLine", { link = "Visual" })
      vim.api.nvim_set_hl(0, "BookmarkAnnotationSign", { fg = "#00FFAA", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "BookmarkAnnotationLine", { bg = "#2a2a3a" })

      vim.keymap.set("n", "mm", "<cmd>BookmarkToggle<CR>", { desc = "[M]ark [M]ark" })
      vim.keymap.set("n", "ma", "<cmd>BookmarkShowAll<CR>", { desc = "[M]ark [A]ll" })
      vim.keymap.set("n", "mc", "<cmd>BookmarkClearAll<CR>", { desc = "[M]ark [C]lear All" })
      vim.keymap.set("n", "mn", "<cmd>BookmarkNext<CR>", { desc = "[M]ark [N]ext" })
      vim.keymap.set("n", "mp", "<cmd>BookmarkPrev<CR>", { desc = "[M]ark [P]revious" })
    end,
  },
}