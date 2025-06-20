vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
-- Configuração global de indentação
vim.opt.expandtab = true -- Usa espaços ao invés de tabs
vim.opt.tabstop = 2 -- Define o número de espaços por tabulação
vim.opt.softtabstop = 2 -- Usa o mesmo número de espaços para o soft tab
vim.opt.shiftwidth = 2 -- Indentação de 4 espaços por nível
vim.opt.smartindent = true -- Ativa indentação inteligente
vim.opt.autoindent = true -- Ativa indentação automática
vim.opt.smarttab = true -- Ativa tabulação inteligente

vim.g.sleuth_autostart = false
vim.g.sleuth_automatic = false

vim.cmd("set number relativenumber")
vim.cmd("set nu rnu")
vim.cmd("set wrap")
vim.cmd("set linebreak")
vim.cmd("set showbreak=+++")
vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevelstart=99")

vim.opt.termguicolors = true

vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
vim.fn.matchadd("ExtraWhitespace", "\\s\\+$")

vim.api.nvim_set_keymap("v", "<C-S-c>", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
-- vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { silent = true, noremap = true })

vim.opt.lazyredraw = true -- Reduz atualizações de tela durante execução de macros
vim.opt.synmaxcol = 200 -- Limita o número de colunas analisadas pela syntax
vim.opt.updatetime = 300 -- Reduz o tempo de espera para atualizações

vim.opt.swapfile = false
vim.opt.incsearch = true

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.g.have_nerd_font = true

vim.opt.number = true
-- vim.opt.mouse = 'a'
vim.cmd("set mouse=a")
vim.opt.showmode = false
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
-- vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = {
	-- tab = '» ',
	trail = "·",
	-- nbsp = '␣'
}

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "java",
--   callback = function()
--     vim.b.sleuth_automatic = false -- Desativa o vim-sleuth para arquivos Java
--     vim.opt_local.expandtab = true
--     vim.opt_local.tabstop = 4
--     vim.opt_local.softtabstop = 4
--     vim.opt_local.shiftwidth = 4
--   end,
-- })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.diagnostic.setqflist({ open = false }) -- Atualiza a lista de quickfix
	end,
})

vim.keymap.set("n", "<leader>q", function()
	local quickfix_open = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			quickfix_open = true
			break
		end
	end

	if quickfix_open then
		vim.cmd("cclose")
	else
		vim.diagnostic.setqflist({ open = true })
	end
end, { desc = "Toggle diagnostic [Q]uickfix list for the entire project" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })
vim.keymap.set("n", "<leader>tw", [[:%s/\s\+$//e<CR>]], { desc = "Trim trailing whitespace" })
