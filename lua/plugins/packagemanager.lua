return {{
    "williamboman/mason.nvim",
    dependencies = {"williamboman/mason-lspconfig.nvim"},
	opts = {
		lsp = {
			ensure_installed = vim.g.wreath.languages.lsp.GetNames()
		}
	},
	config = function(_, opts)
		require("mason").setup(opts.reg)
		require("mason-lspconfig").setup(opts.lsp)
	end
}}
