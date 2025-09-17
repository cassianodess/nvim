return {
  {
    'akinsho/toggleterm.nvim',
    enabled = true,
    version = '*',
    config = function()
      local toggleterm = require 'toggleterm'
      toggleterm.setup {
        size = 20,
        open_mapping = [[<c-j]],
        hide_number = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persister_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }
      -- vim.keymap.set({ 'n', 'v', 'c' }, '<C-j>', ':ToggleTerm <CR>')
      -- vim.keymap.set('t', '<C-j>', [[<C-\><C-n>]], { noremap = true, silent = true })
      -- vim.keymap.set('n', '<C-j>', ':ToggleTerm<CR>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v', 'c' }, '<leader>j', ':ToggleTerm <CR>')
      vim.keymap.set('t', '<leader>j', [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
  },
}