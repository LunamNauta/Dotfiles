require("configs.settings")
require("plugin_manager")

require("configs.keymaps")
require("configs.commands")

local noerr = nil
noerr, ret = pcall(function() vim.cmd.colorscheme(vim.g.wreath.colorscheme) end)
if not noerr then vim.notify(
	"Error: Failed to load colorscheme '" .. vim.g.wreath.colorscheme .. "': " .. ret,
	vim.log.levels.WARN
) end
