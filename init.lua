--TODO: When reloading the config, write to all open buffers (or at least remove all changes before reloading)

require("plugin_manager")
require("configs.keymaps")

vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autochdir = true
vim.o.wrap = false
vim.o.cmdheight = 0
vim.o.foldenable = false
vim.o.shell = "pwsh"

vim.o.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd({"FileType"}, {
	callback = function()
    	if require("nvim-treesitter.parsers").has_parser() then
      		vim.o.foldmethod = "expr"
      		vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    	else
      		vim.o.foldmethod = "syntax"
    	end
  	end
})

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

local config_github_url = "https://github.com/LunamNauta/NeovimDotfiles"
function DownloadConfig()
	if vim.fn.isdirectory(vim.fn.stdpath("config") .. "\\.git") ~= 0 then
		vim.fn.system({"powershell", "git pull origin main"})
		ReloadConfigStart()
		return
	end
	vim.fn.system({"powershell", "Remove-Item " .. vim.fn.stdpath("config") .. "\\* -Recurse -Force"})
	vim.fn.system({"powershell", "sleep 1 ; git clone " .. config_github_url .. " " .. vim.fn.stdpath("config")})
	ReloadConfigStart()
end

function UploadConfig()
	if vim.fn.isdirectory(vim.fn.stdpath("config") .. "\\.git") ~= 0 then
		vim.fn.system({"powershell", "cd " .. vim.fn.stdpath("config") .. " ; " .. "git add -A ; git commit -m \"Neovim config updater\" ; git push origin main"})		ReloadConfigStart()
		return
	end
	vim.print("Error: Cannot upload config to remote repository. Remote repository was never cloned")
end

vim.api.nvim_create_user_command("DownloadConfig", DownloadConfig, {})
vim.api.nvim_create_user_command("UploadConfig", UploadConfig, {})
vim.api.nvim_create_user_command("ReloadConfig", ReloadConfigStart, {})
vim.fn.timer_start(2000, ReloadConfigEnd)
