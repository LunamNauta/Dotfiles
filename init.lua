--TODO: Fix issue where neovim instantiations started from pwsh.exe do not allow for reloading
--If Neovim is opened from anywhere other than the nvim.exe, using open with on windows, shell commands fail

--TODO: Remove extra vim.fn.system("sleep 1")'s
--These function calls exist because without them, the shell functions sometimes, for whatever reason, fail
--Perhaps it has something to do with the shell not finishing a previous command? I don't know how to deal with that
--Sleeping the thread is easier than trying to find a better solution

require("plugin_manager")
require("configs.keymaps")

vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autochdir = true
vim.o.wrap = false
vim.o.cmdheight = 0
vim.o.foldenable = false
vim.o.clipboard = "unnamedplus"

vim.o.shell = "pwsh"
vim.o.shellcmdflag = "-command"
vim.o.shellxquote = ''

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
		vim.cmd("bufdo edit!")
		vim.fn.system("Start-Process nvim " .. path)
		vim.fn.system("Stop-Process -Id " .. pid)
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
		vim.fn.system("git fetch origin")
		vim.fn.system("sleep 1")
		vim.fn.system("git reset --hard origin/main")
		vim.fn.system("sleep 1")
		ReloadConfigStart()
		return
	end
	vim.fn.system("Remove-Item " .. vim.fn.stdpath("config") .. "\\* -Recurse -Force")
	vim.fn.system("sleep 1")
	vim.fn.system("git clone " .. config_github_url .. " " .. vim.fn.stdpath("config"))
	vim.fn.system("sleep 1")
	ReloadConfigStart()
end

function UploadConfig()
	if vim.fn.isdirectory(vim.fn.stdpath("config") .. "\\.git") ~= 0 then
		vim.fn.system("cd " .. vim.fn.stdpath("config"))
		vim.fn.system("sleep 1")
		vim.fn.system("git add -A")
		vim.fn.system("sleep 1")
		vim.fn.system("git commit -m \"Neovim config updater\"")
		vim.fn.system("sleep 1")
		vim.fn.system("git push origin main")
		vim.fn.system("sleep 1")
		ReloadConfigStart()
		return
	end
	vim.print("Error: Cannot upload config to remote repository. Remote repository was never cloned")
end

vim.api.nvim_create_user_command("EditConfig", function() vim.cmd("edit " .. vim.fn.stdpath("config") .. "\\init.lua") end, {})
vim.api.nvim_create_user_command("DownloadConfig", DownloadConfig, {})
vim.api.nvim_create_user_command("UploadConfig", UploadConfig, {})
vim.api.nvim_create_user_command("ReloadConfig", ReloadConfigStart, {})
vim.fn.timer_start(2000, ReloadConfigEnd)
