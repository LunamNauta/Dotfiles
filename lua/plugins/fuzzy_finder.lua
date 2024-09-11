return {{
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep"
	},
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				mappings = {
					i = {
						["<ESC>"] = actions.close
					}
				}
			},
			extensions = {
				file_browser = {
					hijack_netrw = true
				}
			}
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("file_browser")
	end
}}
