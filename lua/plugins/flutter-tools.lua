return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
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
          filter = nil,
          notify_errors = true,
          open_cmd = 'tabedit',
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
