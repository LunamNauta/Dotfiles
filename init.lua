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
function ReloadNeovimStart()
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
function ReloadNeovimEnd()
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

--TODO: Remove config directory. Create new directory. Clone Github back to directory
--Details here: https://graphite.dev/guides/git-clone-existing-dir
--And here: https://stackoverflow.com/questions/7909167/how-to-quietly-remove-a-directory-with-content-in-powershell

function RemoveConfig()
	vim.fn.system({"powershell", "Remove-Item -LiteralPath " .. vim.fn.stdpath("config") .. "\\* -Force -Recurse"})
end

vim.api.nvim_create_user_command("ReloadNvim", ReloadNeovimStart, {})
vim.fn.timer_start(2000, ReloadNeovimEnd)
