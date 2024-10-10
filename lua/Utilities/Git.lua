local repo = (WVim.is_windows and "https://github.com/" or "git@github.com:") .. "LunamNauta/NeovimDotfiles" .. (WVim.is_windows and ".git" or "")
local branch = "testing"

--Identical functionality for Linux vs. Windows
--Identical implementation for Linux vs. Windows
local function SleepN(n) return "sleep " .. n end

--Identical functionality for Linux vs. Windows
--Different implementation for Linux vs. Windows
local function JoinPath(p1, p2)
    if WVim.is_windows then return p1 .. "\\" .. p2 end
    return p1 .. "/" .. p2
end

--Different functionality for Linux vs. Windows
--Different implementation for Linux vs. Windows
--On Windows, this just removes all the items under the CWD
--On Linux, this removes the CWD outright
local function RemoveCWD(cwd)
    if WVim.is_windows then return "Remove-Item " .. JoinPath(cwd, "*") .. " -Recurse -Force" end
    return "rm -rf " .. cwd
end

function UploadConfig(opts)
    opts.args = string.gsub(opts.args, "\"", "'")
    local cwd = vim.fn.stdpath("config")
    local oldCwd = vim.loop.cwd()
    vim.cmd("cd " .. cwd)
    if vim.fn.isdirectory(JoinPath(cwd, ".git")) == 0 then
	    vim.cmd("!git init " .. " --initial-branch=" .. branch)
	    vim.cmd("silent !" .. SleepN(1))
	    vim.cmd("!git remote add origin " .. repo)
	    vim.cmd("silent !" .. SleepN(1))
    end
    vim.cmd("silent !git add -A ")
    vim.cmd("silent !" .. SleepN(1))
    local timeMessage = "Update from 'UploadConfig' (" .. os.date("%Y-%m-%d %H:%M:%S") .. ")"
    vim.cmd("!git commit -m \"" .. timeMessage .. " : " .. opts.args .. "\"")
    vim.cmd("silent !" .. SleepN(1))
    vim.cmd("!git push -u origin " .. branch)
    vim.cmd("silent !" .. SleepN(1))
    vim.cmd("cd " .. oldCwd)
end

vim.api.nvim_create_user_command("UploadConfig", UploadConfig, {nargs = "?"})
vim.api.nvim_create_user_command("DownloadConfig", function()
    local cwd = vim.fn.stdpath("config")
    local oldCwd = vim.loop.cwd()
    vim.cmd("cd " .. cwd)
    if vim.fn.isdirectory(JoinPath(cwd, ".git")) == 0 then
        vim.notify("Error: 'DownloadConfig': Configuration file is not a git repository. Cannot download from GitHub")
        return
    end

    --vim.cmd("cd " .. vim.fn.stdpath("data"))
    vim.cmd("!git pull origin " .. branch)

    --[[
    if not WVim.is_windows then vim.cmd("cd " .. vim.fn.stdpath("data")) end
    vim.cmd("!" .. RemoveCWD(cwd))
    if not WVim.is_windows then vim.cmd("!mkdir " .. cwd) end
    vim.cmd("!git clone -b " .. branch .. " " .. repo .. " " .. cwd)
    vim.cmd("cd " .. oldCwd)
    --]]
end, {})
