vim.api.nvim_create_user_command("UploadConfig", function()
    local cwd = vim.fn.stdpath("config")
    vim.cmd("cd " .. cwd)
    if vim.fn.isdirectory(cwd .. "\\.git") == 0 then
	    vim.cmd("!git init " .. " --initial-branch=main")
	    vim.cmd("silent !sleep 1")
	    vim.cmd("!git remote add origin https://github.com/LunamNauta/NeovimDotfiles")
	    vim.cmd("silent !sleep 1")
    end
    vim.cmd("silent !git add -A ")
    vim.cmd("silent !sleep 1")
    vim.cmd("!git commit -m \"Update from 'UploadConfig' (" .. os.date("%Y-%m-%d %H:%M:%S") .. ")\"")
    vim.cmd("silent !sleep 1")
    vim.cmd("!git push -u origin main")
    vim.cmd("silent !sleep 1")
end, {})
vim.api.nvim_create_user_command("DownloadConfig", function()
    local cwd = vim.fn.stdpath("config")
    vim.cmd("cd " .. cwd)
    if vim.fn.isdirectory(cwd .. "\\.git") == 0 then
        vim.notify("Error: 'DownloadConfig': Configuration file is not a git repository. Cannot download from GitHub")
        return
    end
    local cmd1 = "Remove-Item " .. cwd .. "\\* -Recurse -Force"
    local cmd2 = "git clone https://github.com/LunamNauta/NeovimDotfiles " .. cwd
    vim.fn.jobstart(cmd1 .. " ; " .. cmd2)
end, {})
