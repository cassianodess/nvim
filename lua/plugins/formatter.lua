return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
      local nls = require 'null-ls'
      return {
        sources = {
          nls.builtins.formatting.prettier,
          -- nls.builtins.formatting.stylua,
          -- nls.builtins.diagnostics.eslint,
          -- nls.builtins.python.black,
        },
      }
    end
  }
}