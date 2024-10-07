function SplitString(str, sep)
    if sep == nil or sep == "" then return {str} end
    local output = {}
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(str, pattern, function(sub) table.insert(output, sub) end)
    return output
end
function FileExists(file)
    local tmp = io.open(file, "rb")
    if tmp then tmp:close() end
    return tmp ~= nil
end
function LinesFromFile_Arr(file)
    if not FileExists(file) then
        vim.notify("Error: Could not find file '" .. file .. "'", vim.log.levels.ERROR, {})
        return {}
    end
    local lines = {}
    for line in io.lines(file) do table.insert(lines, line) end
    return lines
end
function LinesFromFile_Str(file)
    if not FileExists(file) then
        vim.notify("Error: Could not find file '" .. file .. "'", vim.log.levels.ERROR, {})
        return {}
    end
    local lines = ""
    for line in io.lines(file) do lines = lines .. line .. "\n" end
    if #lines ~= 0 then lines = lines:sub(1, #lines-1) end
    return lines
end
function GetDefaultFile(opts)
    local args = SplitString(opts.args, " ")
    if #args[1] == 0 then return end
    local str = LinesFromFile_Str(vim.fn.stdpath("config") .. "\\DefaultFiles\\" .. args[1])
    vim.api.nvim_paste(str, false, -1)
end
vim.api.nvim_create_user_command("GetDefaultFile", GetDefaultFile, {nargs = "?"})
