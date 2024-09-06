vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cmdheight = 0
vim.opt.autochdir = true
vim.opt.wrap = false
vim.opt.foldenable = false
vim.opt.foldlevel = 99

vim.opt.clipboard = "unnamedplus"

vim.opt.shell = "pwsh"
vim.o.shellcmdflag = "-c"
vim.o.shellxquote = ""

local wreath = {
	colorscheme = "catppuccin",
	languages = {
		treesitter = {"cpp", "c", "lua"},
		lsp = {
			servers = {
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
									globals = {"vim"}
        							}
							}
						}
					}
				}
			}
		}
	}
}
wreath.languages.lsp.GetNames = function()
	local out = {}
	for _, server in ipairs(wreath.languages.lsp.servers) do
		table.insert(out, server.name)
	end
	return out
end
vim.g.wreath = wreath
