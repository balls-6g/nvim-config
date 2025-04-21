return {
    {
        "codota/tabnine-nvim",
        enabled = false,
        event = 'VeryLazy',
        build = "./dl_binaries.sh",
        url = "https://bgithub.xyz/codota/tabnine-nvim",
        config = function ()
            require("tabnine").setup({
                disabled_auto_comment = true,
                accept_keymap = "<C-n>",
                dismiss_keymap = "<C-]>",
                debounce_ms = 300,
                suggestion_color = { gui = "#808080", cterm = 244 },
                execlude_filetypes = { "TelescopePrompt" },
            })
        end
    }
}
