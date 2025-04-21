return {
    {
        "nvim-lualine/lualine.nvim",
        url = "https://bgithub.xyz/nvim-lualine/lualine.nvim",
        event = { "BufReadpost", "BufNewFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            require('lualine').setup {
                options = {
                  theme = "auto",
                  component_separators = '',
                  section_separators = { left = '', right = '' },
                },
                sections = {
                  lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                  lualine_b = { 'filename', 'branch' },
                  lualine_c = {
                    '%=', --[[ add your center components here in place of this comment ]]
                  },
                  lualine_x = {},
                  lualine_y = { 'filetype', 'progress' },
                  lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                  },
                },
                inactive_sections = {
                  lualine_a = { 'filename' },
                  lualine_b = {},
                  lualine_c = {},
                  lualine_x = {},
                  lualine_y = {},
                  lualine_z = { 'location' },
                },
                tabline = {},
                extensions = {},
              }
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
        },
        config = function ()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },

                presets = {
                    long_message_to_split = true,
                    lsp_doc_border = false,
                    inc_rename = false,
                }
            })
        end
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
