return {{
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim"
	},
	config = function(_, _)
		require("telescope").setup({
			extensions = {
				file_browser = {
					hijack_netrw = true
				}
			},
			defaults = {
				mappings = {
					i = {
						["<ESC>"] = require("telescope.actions").close
					}
				}
			}
		})
		require("telescope").load_extension("file_browser")
	end
}}
