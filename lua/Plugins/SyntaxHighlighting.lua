local languages = require("Settings.Languages")
return {{
	"nvim-treesitter/nvim-treesitter",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = languages.treesitter,
		highlight = {enable = true}
	}
}}
