return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"typescript-language-server",
				"dart",
				"flutter",
				"gopls",
			},
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		config = function()
			require("mason-lspconfig").config({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

      local on_attach =  require("plugins.lsp-config").on_attach
      local capabilities_2 = require("plugins.lsp-config").capabilities
      local util = require("lspconfig/util")

      lspconfig.gopls.setup({
        capabilities = capabilities_2,
        on_attach = on_attach,
        cmd = {"gopls"},
        filetypes = {"go", "gomod", "gowork", "gohtmltmpl", "gotexttmpl", "gotmpl"},
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      })

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			-- lspconfig.java.setup({
			--   capabilities = capabilities,
			-- })
			--
			vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
			vim.keymap.set(
				"n",
				"gI",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[G]oto [I]mplementation" }
			)
			vim.keymap.set(
				"n",
				"<leader>D",
				require("telescope.builtin").lsp_type_definitions,
				{ desc = "Type [D]efinition" }
			)
			vim.keymap.set(
				"n",
				"<leader>ds",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "[D]ocument [S]ymbols" }
			)
			vim.keymap.set(
				"n",
				"<leader>ws",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "[W]orkspace [S]ymbols" }
			)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
