vim.opt.number = true
vim.opt.autochdir = true
vim.opt.cmdheight = 0
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.clipboard = "unnamedplus"

require("configs.settings")
require("plugin_manager")
require("configs.keymaps")
require("configs.commands")
