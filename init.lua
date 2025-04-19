-- 加载基础配置
require("plugins")
require("configs.keymaps")
require("configs.options")
require("configs.autocmds")

-- 初始化lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://bgithub.xyz/folke/lazy.nvim.git",
	"--branch=stable", -- 稳定分支
	lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件配置
require("lazy").setup("plugins")
