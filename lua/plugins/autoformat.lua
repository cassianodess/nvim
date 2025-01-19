return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'prettier' },
        javascript = { 'prettier' },
        java = { 'google-java-format' },
        dart = { 'dartfmt' },
        python = { 'black' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
        tex = { 'latexindent' },
      },
    },
  },
}
