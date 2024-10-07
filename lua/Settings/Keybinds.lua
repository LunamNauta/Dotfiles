local noerr = nil
local telescope = nil
local transparent = nil
local barbar = nil

noerr, telescope = pcall(require, "telescope")
if noerr then vim.keymap.set("n", "<LEADER>ff", telescope.extensions.file_browser.file_browser)
else vim.notify("Warning: Could not find plugin 'telescope'", vim.log.levels.WARN) end

vim.keymap.set("n", "<LEADER>tn", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<LEADER>tk", "<CMD>bdelete<CR>")
noerr, barbar = pcall(require, "barbar")
if noerr then vim.keymap.set("n", "gt", function() vim.cmd("BufferGoto " .. vim.v.count) end)
else vim.notify("Warning: Could not find plugin 'barbar'", vim.log.levels.WARN) end

vim.keymap.set("n", "<LEADER>di", vim.lsp.buf.hover)
vim.keymap.set("n", "<LEADER>de", function() vim.diagnostic.open_float({border = "rounded"}) end)
vim.keymap.set("n", "<LEADER>ddef", vim.lsp.buf.definition)
vim.keymap.set("n", "<LEADER>dtyp", vim.lsp.buf.type_definition)
