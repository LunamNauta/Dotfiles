local languages = {}

languages.treesitter = {"cpp", "c", "lua"}
languages.lsp = {
	{
		name = "clangd",
		filetypes = {"cpp", "hpp", "tpp", "cc", "hh", "c", "h"}
	},
	{
		name = "lua_ls",
		filetypes = {"lua"}
	}
}
languages.lsp.GetNames = function()
	local out = {}
	for _, server in ipairs(languages.lsp) do
		table.insert(out, server.name)
	end
	return out
end

return languages
