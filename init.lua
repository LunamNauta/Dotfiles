--TODO: Add support for loading (and uploading) dot files to github
--TODO: When reloading the config, write to all open buffers (or at least remove all changes before reloading)

require("plugin_manager")
require("configs.keymaps")

vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autochdir = true
vim.o.wrap = false
vim.o.cmdheight = 0
vim.o.shell = "pwsh"

vim.o.clipboard = "unnamedplus"

--TODO: This only works for files supported by treesitter. Use AutoCommand with FileType to select syntax/indent method if treesitter is unavailable. See here: https://stackoverflow.com/questions/77220511/neovim-fold-code-with-foldmethod-syntax-or-foldmethod-expr-depending-on-tre
vim.o.foldlevel = 999
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

local reload_lock_path = vim.fn.stdpath("config") .. "\\reload-lock.txt"
function ReloadConfigStart()
	local file = io.open(reload_lock_path, "a+")
	if not file then
		vim.print("Error: Could not load reload-lock. Cannot start new instance")
		return
	end

	local line = file:read("*l")
	if not line or line == "unlocked" then
		vim.print("Reloading Neovim instance")
		file:close()
		file = io.open(reload_lock_path, "w+")
		if not file then
			vim.print("Error: Could not write to reload-lock. Cannot start new instance")
			return
		end
		file:write("locked\n")
		file:close()
		local pid = vim.fn.getpid()
		local path = vim.fn.expand("%:p")
		vim.fn.system({"powershell", "Start-Process powershell \"nvim " .. path .. "\" ; Stop-Process -Id " .. pid})
	end
end
function ReloadConfigEnd()
	local file = io.open(reload_lock_path, "r")
	if not file then
		vim.print("Error: Could not load reload-lock. Cannot unlock reload")
		return
	end

	local line = file:read("*l")
	if line == "locked" then
		file:close()
		file = io.open(reload_lock_path, "w+")
		if not file then
			vim.print("Error: Could not write to reload-lock. Cannot unlock reload")
			return
		end
		file:write("unlocked\n")
		file:close()
		vim.print("Neovim instance reloaded/unlocked")
	end
end

--[[
TODO: 
	Holy fucking shit, this is a mess
	What in the hell was I thinking
	Rewrite this garbage using proper git commands like "git pull" and "git push"
	This cloning bullshit only needs to be done on the first load
	You only need to pull in the one folder, as well
--]]--
local config_github_url = "https://github.com/LunamNauta/Dotfiles"
local config_github_nvim_folder = vim.fn.stdpath("config") .. "\\nvim"
function DownloadConfig()
	vim.fn.system({"powershell", "Remove-Item " .. vim.fn.stdpath("config") .. "\\* -Recurse -Force"})
	vim.fn.system({"powershell", "git clone " .. config_github_url .. " " .. vim.fn.stdpath("config")})
	vim.fn.system({"powershell", "Move-Item -Path " .. config_github_nvim_folder .. "\\* -Destination " .. vim.fn.stdpath("config")})
	vim.fn.system({"powershell", "Remove-Item " .. config_github_nvim_folder .. " -Force"})
	ReloadConfigStart()
end

--TODO: Check if .git folder exists
function UploadConfig()
	--vim.fn.system({"powershell", "New-Item -Path " .. vim.fn.stdpath("config") .. " -Name nvim -ItemType \"directory\""})
	--vim.fn.system({"powershell", "Get-ChildItem -Path " .. vim.fn.stdpath("config") .. " | Where-Object {$_.Name -notin @(\"nvim\", \".git\")} | ForEach-Object {Move-Item -Path $_.FullName -Destination " .. config_github_nvim_folder .. "}"})
	vim.fn.system({"powershell", "cd " .. vim.fn.stdpath("config") .. " ; " .. "git add -A ; git commit -m \"Neovim config updater\" ; git push origin main"})
	--vim.fn.system({"powershell", "Move-Item -Path " .. config_github_nvim_folder .. "\\* -Destination " .. vim.fn.stdpath("config")})
	--vim.fn.system({"powershell", "Remove-Item " .. config_github_nvim_folder .. " -Force"})
	--ReloadConfigStart()
end

vim.api.nvim_create_user_command("DownloadConfig", DownloadConfig, {})
vim.api.nvim_create_user_command("UploadConfig", UploadConfig, {})
vim.api.nvim_create_user_command("ReloadConfig", ReloadConfigStart, {})
vim.fn.timer_start(2000, ReloadConfigEnd)
