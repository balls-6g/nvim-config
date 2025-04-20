return {
    {
        "saecki/crates.nvim",
        ft = "toml",
        tag = "stable",
        config = function ()
            require('crates').setup()
        end
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        url = "https://bgithub.xyz/rust-lang/rust.vim",
        config = function () end
    },
}
