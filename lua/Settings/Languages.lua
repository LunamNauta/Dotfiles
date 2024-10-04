local languages = {}
languages.treesitter = {"cpp", "c", "lua", "python", "rust"}
languages.mason_lsp = {"clangd", "lua_ls", "pylsp", "rust_analyzer"}
languages.mason_lsp_opts = {
	["clangd"] = {},
	["lua_ls"] = {},
	["pylsp"] = {},
	["rust_analyzer"] = {}
}
return languages
