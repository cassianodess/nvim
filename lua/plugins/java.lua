-- return {
--   {
--     -- Quando o jdtls parar de funcionar, é só remover o .cache
--     -- rm -rf .cache/jdtls/workspace
--     'nvim-java/nvim-java',
--     dependencies = {
--       'folke/neoconf.nvim',
--     },
--     config = function()
--       require('lspconfig').jdtls.setup({
--         flags = { debounce_text_changes = 150 },
--         settings = {
--           java = {
--             format = { enabled = false },
--             home = os.getenv 'JAVA_HOME' .. '/usr/lib/jvm/java-21-openjdk-amd64',
--             configuration = {
--                 runtimes = {
--                 {
--                   name = 'JavaSE-11',
--                   path = os.getenv 'JAVA_HOME_11',
--                 },
--                 {
--                   name = 'JavaSE-17',
--                   path = os.getenv 'JAVA_HOME_17',
--                 },
--                 {
--                   name = 'JavaSE-21',
--                   path = os.getenv 'JAVA_HOME_21',
--                   default = true,
--                 },
--               },
--             },
--           },
--         },
--       })
--     end,
--   },
-- }
--

return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			-- INFO: deve ter as pastas .local/share/java , .local/share/java-debug e .local/share/lombok/lombok.jar
      -- INFO: https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file
      -- INFO: https://download.eclipse.org/jdtls/milestones for jdtls
      -- INFO : git clone https://github.com/microsoft/java-debug and `./mvnw clean install` for java-debug

      local java_plugin_location = os.getenv("HOME") .. "/.local/share/java"
			local jdtls_install_location = java_plugin_location .. "/jdtls"
			local jdtls_debug_location =  java_plugin_location .. "/java-debug"
      local lombok_path = java_plugin_location .. "/lombok/lombok.jar"

			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name

      local bundles = {
        vim.fn.glob(
          jdtls_debug_location .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
          true
        ),
      }

      local jdtls = require("jdtls")
      jdtls.setup_dap()

			local config = {
				cmd = {

					os.getenv("JAVA_HOME") .. "/bin/java",

					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
          "-javaagent:" .. lombok_path,
					"-jar",
					jdtls_install_location .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",

					"-configuration",
					jdtls_install_location .. "/config_linux",

					"-data",
					workspace_dir,
				},

				root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

				settings = {
					java = {},
				},

				init_options = {
          bundles = bundles,
				},
			}

			require("jdtls").start_or_attach(config)
		end,
	},
}