return {{
	"nvim-treesitter/nvim-treesitter",
	main = "nvim-treesitter.configs",
	event = "VeryLazy",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {"cpp", "c", "lua"},
		highlight = {enable = true}
	}
}}
