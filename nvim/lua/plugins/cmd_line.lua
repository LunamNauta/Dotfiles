return {{
	"folke/noice.nvim",
	version = "4.4.7",
  	dependencies = {
		"MunifTanjim/nui.nvim",
    	"rcarriga/nvim-notify",
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
		},
		cmdline = {enabled = true},
		messages = {enabled = true},
		popupmenu = {enabled = true},
		notify = {enabled = true},
		lsp = {progress = {enabled = true}},
		hover = {enabled = true},
		signature = {enabled = true},
		message = {enabled = true},
		status = {enabled = false}
	},
	config = function(_, opts)
		require("noice").setup(opts)
	end
}}
