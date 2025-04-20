return {
    {
        "mfussenegger/nvim-dap",
        ft = "rust",
        url = "https://bgithub.xyz/mfussenegger/nvim-dap",
        lazy = true,
        config = function()
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        url = "https://bgithub.xyz/jay-babu/mason-nvim-dap.nvim",
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
}
