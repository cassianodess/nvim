return {
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup {
        handle = {
          size = 10,
          color = '#6F1DCE',
        },
        marks = {
          Search = { color = '#F9E2AF' },
          Error = { color = '#F38BA8' },
          Warn = { color = '#FAB387' },
          Info = { color = '#89B4FA' },
          Hint = { color = '#94E2D5' },
          GitAdd = { color = '#A6E3A1' },
          GitChange = { color = '#FAB387' },
          GitDelete = { color = '#F38BA8' },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          -- search = true,
          gitsigns = true,
        },
        scroll = {
          horizontal = {
            use_default_config = true,
            direction = 'reverse',
          },
          vertical = {
            use_default_config = true,
          },
        },
      }
    end,
  },
}
