local languages = require("configs.languages")
return {{
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = languages.treesitter,
		highlight = {enable = true}
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end
}}
