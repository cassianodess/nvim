return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local multiCursor = require("multicursor-nvim")
		multiCursor.setup()

		local set = vim.keymap.set

		set({ "n", "x" }, "<A-k>", function()
			multiCursor.lineAddCursor(-1)
		end)
		set({ "n", "x" }, "<A-j>", function()
			multiCursor.lineAddCursor(1)
		end)
		set({ "n", "x" }, "<leader><A-k>", function()
			multiCursor.lineSkipCursor(-1)
		end)
		set({ "n", "x" }, "<leader><A-j>", function()
			multiCursor.lineSkipCursor(1)
		end)

		set({ "n", "x" }, "<leader>n", function()
			multiCursor.matchAddCursor(1)
		end)
		set({ "n", "x" }, "<leader>s", function()
			multiCursor.matchSkipCursor(1)
		end)
		set({ "n", "x" }, "<leader>N", function()
			multiCursor.matchAddCursor(-1)
		end)
		set({ "n", "x" }, "<leader>S", function()
			multiCursor.matchSkipCursor(-1)
		end)

		set("n", "<A-leftmouse>", multiCursor.handleMouse)
		set("n", "<A-leftdrag>", multiCursor.handleMouseDrag)
		set("n", "<A-leftrelease>", multiCursor.handleMouseRelease)
		set({ "n", "x" }, "<A-q>", multiCursor.toggleCursor)

		set("n", "<F3>", function()
			vim.cmd("normal! viw")
			multiCursor.matchAddCursor(1)
		end)

		set("x", "<F3>", function()
			multiCursor.matchAddCursor(1)
		end)

		multiCursor.addKeymapLayer(function(layerSet)

			layerSet({ "n", "x" }, "<left>", multiCursor.prevCursor)
			layerSet({ "n", "x" }, "<right>", multiCursor.nextCursor)
			layerSet({ "n", "x" }, "<leader>x", multiCursor.deleteCursor)
			layerSet("n", "<esc>", function()
				if not multiCursor.cursorsEnabled() then
					multiCursor.enableCursors()
				else
					multiCursor.clearCursors()
				end
			end)
		end)

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