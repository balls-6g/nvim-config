local fts = { "go", "rust", "markdown", "lua" }

return {
    {
	      "hanxi/catppuccin.nvim",
        lazy = false,
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
            vim.cmd.colorscheme 'catppuccin'
	      end
    }, -- 主题
    {
	      "nvim-tree/nvim-web-devicons",
	      opts = {},
        lazy = true,
    },
    {
	      "nvim-lualine/lualine.nvim",
        -- enabled = false, -- 跟 tmux 状态栏放一起的时候有点丑
        event = "VeryLazy",
	      dependencies = { 'nvim-tree/nvim-web-devicons' },
	      config = function()
	          require('lualine').setup({
		            options = { theme = 'catppuccin' },
	          })
	      end
    }, -- 状态栏
    {
	      "nvim-tree/nvim-tree.lua",
	      url = "https://bgithub.xyz/nvim-tree/nvim-tree.lua",
	      config = function() 
	          vim.g.loaded_netrw = 1
	          vim.g.loaded_netrwPlugin = 1
	          require('nvim-tree').setup()
	      end,
    },
    {
	      "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
	      url = "https://bgithub.xyz/nvim-treesitter/nvim-treesitter",
        ft = { "c", "go", "rust", "lua", "markdown" },
        lazy = true,
	      build = "TSUpdate",
	      config = function()
	          require('nvim-treesitter.configs').setup({
		            -- 语言 
		            ensure_installed = { "vim", "lua", "rust", "go", "c" },

		            -- 高亮和缩进
		            highlight = { enable = true },
		            indent = { enable = true },

		            -- 括号层级区分
		            rainbow = {
		                enable = true,
		                extended_mode = true,
		                max_file_lines = nil,
		            }
	          })
	      end
    },
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
    },
    {
	      "williamboman/mason.nvim",
	      url = "https://bgithub.xyz/williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall" },
        event  = "VeryLazy",
        lazy = true,
	      config = function()
	          require("mason").setup({})
	      end
    },
    {
	      "williamboman/mason-lspconfig.nvim",
	      url = "https://bgithub.xyz/williamboman/mason-lspconfig.nvim",
	      config = function()
	          require("mason-lspconfig").setup({
		            ensure_installed = { "lua_ls", "rust_analyzer", },
	          })
	      end
    },
    {
	      "neovim/nvim-lspconfig",
	      url = "https://bgithub.xyz/neovim/nvim-lspconfig",
        event = "User FileOpened",
        config = function() 
            local lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 启用on_attach
            local on_attach = function(c, b)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = b })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = b })
            end

            -- 具体语言服务器
            lsp.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    }
                }
            })

            lsp.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ['rust_analyzer'] = {
                        checOnsave = { command = "clippy" },
                        procMacro = { enabled = true },
                    }
                }
            })
            
            lsp.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=never",
                    "--query-driver=/usr/bin/clang++",
                }
            })

            vim.diagnostic.config({
                virtual_text = {
                    source = "if_many", -- 
                    format = function(diag)
                        return string.format("%s (%s)", diag.message, diag.source)
                    end
                },
                float = {
                    border = "rounded",
                    source = "always" -- 显示错误来源
                },
                signs = true,      -- 侧边栏符号
                update_in_insert = true -- 插入模式更新
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        url = "https://bgithub.xyz/hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require'cmp'
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- luasnip 补全
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback() -- 保留默认 Tab 行为
                        end
                    end, { 'i', 's' }),
                    
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback() -- 保留默认 Tab 行为
                        end
                    end, { 'i', 's' }),

                    ['<CR>'] = cmp.mapping.confirm({
                    	behavior = cmp.ConfirmBehavior.Replace,
                    	select = false
                    }),

                    ['<C-f>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.abort()
                        vim.api.nvim_echo({{ '补全取消了', 'WarningMsg' }}, false, {})
                    end
                end)
            }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    -- { "vsnip" },
                    { name = "luasnip"},
                    -- { "ultisnips" },
                    -- { "snippy" },
                },
                {
                    { name = 'buffer' },
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert"
                }
            })
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        url = "https://bgithub.xyz/hrsh7th/cmp-nvim-lsp",
        lazy = true,
    },
    {
        "hrsh7th/cmp-buffer",
        url = "https://bgithub.xyz/hrsh7th/cmp-buffer",
        lazy = true,
    },
    {
        "folke/trouble.nvim",
        url = "https://bgithub.xyz/folke/trouble.nvim",
        lazy = true,
        opts = {},
        cmd = "Trouble"
    },
    {
        "saadparwaiz1/cmp_luasnip",
        url = "https://bgithub.xyz/saadparwaiz1/cmp_luasnip",
        lazy = true,
    },
    {
        "L3MON4D3/LuaSnip",
        url = "https://bgithub.xyz/L3MON4D3/LuaSnip",
        lazy = true,
        version = "2.*",
        dependencies = {
            "rafamadriz/friendly-snippets"
        },
        config = function ()
            require("luasnip").setup({
                history = true,
                update_event = "TextChanged,TextChangedI"
            })

            require("luasnip.loaders.from_vscode").lazy_load({
                include = { "rust", "lua" },

                override = function(table1, table2)
                    return vim.tbl_deep_extend("keep", table1, table2)
                end
            })
        end
    },
    {
        "rafamadriz/friendly-snippets",
        url = "https://bgithub.xyz/rafamadriz/friendly-snippets",
        lazy = true,
    },
    {
        "echasnovski/mini.nvim",
        url = "https://bgithub.xyz/echasnovski/mini.nvim",
        version = "*",
        lazy = true,
        config = function() end
    },
    {
        "akinsho/toggleterm.nvim",
        url = "https://bgithub.xyz/akinsho/toggleterm.nvim",
        keys = "<C-\\>",
        lazy = true,
        config = function ()
            require('toggleterm').setup({
                open_mapping = [[<C-\>]],
                shell = "fish",
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        ft = fts,
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "nvzone/volt",
        url = "https://bgithub.xyz/nvzone/volt",
        lazy = true,
    },
    {
        "nvzone/minty",
        url = "https://bgithub.xyz/nvzone/minty",
        cmd = { "Shades", "Huefy" },
        lazy = true,
        ft = fts
    },
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
        "folke/snacks.nvim",
        url = "https://bgithub.xyz/folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        
        --@type snacks.Config
        opts = {
            bigfile = { enabled = true, },
            dashboard = {
                    sections = {
                      { section = "header" },
                      {
                        pane = 2,
                        pane_gap = 4,
                        section = "terminal",
                        cmd = "fastfetch",
                        height = 5,
                        padding = 1,
                      },
                      { section = "keys", gap = 1, padding = 1 },
                      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                      { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                      {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                          return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                      },
                      { section = "startup" },
                    },
                  
            },
            explorer = { enabled = false, }
        },
        keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        -- LSP
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        -- Other
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        }
    },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
    },
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
        dependencies = { "MunifTanjim/nui.nvim" },
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
        "folke/which-key.nvim",
        url = "https://bgithub.xyz/folke/which-key.nvim",
        event = "VeryLazy",
        opts= {},
        keys = {
            {
                "<leader>?",
                function ()
                    require("which-key").show({ blobal = false })
                end,
                desc = "Buffer Local Keymaps (which-key)"
            }
        }
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
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        lazy = true,
        url = "https://bgithub.xyz/MeanderingProgrammer/render-markdown.nvim",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
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
    {
        "nvim-neotest/nvim-nio",
        url = "https://bgithub.xyz/nvim-neotest/nvim-nio",
    },
    {
        "mfussenegger/nvim-lint",
        url = "https://bgithub.xyz/mfussenegger/nvim-lint",
        ft = fts,
        event = "VeryLazy",
        config = function ()
            require('lint')
        end
    }
}
