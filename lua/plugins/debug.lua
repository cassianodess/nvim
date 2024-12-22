return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'akinsho/flutter-tools.nvim',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      { '<leader>u', dapui.toggle, desc = 'Debug: Toggle DAP UI' }, -- Tecla para alternar a DAP UI
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = { 'delve', 'dart' },
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- Comente ou remova as linhas abaixo para manter a DAP UI aberta após a depuração
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-go').setup {
      delve = {
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- Configurações para depuração de pacotes Go
    dap.configurations.go = {
      {
        name = 'Launch Package',
        type = 'go',
        request = 'launch',
        mode = 'debug', -- Mude para 'debug' para iniciar a depuração
        program = '${workspaceFolder}', -- Diretório do seu workspace
        envFile = '.env', -- Arquivo de ambiente, se necessário
      },
    }

    dap.adapters.dart = {
      type = 'executable',
      command = os.getenv 'FLUTTER_PATH' .. '/bin/flutter',
      args = { 'debug-adapter' },
    }

    dap.configurations.dart = {
      {
        type = 'dart',
        request = 'launch',
        name = 'Launch Flutter',
        program = '${workspaceFolder}/lib/main.dart',
        cwd = '${workspaceFolder}',
        flutterSdkPath = os.getenv 'FLUTTER_PATH',
        console = 'integratedTerminal',
      },
    }

    dap.adapters.java = function(callback)
      callback {
        type = 'server',
        host = '127.0.0.1',
        port = 5005,
      }
    end
    dap.configurations.java = {
      {
        type = 'java',
        request = 'attach',
        name = 'Debug (Attach) - Remote',
        hostName = '127.0.0.1',
        port = 5005,
      },
    }
  end,
}
