return {{
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	opts = {
		flavour = "mocha",
		no_italic = true,
		no_bold = true,
		no_underline = false,
        transparent_background = true,
        term_colors = true,
        integrations = {
            native_lsp = {
                enabled = true
            },
            telescope = true,
            treesitter = true,
            barbar = true
        }
	}
}}
