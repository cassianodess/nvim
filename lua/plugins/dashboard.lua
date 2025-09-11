return {
	{
		"goolord/alpha-nvim",
		enabled = false,
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			alpha.setup(dashboard.config)

			dashboard.section.header.val = {
				[[____________________________________]],
				[[< Looks like you need more coffee! >]],
				[[------------------------------------]],
				[[        \   ^__^                     ']],
				[[         \  (oo)\_______             ']],
				[[            (__)\       )\/\         ']],
				[[                ||----w |            ']],
				[[                ||     ||            ']],
			}

			-- dashboard.section.header.val = {
			-- 	[[ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗']],
			-- 	[[ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║']],
			-- 	[[ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║']],
			-- 	[[ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║']],
			-- 	[[ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║']],
			-- 	[[ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝']],
			-- }

			-- dashboard.section.header.val = {
			-- [[                                  __]],
			-- [[     ██████╗███████╗███████╗    ████████╗███████╗ ██████╗██╗  ██╗]],
			-- [[    ██╔════╝██╔════╝██╔════╝    ╚══██╔══╝██╔════╝██╔════╝██║  ██║]],
			-- [[    ██║     ███████╗███████╗       ██║   █████╗  ██║     ███████║]],
			-- [[    ██║     ╚════██║╚════██║       ██║   ██╔══╝  ██║     ██╔══██║]],
			-- [[    ╚██████╗███████║███████║       ██║   ███████╗╚██████╗██║  ██║]],
			-- [[     ╚═════╝╚══════╝╚══════╝       ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝]],
			-- [[    ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗]],
			-- [[    ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝]],
			-- [[    ███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗]],
			-- [[    ╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║]],
			-- [[    ███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║]],
			-- [[    ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝]],
			-- }

			dashboard.section.buttons.val = {
				dashboard.button("<C-p>", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("<C-n>", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("<leader>fg", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
				dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
			}

			-- vim.cmd(
			-- 	[[ au BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) && winnr('$') == 1 | exec 'Alpha' | endif ]]
			-- )
		end,
	},
}