return {{
	"folke/noice.nvim",
	event = "VeryLazy",
	version = "4.4.7",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify"
	},
	opts = {
		presets = {
			bottom_search = false,
			command_palette = {
				views = {
					cmdline_popup = {
						position = {
							row = "2",
							col = "50%"
						},
						size = {
							min_width = 60,
							width = "auto",
							height = "auto"
						}
					}
				}
			}
		}
	}
}}
