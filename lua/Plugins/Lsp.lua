return {{
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function(_, _)
		local languages = require("Settings.Languages")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")
		local defaultCapabilities = cmp_nvim_lsp.default_capabilities()
		for _, server in ipairs(languages.mason_lsp) do
			local opts = languages.mason_lsp_opts[server]
			opts.capabilities = defaultCapabilities
			lspconfig[server].setup(opts)
		end
	end
}}
