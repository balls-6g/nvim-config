-- 主键为空格
vim.g.mapleader = " "

-- -------- 正常模式 -------- --
-- 正常模式分屏
vim.keymap.set("n", "<leader>tv", "<C-w>v")
vim.keymap.set("n", "<leader>tw", "<C-w>s")

-- 打开/关闭文件树
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- 屏幕切换
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- 命令模式切换
vim.keymap.set("n", ";", ":")

-- 标签页切换
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

-- 切换是否透明
vim.keymap.set("n", "<ESC>", ":TransparentToggle<CR>")

-- 保存映射
vim.keymap.set("n", "<C-s>", ":w<CR>")
