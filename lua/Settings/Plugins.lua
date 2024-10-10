local noerr = nil
local catppuccin = nil

noerr, catppuccin = pcall(require, "catppuccin")
if noerr then vim.cmd.colorscheme("catppuccin")
else vim.notify("Warning: Could not find plugin 'catppuccin'", vim.log.levels.WARN) end
