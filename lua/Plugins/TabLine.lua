return {{
	"romgrk/barbar.nvim",
    dependencies = {
    	"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons"
	},
	event = "VeryLazy",
    opts = {
    	animation = false,
		clickable = false,
		icons = {button = " "}
    }
}}
