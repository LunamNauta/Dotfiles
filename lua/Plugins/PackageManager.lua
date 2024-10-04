local languages = require("Settings.Languages")
return {{
	"williamboman/mason.nvim",
	dependencies = {
    	"williamboman/mason-lspconfig.nvim",
    	"neovim/nvim-lspconfig"
	},
	event = "VeryLazy",
	opts = {
		mason = {},
		mason_lsp = {
			ensure_installed = languages.mason_lsp
		}
	},
	config = function(_, opts)
		local mason = require("mason")
		local mason_lsp = require("mason-lspconfig")
		mason.setup(opts.mason)
		mason_lsp.setup(opts.mason_lsp)
	end
}}
