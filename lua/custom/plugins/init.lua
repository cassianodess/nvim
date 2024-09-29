-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  },
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
