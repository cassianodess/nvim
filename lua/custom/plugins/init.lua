-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'goolord/alpha-nvim',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      alpha.setup(dashboard.config)

      dashboard.section.header.val = {

        [[                                  __]],
        [[     ██████╗███████╗███████╗    ████████╗███████╗ ██████╗██╗  ██╗]],
        [[    ██╔════╝██╔════╝██╔════╝    ╚══██╔══╝██╔════╝██╔════╝██║  ██║]],
        [[    ██║     ███████╗███████╗       ██║   █████╗  ██║     ███████║]],
        [[    ██║     ╚════██║╚════██║       ██║   ██╔══╝  ██║     ██╔══██║]],
        [[    ╚██████╗███████║███████║       ██║   ███████╗╚██████╗██║  ██║]],
        [[     ╚═════╝╚══════╝╚══════╝       ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝]],
        [[    ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗]],
        [[    ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝]],
        [[    ███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗]],
        [[    ╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║]],
        [[    ███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║]],
        [[    ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝]],
      }

      dashboard.section.buttons.val = {
        dashboard.button('<C-p>', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('<C-n>', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
        dashboard.button('<leader>fg', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e ~/.config/nvim/init.lua<CR>'),
        dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
      }
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
