return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		enabled = true,

		config = function()
			-- INFO: README for instalation
			-- INFO: create .local/share/java and .local/share/java/lombok folders with `mkdir -p .local/share/java/lombok`
			-- INFO: https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file
			-- INFO: extract https://download.eclipse.org/jdtls/milestones in jdtls
			-- INFO : git clone https://github.com/microsoft/java-debug in .local/sharejava and `./mvnw clean install` for java-debug
			-- INFO : extract https://projectlombok.org/download in .local/share/java/lombok and `./mvnw clean install` for java-debug

			local java_plugin_location = os.getenv("HOME") .. "/.local/share/java"
			local jdtls_install_location = java_plugin_location .. "/jdtls"
			local jdtls_debug_location = java_plugin_location .. "/java-debug"
			local lombok_path = java_plugin_location .. "/lombok/lombok.jar"

			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = java_plugin_location .. "/jdtls/workspace/" .. project_name
			local launcher_jar = vim.fn.glob(jdtls_install_location .. "/plugins/org.eclipse.equinox.launcher_*.jar")

			local bundles = {
				vim.fn.glob(
					jdtls_debug_location
						.. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
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
					"-Dlog.level=ERROR",
					"-Xmx1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-javaagent:" .. lombok_path,
					"-jar",
          launcher_jar,

					"-configuration",
					jdtls_install_location .. "/config_linux",

					"-data",
					workspace_dir,
				},

				root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

				settings = {
					java = {
						format = { enabled = false },
            home = os.getenv("JAVA_HOME_21"),
						configuration = {
							runtimes = {
								{
									name = "JavaSE-11",
									path = os.getenv("JAVA_HOME_11"),
								},
								{
									name = "JavaSE-17",
									path = os.getenv("JAVA_HOME_17"),
								},
								{
									name = "JavaSE-21",
									path = os.getenv("JAVA_HOME_21"),
									default = true,
								},
							},
						},
					},
				},

				init_options = {
					bundles = bundles,
				},
			}

			require("jdtls").start_or_attach(config)
		end,
	},
}