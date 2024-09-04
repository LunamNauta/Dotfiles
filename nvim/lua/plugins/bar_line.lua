return {{
	"romgrk/barbar.nvim",
    dependencies = {
    	"lewis6991/gitsigns.nvim",
    	"nvim-tree/nvim-web-devicons"
    },
	opts = {
		animation = false,
		clickable = false,
		icons = {button = " "}
	},
	config = function(_, opts)
		require("barbar").setup(opts)
	end
}}
