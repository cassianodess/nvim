return {
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        session_lens = {
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
        auto_session_ignore_filetypes = {
          'alpha',
          'dap-repl',
          'log',
          'NvimTree',
          'startify',
          'bugger',
          'fugitive',
          'fugitiveblame',
          'qf',
          'help',
          'packer',
          'neogitstatus',
          'TelescopePrompt',
          'toggleterm',
          'buffer',
        },
        auto_session_enable_last_session = true,

        vim.keymap.set('n', '<Leader>ls', require('auto-session.session-lens').search_session, {
          noremap = true,
        }),
      }
    end,
  },
}
