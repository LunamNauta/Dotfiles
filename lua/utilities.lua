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
	if vim.fn.has("linux") ~= 0 and independentPath:sub(1,1) ~= '/' then independentPath = "/" .. independentPath
	elseif slashCount == 0 then return independentPath .. "/" end
    return independentPath
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

return utils
