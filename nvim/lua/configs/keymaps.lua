vim.keymap.set("n", "cwd", function() vim.fn.setreg("*", vim.fn.getcwd()) end)
