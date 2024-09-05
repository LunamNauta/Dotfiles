local languages = {}

languages.treesitter = {"cpp", "c", "lua"}
languages.lsp = {
	{
		name = "clangd",
		opts = {
			filetypes = {"cpp", "hpp", "tpp", "cc", "hh", "c", "h"}
		}
	},
	{
		name = "lua_ls",
		opts = {
			filetypes = {"lua"},
			settings = {
				Lua = {
        			diagnostics = {
						globals = {"vim"},
        			}
				}
			}
		}
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
