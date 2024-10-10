vim.api.nvim_create_user_command("EditConfig", function()
    if WVim.is_windows then vim.cmd("e " .. vim.fn.stdpath("config") .. "\\init.lua") end
    vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
end, {})
