return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<leader>u",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<F7>",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		-- local fluttertools = require("flutter-tools")
		dap.defaults.fallback.terminal_win_cmd = "belowright split | terminal"

		local function load_public_key()
			local public_key_file = vim.fn.getcwd() .. "/public.pem"
			if vim.fn.filereadable(public_key_file) == 1 then
				local handle = io.popen("base64 -w0 " .. public_key_file)
				local result = handle:read("*a")
				handle:close()
				return result:gsub("%s+", "") -- Remove espaços e quebras de linha
			end
			return ""
		end

		local function load_env(file)
			local hasFile = file ~= nil and file ~= ""
			if hasFile == false then
				file = vim.fn.getcwd() .. "/.env"
			end

			local isGolangProject = vim.fn.filereadable(file)
			if isGolangProject == 0 then
				return {}
			end

			local env = {}
			for line in io.lines(file) do
				for key, value in string.gmatch(line, "([%w_]+)=([^\n]+)") do
					env[key] = value
				end
			end
			return env
		end

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = { "delve", "dart", "java", "js-debug-adapter", "prettier" },
		})

		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.7 },
						{ id = "breakpoints", size = 0.3 },
						-- { id = "stacks", size = 0.25 },
						-- { id = "watches", size = 0.25 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						-- { id = "repl", size = 0.45 },
						{ id = "console", size = 1 },
					},
					size = 10,
					position = "bottom",
				},
			},
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
				env = function()
					return load_env(vim.fn.getcwd() .. "/.env.local")
				end,
				console = "integratedTerminal",
				runInTerminal = true,
				showLog = true,
				dlvToolPath = vim.fn.exepath("dlv"),
			},
			{
				name = "Test Go Local",
				type = "go",
				request = "launch",
				mode = "test",
				program = "${file}",
				envFile = "${workspaceFolder}/.env.local",
				env = function()
					return load_env(vim.fn.getcwd() .. "/.env.local")
				end,
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
				env = function()
					return load_env(vim.fn.getcwd() .. "/.env.staging")
				end,
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
				env = function()
					return load_env(vim.fn.getcwd() .. "/.env.prod")
				end,
				console = "integratedTerminal",
				showLog = true,
				dlvToolPath = vim.fn.exepath("dlv"),
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
				name = "Attach Node (9222)",
				type = "pwa-node",
				request = "attach",
				processId = 9222,
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

		-- Função para iniciar WildFly automaticamente
		local start_wildfly_if_needed = function()
			local handle = io.popen('pgrep -f "wildfly-16.0.0.Final"')
			local result = handle:read("*a")
			handle:close()

			if result == "" then
				print("🔄 Iniciando WildFly...")
				vim.fn.jobstart("start-wildfly-debug.sh", {
					detached = true,
					on_exit = function()
						print("✅ WildFly iniciado. Conectando debug em 8s...")
						vim.defer_fn(function()
							-- Conectar ao debug após WildFly iniciar
							dap.continue({ name = "Debug WildFly" })
						end, 8000)
					end,
				})
				return true -- WildFly foi iniciado
			end
			return false -- WildFly já estava rodando
		end

		-- Override para debug do Java que inicia WildFly se necessário
		local original_continue = dap.continue
		dap.continue = function(opts)
			if opts and opts.name == "Debug WildFly" then
				local wildfly_started = start_wildfly_if_needed()
				if not wildfly_started then
					-- WildFly já está rodando, conectar normalmente
					original_continue(opts)
				end
			else
				original_continue(opts)
			end
		end
	end,
}