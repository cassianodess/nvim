return {
  {
    'rmagatti/auto-session',
    dependencies = { 'rmagatti/session-lens' }, -- Certifique-se de instalar o session-lens
    config = function()
      -- Configuração do auto-session
      require('auto-session').setup {
        log_level = 'info',
        auto_session_enable_last_session = true,
        auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        session_lens = {
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      }

      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

      vim.keymap.set('n', '<Leader>ls', require('auto-session.session-lens').search_session, {
        noremap = true,
        desc = 'Search sessions',
      })
    end,
  },
}
