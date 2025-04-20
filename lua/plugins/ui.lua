return {
    {
	      "nvim-lualine/lualine.nvim",
        -- enabled = false, -- 跟 tmux 状态栏放一起的时候有点丑
        event = "VeryLazy",
	      dependencies = { 'nvim-tree/nvim-web-devicons' },
	      config = function()
	          require('lualine').setup({
		            options = { theme = 'tokyonight-moon' },
	          })
	      end
    }, -- 状态栏
    {
	      "nvim-tree/nvim-web-devicons",
	      opts = {},
        lazy = true,
    },
    {
	      "nvim-tree/nvim-tree.lua",
	      url = "https://bgithub.xyz/nvim-tree/nvim-tree.lua",
	      config = function() 
	          vim.g.loaded_netrw = 1
	          vim.g.loaded_netrwPlugin = 1
	          require('nvim-tree').setup()
	      end,
    }, -- 文件树
    {
	      "sphamba/smear-cursor.nvim",
	      url = "https://bgithub.xyz/sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        -- enabled = false,
	      opts = {
            cursor_color = "#ff8800",
            stiffness = 0.3,
            trailing_stiffness = 0.1,
            trailing_exponent = 7,
            hide_target_hack = true,
            gamma = 1,
	      },
    }, -- 顺滑光标
    {
        "akinsho/bufferline.nvim",
        version = "*",
        url = "https://bgithub.xyz/akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            highlight = {
                fill = {
                    bg = "#00000000",
                },
                background = {
                    bg = "1a1a1a55",
                },
                buffer_visible = {
                    bg = "#2d2d2d55",
                },
                buffer_selected = {
                    bg = "#333333aa",
                },
            }
        },
        config = function ()
            require("bufferline").setup{}
        end
    },
    {
        "MunifTanjim/nui.nvim",
        url = "https://bgithub.xyz/MunifTanjim/nui.nvim",
        -- enabled = false,
        config = function ()
            require("nui.popup")
            require("nui.layout")
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        -- enabled = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup", -- 悬浮式输入框
                format = {
                    cmdline = { icon = "󰘳 " }, -- 自定义命令图标
                    search_down = { icon = " " }, -- 搜索图标
                }
            },
            messages = {
                enabled = true, -- 美化消息提示
                view = "mini",  -- 精简消息样式
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true, -- 支持 Markdown
                }
            }
        }
    },
    {
        "rcarriga/nvim-notify",
        url = "https://bgithub.xyz/rcarriga/nvim-notify",
        config = function() end
    },
    {
        "xiyaowong/transparent.nvim",
        url = "https://bgithub.xyz/xiyaowong/transparent.nvim",
        -- lazy = true,
        event = "VeryLazy",
        config = function ()
            require("transparent").clear_prefix('Noice')
            require("transparent").clear_prefix('NvimWebDevicons')
            require("transparent").clear_prefix('NvimTree')
            require("transparent").clear_prefix('RenderMarkdown')
            require('transparent').clear_prefix('Snacks')
        end
    },
}
