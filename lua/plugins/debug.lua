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
			{ "<leader>u", dapui.toggle, desc = "Debug: Toggle DAP UI" },

			{
				"<leader>dw",
				function()
					require("dap").continue({ name = "Debug WildFly" })
				end,
				desc = "Debug: WildFly",
			},
			{
				"<leader>ws",
				function()
					local handle = io.popen('pgrep -f "wildfly-16.0.0.Final"')
					local result = handle:read("*a")
					handle:close()

					if result ~= "" then
						print("✅ WildFly rodando (PID: " .. result:gsub("%s+", "") .. ")")

						local debug_handle = io.popen("netstat -tln 2>/dev/null | grep 8787")
						local debug_result = debug_handle:read("*a")
						debug_handle:close()

						if debug_result ~= "" then
							print("🐛 Debug ativo na porta 8787")
						else
							print("❌ Debug não disponível")
						end
					else
						print("❌ WildFly não está rodando")
						print("💡 Use <leader>dw para iniciar")
					end
				end,
				desc = "WildFly: Status",
			},
			unpack(keys),
		}
	end,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local fluttertools = require("flutter-tools")

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
      local hasFile = file ~= nil
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

		fluttertools.setup({
			flutter_path = os.getenv("FLUTTER_PATH") .. "/bin/flutter",
			dev_log = {
				enabled = true,
				focus_on_open = true,
				open_cmd = "tabedit",
				notify_errors = true,
				filter = nil,
			},
			lsp = {
				color = {
					enabled = true,
					virtual_text = true,
					virtual_text_str = "■",
				},
				settings = {
					showTodos = true,
					updateImportsOnRename = true,
				},
			},
		})

    fluttertools.setup_project({
      {
        name = "Debug AlyPlus Local",
        target = "lib/main.dart",
        dart_define = function ()
          local env = load_env()
          return {
            API_BASE_URL = env.API_BASE_URL or "",
            VIRTUAL_CARD_LANDING_PAGE = env.VIRTUAL_CARD_LANDING_PAGE or "",
            IS_PRODUCTION = env.IS_PRODUCTION or false,
            FAQ_URL = env.FAQ_URL or "",
            ANDROID_RECAPTCHA_KEY = env.ANDROID_RECAPTCHA_KEY or "",
            IOS_RECAPTCHA_KEY = env.IOS_RECAPTCHA_KEY,
            PUBLIC_KEY = load_public_key(),
          }
        end
      },
      {
        name = "Debug AlyPlus Staging",
        target = "lib/main.dart",
        dart_define = {
          API_BASE_URL = "https://app.alyplus.com/staging/api/v1",
          VIRTUAL_CARD_LANDING_PAGE = "https://staging-card-tokenization-jtj5lyudtq-ue.a.run.app",
          IS_PRODUCTION = false,
          FAQ_URL = "https://www.alyplus.com/contact-pages/faq",
          ANDROID_RECAPTCHA_KEY = "6Lf7rowrAAAAACPgbkJYHQ3RRt0-DVEke315Iy2l",
          IOS_RECAPTCHA_KEY = "6Ld3vYwrAAAAAN6fA8-ZvyQBFU7YylA1UqDqKvk_",
          PUBLIC_KEY = load_public_key(),
        }
      },
      {
        name = "Debug AlyPlus Prod",
        target = "lib/main.dart",
        dart_define = {
          API_BASE_URL = "https://app.alyplus.com/api/v1",
          VIRTUAL_CARD_LANDING_PAGE = "https://staging-card-tokenization-jtj5lyudtq-ue.a.run.app",
          IS_PRODUCTION = false,
          FAQ_URL = "https://www.alyplus.com/contact-pages/faq",
          ANDROID_RECAPTCHA_KEY = "6Lf7rowrAAAAACPgbkJYHQ3RRt0-DVEke315Iy2l",
          IOS_RECAPTCHA_KEY = "6Ld3vYwrAAAAAN6fA8-ZvyQBFU7YylA1UqDqKvk_",
          PUBLIC_KEY = load_public_key(),
        }
      }
    })

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = { "delve", "dart", "java", "js-debug-adapter" },
		})

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
				args = {
					"--dart-define=API_BASE_URL=" .. (load_env().API_BASE_URL or ""),
					"--dart-define=VIRTUAL_CARD_LANDING_PAGE=" .. (load_env().VIRTUAL_CARD_LANDING_PAGE or ""),
					"--dart-define=FAQ_URL=" .. (load_env().FAQ_URL or ""),
					"--dart-define=ANDROID_RECAPTCHA_KEY=" .. (load_env().ANDROID_RECAPTCHA_KEY or ""),
					"--dart-define=IOS_RECAPTCHA_KEY=" .. (load_env().IOS_RECAPTCHA_KEY or ""),
					"--dart-define=PUBLIC_KEY=" .. load_public_key(),
					"--dart-define=IS_PRODUCTION=" .. (load_env().IS_PRODUCTION or "false"),
				},
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

		-- # No Neovim:
		-- # <leader>dw  - Inicia WildFly + Debug
		-- # <leader>wd  - Build + Deploy
		-- # <leader>ws  - Ver status
		-- Java
		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Debug WildFly",
				hostName = "localhost",
				port = 8787,
				-- projectName = 'alyplus-api',
				timeout = 120000,
			},
		}

		dap.adapters.java = {
			type = "server",
			host = "127.0.0.1",
			port = "8787",
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