local settings = require("configs.settings")
return {{
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/nvim-cmp"
	},
	config = function(_, _)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		for _, server in ipairs(settings.lsp.servers) do
			local tmpTable = {capabilities = capabilities}
			for a, b in pairs(server.opts) do tmpTable[a] = b end
			require("lspconfig")[server.name].setup(tmpTable)
		end
	end
}}
