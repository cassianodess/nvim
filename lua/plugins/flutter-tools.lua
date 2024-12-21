return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('telescope').load_extension 'flutter'

      require('flutter-tools').setup {
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = {},
        },
        flutter_path = os.getenv 'FLUTTER_PATH' .. '/bin/flutter',
        widget_guides = {
          enabled = true,
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        dev_log = {
          enabled = true,
          filter = nil, -- optional callback to filter the log
          notify_errors = false, -- if there is an error whilst running then notify the user
          open_cmd = 'tabedit', -- command to use to open the log buffer
        },
        settings = {
          updateImportsOnRename = true,
        },
        fvm = false,
      } -- use defaults
    end,
    -- config = true,
  },
}
