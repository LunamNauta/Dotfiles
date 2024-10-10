vim.opt.number = true
vim.opt.autochdir = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.wrap = false
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--[[
vim.opt.shell = "pwsh"
vim.opt.shellxquote = ""
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"
--]]

vim.opt.shell = "bash"

vim.diagnostic.config({virtual_text = false})
