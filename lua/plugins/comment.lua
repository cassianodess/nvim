return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        toggler = {
          line = '<C-_>', -- Comentar/descomentar linhas com Ctrl + /
          block = '<C-S-_>', -- Comentar/descomentar blocos com Ctrl + Shift + /
        },
        opleader = {
          line = '<C-_>', -- Comentar/descomentar seleção visual com Ctrl + /
          block = '<C-S-_>',
        },
      }
    end,
  },
}
