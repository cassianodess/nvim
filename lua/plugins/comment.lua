return {
  {
    'numToStr/Comment.nvim',
		event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('Comment').setup {
        toggler = {
          line = '<C-/>', -- Comentar/descomentar linhas com Ctrl + /
          block = '<C-S-/>', -- Comentar/descomentar blocos com Ctrl + Shift + /
        },
        opleader = {
          line = '<C-/>', -- Comentar/descomentar seleção visual com Ctrl + /
          block = '<C-S-/>',
        },
      }
    end,
  },
}