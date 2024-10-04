vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autochdir = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autoindent = true
vim.opt.cmdheight = 1

vim.opt.shell = "pwsh"
vim.o.shellxquote = ""
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.o.shellquote = ""
vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
vim.o.shellredir = "| Out-File -Encoding UTF8 %s"
