-- 相对行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 防止包裹
vim.opt.wrap = false

-- 光标行
vim.opt.cursorline = true

-- 启用鼠标
vim.opt.mouse:append("a")

-- 使用系统剪贴板
vim.opt.clipboard:append("unnamedplus")

-- 默认分屏会在右和下
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 终端真颜色
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- 缩进
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- 代码光晕
vim.api.nvim_set_hl(0, "Normal", { fg = "#c3c7d1", bg = "#1e1e2e", blend = 10})
