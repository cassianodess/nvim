return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({})
      -- require("telescope").load_extension("flutter")
      -- require("flutter-tools").setup_dap()

    end,
    -- config = true,
  },
}
