vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Indentation
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true

vim.g.sleuth_autostart = false
vim.g.sleuth_automatic = false
--

vim.cmd("set number relativenumber")
vim.cmd("set nu rnu")
vim.cmd("set wrap")
-- vim.opt.wrap = false
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
vim.keymap.set("n", "<leader>tw", [[:%s/\s\+$//e<CR>]], { desc = "[T]rim [W]hitespace" })
-- vim.keymap.set("n", "<leader>e", function()
--   if vim.bo.filetype == "netrw" then
--     vim.cmd("bd")
--   else
--     vim.cmd("Ex")
--   end
-- end, { desc = "Toggle File [E]xplorer" })
--

vim.keymap.set("n", "<leader>sr", function()
	vim.cmd("source " .. vim.fn.expand("%"))
	print("File Sourced!")
end, { desc = "Source current file" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		vim.b.sleuth_automatic = false
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("kickstart-terminal", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
    vim.cmd("highlight clear ExtraWhitespace")
	end,
})


vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next [Q]uickfix" })
vim.keymap.set("n", "<M-k>", "<cmd>cprevious<CR>", { desc = "Previous [Q]uickfix" })

--control variables for terminal
-- local term_buf = nil
-- local term_win = nil
-- vim.keymap.set("n", "<leader>j", function()
--   if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
--     if term_win and vim.api.nvim_win_is_valid(term_win) then
--       vim.api.nvim_win_hide(term_win)
--       term_win = nil
--     else
--       vim.cmd("botright split")
--       term_win = vim.api.nvim_get_current_win()
--       vim.api.nvim_win_set_height(term_win, 15)
--       vim.api.nvim_win_set_buf(term_win, term_buf)
--     end
--   else
--     vim.cmd("botright split | term")
--     term_win = vim.api.nvim_get_current_win()
--     term_buf = vim.api.nvim_win_get_buf(term_win)
--     vim.api.nvim_win_set_height(term_win, 15)
--   end
-- end, { desc = "Toggle Terminal" })