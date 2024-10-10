local branch = WVim.is_windows and "main" or "linux"

local function JoinPath(p1, p2)
    if WVim.is_windows then return p1 .. "\\" .. p2 end
    return p1 .. "/" .. p2
end
local function JoinCommand(c1, c2)
    if WVim.is_windows then return c1 .. " ; " .. c2 end
    return c1 .. " && " .. c2
end

local function RemoveCWD(cwd)
    if WVim.is_windows then return "Remove-Item " .. JoinPath(cwd, "*") .. " -Recurse -Force" end
    return "rm -rf " .. cwd --JoinPath(cwd, "*")
end
local function AddCWD(cwd)
    if WVim.is_windows then end
    return "mkdir " .. cwd
end
local function SleepN(n)
    return "sleep " .. n
end

vim.api.nvim_create_user_command("UploadConfig", function()
    local cwd = vim.fn.stdpath("config")
    local oldCwd = vim.loop.cwd()
    vim.cmd("cd " .. cwd)
    if vim.fn.isdirectory(JoinPath(cwd, ".git")) == 0 then
	    vim.cmd("!git init " .. " --initial-branch=" .. branch)
	    vim.cmd("silent !" .. SleepN(1))
	    vim.cmd("!git remote add origin git@github.com:LunamNauta/NeovimDotfiles.git")
	    vim.cmd("silent !" .. SleepN(1))
    end
    vim.cmd("silent !git add -A ")
    vim.cmd("silent !" .. SleepN(1))
    vim.cmd("!git commit -m \"Update from 'UploadConfig' (" .. os.date("%Y-%m-%d %H:%M:%S") .. ")\"")
    vim.cmd("silent !" .. SleepN(1))
    vim.cmd("!git push -u origin " .. branch)
    vim.cmd("silent !" .. SleepN(1))
    vim.cmd("cd " .. oldCwd)
end, {})
vim.api.nvim_create_user_command("DownloadConfig", function()
    local cwd = vim.fn.stdpath("config")
    local oldCwd = vim.loop.cwd()
    vim.cmd("cd " .. cwd)
    if vim.fn.isdirectory(JoinPath(cwd, ".git")) == 0 then
        vim.notify("Error: 'DownloadConfig': Configuration file is not a git repository. Cannot download from GitHub")
        return
    end
    --local cmd2 = "git clone git@github.com:LunamNauta/NeovimDotfiles.git " .. cwd
    --vim.fn.jobstart(JoinCommand(RemoveCWD(cwd), cmd2))
    vim.cmd("!" .. RemoveCWD(cwd))
    vim.cmd("!" .. AddCWD(cwd))
    vim.cmd("!git clone git@github.com:LunamNauta/NeovimDotfiles.git " .. cwd)
    vim.cmd("cd " .. oldCwd)
end, {})
