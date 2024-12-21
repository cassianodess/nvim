return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {"html", "css", "javascript", "typescript", "vim", "go", "dart"},
        auto_install = true,
        indent = { enable = true },
        highlight = { enable = true },
      })
    end,
  },
}
