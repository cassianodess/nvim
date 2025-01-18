return {
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        session_lens = {
          buftypes_to_ignore = {
            'terminal',
            'nofile',
            'quickfix',
            'prompt',
            'help',
            'log',
          },
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
        vim.keymap.set('n', '<Leader>ls', require('auto-session.session-lens').search_session, {
          noremap = true,
        }),
      }
    end,
  },
}
