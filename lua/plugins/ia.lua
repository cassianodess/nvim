return {
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    -- enabled = false,
    config = function()
      -- Desabilita mapeamentos padrão do Codeium
      vim.g.codeium_disable_bindings = 1

      -- Aceitar sugestão com Ctrl+Enter
      vim.keymap.set('i', '<C-y>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })

      -- Ciclar sugestões com Ctrl+; e Ctrl+,
      -- vim.keymap.set("i", "<c-;>", function()
      --   return vim.fn
      -- end, { expr = true, silent = true })
      -- vim.keymap.set("i", "<c-,>", function()
      --   return vim.fn["codeium#CycleCompletions"](-1)
      -- end, { expr = true, silent = true })
      --
      -- Limpar sugestão com Ctrl+X
      vim.keymap.set('i', '<C-n>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })
    end,
  },
}