local telescope = require("telescope")
vim.keymap.set("n", "<LEADER>ff", telescope.extensions.file_browser.file_browser)

vim.keymap.set("n", "<LEADER>entran", "<CMD>TransparentEnable<CR>")
vim.keymap.set("n", "<LEADER>distran", "<CMD>TransparentDisable<CR>")

vim.keymap.set("n", "<LEADER>tn", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<LEADER>tk", "<CMD>bdelete<CR>")
vim.keymap.set("n", "gt", function() vim.cmd("BufferGoto " .. vim.v.count) end)
