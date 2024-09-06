local utilities = require("utilities")
local noerr, ret = nil, nil

noerr, ret = pcall(require, "nvim-treesitter.parsers")
if noerr then
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
else vim.notify(
	"Warning: Commands: Could not locate plugin 'nvim-treesitter.parsers': " .. ret,
	vim.log.levels.WARN
) end

vim.api.nvim_create_user_command("EditConfig", function() vim.cmd("edit " .. vim.fn.stdpath("config") .. "\\init.lua") end, {})
vim.api.nvim_create_user_command("DownloadConfig", utilities.DownloadConfig, {})
vim.api.nvim_create_user_command("UploadConfig", utilities.UploadConfig, {})
vim.api.nvim_create_user_command("ReloadConfig", utilities.ReloadConfig, {})
vim.fn.timer_start(2000, utilities.UnlockReload)
