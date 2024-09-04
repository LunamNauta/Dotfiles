--TODO: Add support for loading (and uploading) dot files to github

require("plugin_manager")
require("configs.keymaps")

vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autochdir = true
vim.o.cmdheight = 0
vim.o.shell = "pwsh"

vim.o.clipboard = "unnamedplus"

function ReloadNeovimStart()
	local file = io.open("reload-lock.txt", "a+")
	if not file then
		vim.print("Error: Could not load reload-lock. Cannot start new instance")
		return
	end

	local line = file:read("*l")
	if not line or line == "unlocked" then
		vim.print("Reloading Neovim instance")
		file:close()
		file = io.open("reload-lock.txt", "w+")
		file:write("locked\n")
		file:close()
		local pid = vim.fn.getpid()
		local path = vim.fn.expand("%:p")
		vim.fn.system({"powershell", "Start-Process powershell \"nvim " .. path .. "\" ; Stop-Process -Id " .. pid})
	end
end
function ReloadNeovimEnd()
	local file = io.open("reload-lock.txt", "r")
	if not file then
		vim.print("Error: Could not load reload-lock. Cannot unlock reload")
		return
	end

	local line = file:read("*l")
	if line == "locked" then
		file:close()
		file = io.open("reload-lock.txt", "w+")
		file:write("unlocked\n")
		file:close()
		vim.print("Neovim instance reloaded/unlocked")
	end
end

vim.api.nvim_create_user_command("ReloadNvim", ReloadNeovimStart, {})
vim.fn.timer_start(2000, ReloadNeovimEnd)

