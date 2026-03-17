return {
	{
		"akinsho/flutter-tools.nvim",
		-- lazy = false,
		ft = "dart",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("telescope").load_extension("flutter")

			require("flutter-tools").setup({
				ui = {
					border = "rounded",
				},
				debugger = {
					enabled = true,
					-- run_via_dap = true,
					exception_breakpoints = {},
				},
				flutter_path = os.getenv("FLUTTER_PATH") .. "/bin/flutter",
				widget_guides = {
					enabled = true,
				},
				dev_tools = {
					autostart = false,
					auto_open_browser = false,
				},
				dev_log = {
					enabled = false,
					filter = nil,
					notify_errors = true,
					focus_on_open = false,
				},
				outline = {},
				settings = {
					updateImportsOnRename = true,
					showTodos = true,
					completeFunctionCalls = true,
				},
				fvm = false,
				lsp = {
					color = { -- show the derived colours for dart variables
						enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
						background = false, -- highlight the background
						background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
						foreground = false, -- highlight the foreground
						virtual_text = true, -- show the highlight using virtual text
						virtual_text_str = "■", -- the virtual text character to highlight
					},
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						renameFilesWithClasses = "prompt", -- "always"
						enableSnippets = true,
						updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
					},
				},
			})

			require("flutter-tools").setup_project({
				{
					name = "Debug Flutter Mobile",
					target = "lib/main.dart",
					dart_define_from_file = "${workspaceFolder}/.env",
				},
			})
		end,
	},
}