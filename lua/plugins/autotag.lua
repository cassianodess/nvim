return {
  'windwp/nvim-ts-autotag',
  enabled = false,
  config = function()
    require('nvim-ts-autotag').setup()
  end,
}
