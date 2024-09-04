--WARNING: These functions are meant for windows' directories. Probably needs to be changed for linux/mac
local function FindNth(str, ch, N)
	local count = 0
	for a = 1, #str do
		local tmp = string.sub(str, a, a)
		if tmp == ch then count = count+1 end
		if count == N then return a end
	end
	return -1
end
local function DirectoryDepth(dir)
	local count = 0
	for a = 1, #dir do
		local ch = string.sub(dir, a, a)
		if ch == "\\" then count = count + 1 end
	end
	return count
end
local function RemoveConsecutiveDirectorySlash(dir)
	local out = ""
	local found = false
	for a = 1, #dir do
		if a ~= "\\" then
			out = out .. string.sub(dir, a, a)
			found = false
		elseif a == "\\" and not found then
			out = out .. "\\"
		else
			found = true
		end
	end
	return out
end

vim.keymap.set("n", "cwd", function()
	local cwd = RemoveConsecutiveDirectorySlash(vim.fn.getcwd() .. "\\")
	local depth = DirectoryDepth(cwd)
	local remCount = vim.v.count
	local remActual = (remCount >= depth) and 1 or (depth - remCount)
	local index = FindNth(cwd, "\\", remActual)
	local cwdActual = string.sub(cwd, 1, index)
	vim.fn.setreg("*", cwdActual)
end)

vim.keymap.set("n", "gt", function() vim.cmd("BufferGoto " .. vim.v.count) end)
vim.keymap.set("n", "<LEADER>tn", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<LEADER>tk", "<CMD>bd!<CR>")

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<LEADER>ff", function()
	local cwd = RemoveConsecutiveDirectorySlash(vim.fn.getcwd() .. "\\")
	local depth = DirectoryDepth(cwd)
	local remCount = vim.v.count
	local remActual = (remCount >= depth) and 1 or (depth - remCount)
	local index = FindNth(cwd, "\\", remActual)
	local cwdActual = string.sub(cwd, 1, index)
	telescope_builtin.find_files({cwd = cwdActual})
end)
vim.keymap.set("n", "<LEADER>fb", function()
	local cwd = RemoveConsecutiveDirectorySlash(vim.fn.getcwd() .. "\\")
	local depth = DirectoryDepth(cwd)
	local remCount = vim.v.count
	local remActual = (remCount >= depth) and 1 or (depth - remCount)
	local index = FindNth(cwd, "\\", remActual)
	local cwdActual = string.sub(cwd, 1, index)
	telescope.extensions.file_browser.file_browser({cwd = cwdActual})
end)
