return {
    {
        "mfussenegger/nvim-dap",
        ft = { "rust", "go" },
        url = "https://bgithub.xyz/mfussenegger/nvim-dap",
        lazy = true,
        config = function()
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        url = "https://bgithub.xyz/jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        config = function()
            require("mason-nvim-dap").setup({
            })
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        url = "https://bgithub.xyz/rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },
    {
        "nvim-neotest/neotest",
        ft = { "rust", "go" },
        url = "https://bgithub.xyz/nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function ()
            require("neotest").setup({})
        end
    },
    {
        "nvim-lua/plenary.nvim",
        lazy=  true,
        url = "https://bgithub.xyz/nvim-lua/plenary.nvim",
    },
    {
        "antoinemadec/FixCursorHold.nvim",
        url = "https://bgithub.xyz/antoinemadec/FixCursorHold.nvim",
        lazy = true,
    }
}
