return {
	"windwp/nvim-autopairs",
	enabled = true,
	event = "InsertEnter",
	-- Optional dependency
	-- dependencies = { 'hrsh7th/nvim-cmp' },
	config = function()
		local npairs = require("nvim-autopairs")
		npairs.setup({})

		local ok, cmp = pcall(require, "cmp")
		if ok then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
