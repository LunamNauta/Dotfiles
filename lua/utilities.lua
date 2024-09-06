local utils = {}

utils.OSIndependentPath = function(dependentPath)
    local reg = "[/\\]"
    local independentPath = ""
    local pCharWasnt = false
    local slashCount = 0
    for a = 1, #dependentPath do
        local isSlash = dependentPath:sub(a,a):match(reg)
        if isSlash and pCharWasnt then
            independentPath = independentPath .. "/"
            slashCount = slashCount + 1
        elseif not isSlash then independentPath = independentPath .. dependentPath:sub(a,a) end
        pCharWasnt = not isSlash
    end
    if slashCount == 0 then return independentPath .. "/"
    else return independentPath end
end
utils.MoveUpDirectory = function(path, count)
    path = utils.OSIndependentPath(path)
    if path:sub(#path,#path) == "/" then path = path:sub(1, #path-1) end
    for a = 1, count do
        local last = path:match(".*/")
        if last then path = path:sub(1, #last-1)
        else break end
    end
    if path:sub(#path,#path) ~= "/" then return path .. "/"
    else return path end
end

local reloadLockPath = vim.fn.stdpath("config") .. "\\reload-lock.txt"
utils.LockReload = function()
	local file = io.open(reloadLockPath, "a+")
	if not file then
		vim.notify(
			"Error: Could not load reload-lock. Cannot lock reload file",
			vim.log.levels.ERROR
		)
		return false
	end
	local line = file:read("*l")
	if not line or line == "unlocked" then
		file:close()
		file = io.open(reloadLockPath, "w+")
		if not file then
			vim.notify(
				"Error: Could not load reload-lock. Cannot lock reload file",
				vim.log.levels.ERROR
			)
			return false
		end
		file:write("locked\n")
		file:close()
		return true
	end
	return false
end
utils.UnlockReload = function()
	local file = io.open(reloadLockPath, "r")
	if not file then
		vim.notify(
			"Error: Could not load reload-lock. Cannot unlock reload file",
			vim.log.levels.ERROR
		)
		return false
	end
	local line = file:read("*l")
	if line == "locked" then
		file:close()
		file = io.open(reloadLockPath, "w+")
		if not file then
			vim.notify(
				"Error: Could not write to reload-lock. Cannot unlock reload file",
				vim.log.levels.ERROR
			)
			return false
		end
		file:write("unlocked\n")
		file:close()
		vim.print("Neovim instance reloaded/unlocked")
		return true
	end
	return false
end
--TODO: Fix issue where a Neovim instance running in pwsh isn't killed. A new instance is created, but the old one fails to die
utils.ReloadConfig = function()
	if utils.LockReload() then
		local pid = vim.fn.getpid()
		local path = vim.fn.expand("%:p")
		vim.cmd("bufdo edit!")
		vim.fn.system("Start-Process pwsh -ArgumentList \"-Command nvim " .. path .. "\"")
		vim.fn.system("Stop-Process -Id " .. pid)
	end
end

--TODO: Check the state of the reload-lock file, and don't allow downloads or uploads until Neovim has been unlocked
--TODO: Call git functions as pwsh jobs. Wait for each one to finish instead of blindly waiting 1 second before each command
local configGithubURL = "https://github.com/LunamNauta/NeovimDotfiles"
utils.DownloadConfig = function()
	if vim.fn.isdirectory(vim.fn.stdpath("config") .. "\\.git") ~= 0 then
		vim.fn.system("git fetch origin")
		vim.fn.system("sleep 1")
		vim.fn.system("git reset --hard origin/main")
		vim.fn.system("sleep 1")
		utils.ReloadConfig()
		return
	end
	vim.fn.system("Remove-Item " .. vim.fn.stdpath("config") .. "\\* -Recurse -Force")
	vim.fn.system("sleep 1")
	vim.fn.system("git clone " .. configGithubURL .. " " .. vim.fn.stdpath("config"))
	vim.fn.system("sleep 1")
	utils.ReloadConfig()
end
utils.UploadConfig = function()
	if vim.fn.isdirectory(vim.fn.stdpath("config") .. "\\.git") ~= 0 then
		vim.fn.system("cd " .. vim.fn.stdpath("config"))
		vim.fn.system("sleep 1")
		vim.fn.system("git add -A")
		vim.fn.system("sleep 1")
		vim.fn.system("git commit -m \"Neovim config updater\"")
		vim.fn.system("sleep 1")
		vim.fn.system("git push origin main")
		vim.fn.system("sleep 1")
		utils.ReloadConfig()
		return
	end
	vim.print("Error: Cannot upload config to remote repository. Remote repository was never cloned")
end

return utils
