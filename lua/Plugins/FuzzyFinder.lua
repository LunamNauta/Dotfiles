return {
{
	"nvim-telescope/telescope-fzf-native.nvim",
	build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
},
{
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim"
	},
	opts = function()
		local actions = require("telescope.actions")
		return{
			extensions = {
				file_browser = {
					hijack_netrw = true,
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case"
				}
			},
			defaults = {
				mappings = {
					i = {
						["<ESC>"] = actions.close
					}
				}
			}
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("file_browser")
		telescope.load_extension("fzf")
	end
}
}
