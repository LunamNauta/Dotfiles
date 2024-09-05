return {{
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip"
	},
	config = function(_, _)
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
        				luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end
			},
			mapping = cmp.mapping.preset.insert({
				["<TAB>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, {"i", "s"}),
				["<CR>"] = cmp.mapping.confirm({select = false, behavior = cmp.ConfirmBehavior.Replace})
			}),
			sources = cmp.config.sources({
				{name = "nvim_lsp"},
				{name = "luasnip"},
				{name = "buffer"}
			}),
			experimental = {
				ghost_text = true
			}
		})
		cmp.setup.cmdline({"/", "?"}, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {name = "buffer"}
		})
		cmp.setup.cmdline(":", {
    		mapping = cmp.mapping.preset.cmdline(),
    		sources = cmp.config.sources({
      			{name = "path"},
				{name = "cmdline"}
    		}),
    		matching = {disallow_symbol_nonprefix_matching = false}
  		})
	end
}}
