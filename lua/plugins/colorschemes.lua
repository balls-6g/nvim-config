return {
    {
	      "hanxi/catppuccin.nvim",
        lazy = true,
	      name = "catppuccin",
	      url = "https://bgithub.xyz/catppuccin/nvim",
	      config = function()
	          require("catppuccin").setup({
		            flavour = "mocha", -- macchiato, latte, mocha, frappe
	                  -- background = {
	                  --     light = "latte",
	                  --     dark = "mocha"
	                  -- }
		            telescope = true,
		            treesitter = true,
		            lsp_trouble = true,
		            cmp = true,
                integration = {
                    ts_rainbow2 = true
                },
		            native_lsp = {
		                enabled = true,
		                virtual_text = {
			                  errors = { "italic" },
			                  hints = { "italic" },
		                }
		            }
	          })
	      end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
            vim.cmd.colorscheme('tokyonight-moon')
        end
    }
}
