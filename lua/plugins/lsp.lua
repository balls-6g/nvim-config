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
		            ensure_installed = { "lua_ls", "rust_analyzer", "gopls" },
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

            lsp.gopls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "gopls" },
                ft = { "go", "gomod", "gowork", "gotmpl" },
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceHolders = true,
                    }
                }
            }

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
}
