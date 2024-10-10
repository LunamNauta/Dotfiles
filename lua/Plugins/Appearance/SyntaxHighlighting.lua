return {{
	"nvim-treesitter/nvim-treesitter",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = WVim.languages.treesitter,
		highlight = {enable = true}
	}
}}
