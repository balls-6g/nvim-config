return {
    {
        "echasnovski/mini.nvim",
        url = "https://bgithub.xyz/echasnovski/mini.nvim",
        version = "*",
        event = "VeryLazy",
        keys = {
            { "<leader>mf", ":lua MiniFiles.open()<CR>", desc = "mini files" }
        },
        config = function()
            require("mini.files").setup({})
            require("mini.git").setup({})
            require("mini.icons").setup({})
            require("mini.notify").setup({})
            require("mini.surround").setup({})
            require("mini.fuzzy").setup({})
            require("mini.sessions").setup({})
        end
    },
}
