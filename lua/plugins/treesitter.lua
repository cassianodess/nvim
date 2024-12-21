return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "diff",
                    "html",
                    "lua",
                    "luadoc",
                    "markdown",
                    "markdown_inline",
                    "query",
                    "vim",
                    "vimdoc",
                    "go",
                    "dart",
                    "javascript",
                    "python",
                },
                auto_install = true,
                indent = { enable = true },
                highlight = { enable = true },
            })
        end,
    },
}
