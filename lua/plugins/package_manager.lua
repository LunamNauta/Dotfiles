local settings = require("configs.settings")
return {{
    "williamboman/mason.nvim",
    dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim"
	},
	opts = {
		lsp = {
			ensure_installed = settings.lsp.GetServerNames()
		}
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup(opts.lsp)
	end
}}
