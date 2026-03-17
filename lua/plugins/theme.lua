return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    'olimorris/onedarkpro.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "onedark"
    end,
  },
}