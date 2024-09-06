return {{
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	opts = {
		ensure_installed = vim.g.wreath.languages.treesitter,
		highlight = {enable = true}
	}
}}
