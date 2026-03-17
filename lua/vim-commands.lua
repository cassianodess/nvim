vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- vim.g.sleuth_autostart = false
-- vim.g.sleuth_automatic = false

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "+++"

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

vim.opt.termguicolors = true

vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])

vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function()
		vim.fn.matchadd("ExtraWhitespace", "\\s\\+$")
	end,
})

vim.api.nvim_set_keymap("v", "<C-S-c>", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})

vim.opt.lazyredraw = true
vim.opt.synmaxcol = 200
vim.opt.updatetime = 300

vim.opt.swapfile = false
vim.opt.incsearch = true

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true

vim.opt.signcolumn = "yes"

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

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.diagnostic.setqflist({ open = false })
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