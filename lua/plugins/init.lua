-- your plugin's configurations comes here

local fts = { "go", "rust", "markdown", "lua" }

return {
    {
        "nvim-neotest/nvim-nio",
        url = "https://bgithub.xyz/nvim-neotest/nvim-nio",
    },
    {
        "mfussenegger/nvim-lint",
        url = "https://bgithub.xyz/mfussenegger/nvim-lint",
        ft = fts,
        event = "VeryLazy",
        config = function ()
            require('lint')
        end
    }
}
