return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
		"akinsho/flutter-tools.nvim",
	},
	keys = function(_, keys)
		local dap = require("dap")
		local dapui = require("dapui")
		return {
			{ "<F5>", dap.continue, desc = "Debug: Start/Continue" },
			{ "<F1>", dap.step_into, desc = "Debug: Step Into" },
			{ "<F2>", dap.step_over, desc = "Debug: Step Over" },
			{ "<F3>", dap.step_out, desc = "Debug: Step Out" },
			{ "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
			{
				"<leader>B",
				function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Set Breakpoint",
			},
			{ "<F7>", dapui.toggle, desc = "Debug: See last session result." },
			{ "<leader>u", dapui.toggle, desc = "Debug: Toggle DAP UI" }, -- Tecla para alternar a DAP UI
			unpack(keys),
		}
	end,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = { "delve", "dart", "java", "js-debug-adapter" },
		})

		local function load_env(file)
			local env = {}
			for line in io.lines(file) do
				for key, value in string.gmatch(line, "([%w_]+)=([^\n]+)") do
					env[key] = value
				end
			end
			return env
		end

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		--
		--Golang
		require("dap-go").setup({
			delve = {
				-- detached = vim.fn.has 'win32' == 0,
				detached = false,
				args = { "--log", "--log-output=rpc,dap,debugger" },
			},
		})

		dap.configurations.go = {
			{
				name = "Debug Go Local",
				type = "go",
				request = "launch",
				mode = "debug",
				program = "${workspaceFolder}",
				envFile = "${workspaceFolder}/.env.local",
				env = load_env(vim.fn.getcwd() .. "/.env.local"),
				console = "integratedTerminal",
				showLog = true,
				dlvToolPath = vim.fn.exepath("dlv"),
			},
			{
				name = "Debug Go Staging",
				type = "go",
				request = "launch",
				mode = "debug",
				program = "${workspaceFolder}",
				envFile = "${workspaceFolder}/.env.staging",
				env = load_env(vim.fn.getcwd() .. "/.env.staging"),
				console = "integratedTerminal",
				showLog = true,
				dlvToolPath = vim.fn.exepath("dlv"),
			},
			{
				name = "Debug Go Prod",
				type = "go",
				request = "launch",
				mode = "debug",
				program = "${workspaceFolder}",
				envFile = "${workspaceFolder}/.env.prod",
				env = load_env(vim.fn.getcwd() .. "/.env.prod"),
				console = "integratedTerminal",
				showLog = true,
				dlvToolPath = vim.fn.exepath("dlv"),
			},
		}

		-- Dart / Futter
		dap.adapters.dart = {
			type = "executable",
			command = os.getenv("FLUTTER_PATH") .. "/bin/flutter",
			args = { "debug-adapter" },
		}

		dap.configurations.dart = {
			{
				type = "dart",
				request = "launch",
				name = "Launch Flutter",
				program = "${workspaceFolder}/lib/main.dart",
				cwd = "${workspaceFolder}",
				flutterSdkPath = os.getenv("FLUTTER_PATH"),
				console = "integratedTerminal",
			},
		}

		-- Node | JavaScript | TypeScript
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "9222",
			executable = {
				command = "node",
				args = {
					os.getenv("HOME")
						.. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"9222",
				},
			},
		}

		dap.configurations.javascript = {
			{
				name = "Launch file",
				type = "pwa-node",
				request = "launch",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}

		-- React / JSX | TSX
		dap.adapters["pwa-chrome"] = {
			type = "server",
			host = "localhost",
			port = 9222,
			-- executable = {
			-- 	command = "node",
			-- 	args = {
			-- 		os.getenv("HOME")
			-- 			.. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			-- 		"9222",
			-- 	},
			-- },
		}

		dap.configurations.javascriptreact = {
			{
				name = "Debug React",
				type = "pwa-chrome",
				request = "attach",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				port = 9222,
				webRoot = vim.fn.getcwd() .. "/src",
				-- webRoot = "${workspaceFolder}/src",
				url = "http://localhost:3000",
				-- program = "${file}",
			},
		}

		-- Python
		dap.adapters.python = {
			type = "executable",
			command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch Flask (Neovim DAP)",
				module = "flask",
				args = { "--app=main.py", "run", "--host=0.0.0.0", "--port=8080", "--debugger" },
				jinja = true,
				justMyCode = true,
				-- program = "${workspaceFolder}", -- Diretório do seu workspace
				-- envFile = "${workspaceFolder}/.env", -- Arquivo de ambiente, se necessário
				env = {
					FLASK_APP = "main.py",
					FLASK_ENV = "development",
				},
				pythonPath = function()
					local cwd = vim.fn.getcwd()
					local venv_python = cwd .. "/.venv/bin/python"
					if vim.fn.executable(venv_python) == 1 then
						return venv_python
					elseif vim.fn.executable("python3") == 1 then
						return "python3"
					elseif vim.fn.executable("python") == 1 then
						return "python"
					else
						error("No valid Python interpreter found.")
					end
				end,
			},
		}
	end,
}