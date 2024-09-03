local languages = require("configs.languages")
return {{
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/nvim-cmp"
	},
	config = function(_, _)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
  		for _, server in ipairs(languages.lsp) do
			require("lspconfig")[server.name].setup({
    			capabilities = capabilities,
				filetypes = server.filetypes
  			})
		end
	end
}}
