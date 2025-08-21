return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		-- -- Add or skip cursor above/below the main cursor.
		-- set({ "n", "x" }, "<A-k>", function()
		-- 	mc.lineAddCursor(-1)
		-- end)
		-- set({ "n", "x" }, "<A-j>", function()
		-- 	mc.lineAddCursor(1)
		-- end)
		-- set({ "n", "x" }, "<leader><A-k>", function()
		-- 	mc.lineSkipCursor(-1)
		-- end)
		-- set({ "n", "x" }, "<leader><A-j>", function()
		-- 	mc.lineSkipCursor(1)
		-- end)

		-- Add or skip adding a new cursor by matching word/selection
		-- set({ "n", "x" }, "<leader>n", function()
		-- 	mc.matchAddCursor(1)
		-- end)
		-- set({ "n", "x" }, "<leader>s", function()
		-- 	mc.matchSkipCursor(1)
		-- end)
		-- set({ "n", "x" }, "<leader>N", function()
		-- 	mc.matchAddCursor(-1)
		-- end)
		-- set({ "n", "x" }, "<leader>S", function()
		-- 	mc.matchSkipCursor(-1)
		-- end)

		-- Add and remove cursors with control + left click.
		set("n", "<A-leftmouse>", mc.handleMouse)
		set("n", "<A-leftdrag>", mc.handleMouseDrag)
		set("n", "<A-leftrelease>", mc.handleMouseRelease)

		-- Disable and enable cursors.
		set({ "n", "x" }, "<A-q>", mc.toggleCursor)

		-- -- Seleciona a próxima ocorrência da palavra ou seleção atual
		-- set({ "n", "x" }, "<C-n>", function()
		-- 	mc.matchAddCursor(1)
		-- end)
		--
		-- -- Seleciona a ocorrência anterior (opcional, igual ao Shift+F3 no VSCode)
		-- set({ "n", "x" }, "<C-N>", function()
		-- 	mc.matchAddCursor(-1)
		-- end)
		--

		-- Seleciona a palavra sob o cursor e adiciona a próxima ocorrência
		set("n", "<C-n>", function()
			vim.cmd("normal! viw") -- seleciona a palavra
			mc.matchAddCursor(1) -- adiciona próxima ocorrência
		end)

		set("x", "<C-n>", function()
			mc.matchAddCursor(1) -- já está em modo visual, só adiciona
		end)

		-- Adiciona ocorrência anterior (igual ao Shift+F3 no VSCode)
		-- set("n", "<C-N>", function()
		-- 	vim.cmd("normal! viw") -- seleciona a palavra
		-- 	mc.matchAddCursor(-1) -- adiciona ocorrência anterior
		-- end)
		--
		-- set("x", "<C-N>", function()
		-- 	mc.matchAddCursor(-1) -- já está em modo visual
		-- end)

		-- Mappings defined in a keymap layer only apply when there are
		-- multiple cursors. This lets you have overlapping mappings.
		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ "n", "x" }, "<left>", mc.prevCursor)
			layerSet({ "n", "x" }, "<right>", mc.nextCursor)

			-- Delete the main cursor.
			layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

			-- Enable and clear cursors using escape.
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}