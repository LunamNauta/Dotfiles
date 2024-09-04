return {{
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim"
	},
	opts = {
		extensions = {
			file_browser = {
				hijack_netrww = true
			}
		}
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("file_browser")
	end
}}
