vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd 'set expandtab'
vim.cmd 'set tabstop=4'
vim.cmd 'set softtabstop=4'
vim.cmd 'set shiftwidth=4'
vim.cmd 'set number relativenumber'
vim.cmd 'set nu rnu'
vim.cmd 'set wrap'
vim.cmd 'set linebreak'
vim.cmd 'set showbreak=+++'
vim.cmd [[highlight ExtraWhitespace ctermbg=red guibg=red]]
vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')
vim.api.nvim_set_keymap('v', '<C-S-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', {})
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', {})
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { silent = true, noremap = true })

vim.opt.swapfile = false
vim.opt.incsearch = true

vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>q', function()
  local quickfix_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      quickfix_open = true
      break
    end
  end

  if quickfix_open then
    vim.cmd('cclose')
  else
    vim.diagnostic.setqflist({ open = true })
  end
end, { desc = 'Toggle diagnostic [Q]uickfix list for the entire project' })


vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Mapeamento para renomeação com o comando leader rn no arquivo atual
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
