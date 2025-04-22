return {
    {
	      "hanxi/catppuccin.nvim",
        -- lazy = true,
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
            -- vim.cmd.colorscheme('catppuccin')
	      end
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {},
        config = function()
            -- vim.cmd.colorscheme('tokyonight-moon')
        end
    },
    {
        "neanias/everforest-nvim",
        lazy = true,
        event = "VeryLazy",
        config = function ()
            require("everforest").setup()
            vim.cmd.colorscheme('everforest')
        end
    }
}
