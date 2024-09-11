local settings = require("configs.settings")
local utilities = require("utilities")
local noerr, ret = nil, nil

vim.keymap.set("n", "<LEADER>tn", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<LEADER>tk", "<CMD>bdelete<CR>")

vim.keymap.set("n", "cwd", function()
	local dir = utilities.OSIndependentPath(vim.fn.getcwd())
	dir = utilities.MoveUpDirectory(dir, vim.v.count)
	vim.fn.setreg("+", dir)
end)

noerr, _ = pcall(require, settings.colorscheme)
if not noerr then vim.notify("Warning: Could not find plugin 'catppuccin'", vim.log.levels.WARN)
else vim.cmd.colorscheme(settings.colorscheme) end

noerr, ret = pcall(require, "telescope")
if noerr then
	local telescope = require("telescope")
	vim.keymap.set("n", "<LEADER>fb", function()
		local dir = utilities.OSIndependentPath(vim.fn.getcwd())
		dir = utilities.MoveUpDirectory(dir, vim.v.count)
		telescope.extensions.file_browser.file_browser({cwd = dir, hidden = true, no_ignore = true})
	end)
else vim.notify(
	"Warning: Keymaps: Could not locate plugin 'telescope'. Failed to set keymaps: " .. ret,
	vim.log.levels.WARN
) end

noerr, ret = pcall(require, "telescope.builtin")
if noerr then
	local telescope_builtin = require("telescope.builtin")
	vim.keymap.set("n", "<LEADER>ff", function()
		local dir = utilities.OSIndependentPath(vim.fn.getcwd())
		dir = utilities.MoveUpDirectory(dir, vim.v.count)
		telescope_builtin.find_files({cwd = dir, hidden = true, no_ignore = true})
	end)
else vim.notify(
	"Warning: Keymaps: Could not locate plugin 'telescope.builtin'. Failed to set keymaps: " .. ret,
	vim.log.levels.WARN
) end

noerr, _ = pcall(require, "transparent")
if not noerr then vim.notify("Warning: Could not find plugin 'transparent'", vim.log.levels.WARN)
else
	vim.keymap.set("n", "<LEADER>entran", "<CMD>TransparentEnable<CR>")
	vim.keymap.set("n", "<LEADER>distran", "<CMD>TransparentDisable<CR>")
	vim.cmd("TransparentEnable")
end

noerr, _ = pcall(require, "barbar")
if not noerr then vim.notify("Warning: Could not find plugin 'barbar'", vim.log.levels.WARN)
else vim.keymap.set("n", "gt", function() vim.cmd("BufferGoto " .. vim.v.count) end) end
