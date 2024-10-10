return {{
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function(_, _)
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")

		local defaultCapabilities = cmp_nvim_lsp.default_capabilities()
        local defaultHandlers = {
	        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"}),
        }
		for _, server in ipairs(WVim.languages.mason_lsp) do
			local opts = WVim.languages.mason_lsp_opts[server]
			opts.capabilities = defaultCapabilities
            opts.handlers = defaultHandlers
			lspconfig[server].setup(opts)
		end
	end
}}
