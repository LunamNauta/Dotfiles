local function CreateNewWindowProcess(process)
    if WVim.is_windows then return "Start-Process pwsh '-Command', {" .. process .. "}"
    else return process .. " &" end
end

vim.api.nvim_create_user_command("EditConfig", function()
    if WVim.is_windows then vim.cmd("e " .. vim.fn.stdpath("config") .. "\\init.lua") end
    vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
end, {})

vim.api.nvim_create_user_command("ReloadConfig", function()
    local cwd = vim.fn.expand("%:p")
    vim.cmd("!" .. CreateNewWindowProcess("nvim " .. cwd))
    vim.cmd("q!")
end, {})
