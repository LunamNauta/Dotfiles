local utilities = require("utilities")
local noerr, ret = nil, nil

noerr, ret = pcall(require, "barbar")
if noerr then vim.keymap.set("n", "gt", function() vim.cmd("BufferGoto " .. vim.v.count) end)
else vim.notify(
	"Warning: Keymaps: Could not locate plugin 'barbar'. Failed to set keymaps: " .. ret,
	vim.log.levels.WARN
) end

noerr, ret = pcall(require, "telescope")
if noerr then
	local telescope = require("telescope")
	vim.keymap.set("n", "<LEADER>fb", function()
		local dir = utilities.OSIndependentPath(vim.fn.getcwd())
		dir = utilities.MoveUpDirectory(dir, vim.v.count)
		if vim.loop.os_uname().sysname == "Linux" then dir = "/" .. dir end
		telescope.extensions.file_browser.file_browser({cwd = dir})
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
		telescope_builtin.find_files({cwd = dir})
	end)
else vim.notify(
	"Warning: Keymaps: Could not locate plugin 'telescope.builtin'. Failed to set keymaps: " .. ret,
	vim.log.levels.WARN
) end

vim.keymap.set("n", "cwd", function()
	local dir = utilities.OSIndependentPath(vim.fn.getcwd())
	dir = utilities.MoveUpDirectory(dir, vim.v.count)
	vim.fn.setreg("*", dir)
end)
vim.keymap.set("n", "<LEADER>tn", function() vim.cmd("tabnew") end)
vim.keymap.set("n", "<LEADER>tk", function() vim.cmd("bdelete!") end)
