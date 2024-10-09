return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree filesystem reveal right toggle<CR>', desc = 'Toggle NeoTree', silent = true },
    -- { '<C-l>', ':Neotree filesystem reveal right<CR>', desc = 'Focus NeoTree and Reveal Filesystem', silent = true },
    { '<leader>te>', ':wincmd p<CR>', desc = 'Focus Buffer', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfile = false,
        hide_gitignored = false,

      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
