return {
    {
        "ray-x/go.nvim",
        url = "https://bgithub.xyz/ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function ()
            require("go").setup()
        end,
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()'
    },
}
