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
    {
        "mrcjkb/rustaceanvim",
        url = "https://bgithub.xyz/mrcjkb/rustaceanvim",
        version = "^6",
        ft = "rust"
    }
}
