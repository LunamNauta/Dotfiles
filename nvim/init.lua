if not vim.g.vscode then
    require('settings.basic')
    require('plugin_manager')
    require('settings.extra')
else
    -- These settings seem to break shit in vscode
    --vim.opt.expandtab = true
    --vim.opt.shiftwidth = 2
    --vim.opt.tabstop = 2

    vim.opt.foldenable = false
    vim.opt.foldlevel = 999
    vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {command="set foldmethod=expr"})

    vim.g.localmapleader = '\\'
    vim.g.mapleader = ' '
    vim.g.c_syntax_for_h = true

    vim.api.nvim_set_option("clipboard", "unnamedplus")
    -- Prevent 'c' from putting removed text in clipboard
    vim.keymap.set("n", "c", '"_c', { noremap = true })
    vim.keymap.set("v", "c", '"_c', { noremap = true })

    vim.keymap.set('n', '<LEADER>tn', [[<Cmd>lua require('vscode').call('workbench.action.files.newUntitledFile')<CR>]], {})
    vim.keymap.set('n', '<LEADER>tk', [[<Cmd>lua require('vscode').call('workbench.action.closeActiveEditor')<CR>]], {})
    vim.keymap.set('n', 'gt', function()
        local count = vim.v.count
        if count > 0 then
            require('vscode').call('workbench.action.openEditorAtIndex', { args = { count - 1 } })
        end
    end, {})

    vim.keymap.set('n', '<LEADER>di', vim.lsp.buf.hover, {})
    vim.keymap.set('n', '<LEADER>de', vim.lsp.buf.hover, {})
    vim.keymap.set('n', '<LEADER>ddef', vim.lsp.buf.definition, {})
    vim.keymap.set('n', '<LEADER>dtyp', vim.lsp.buf.type_definition, {})

    vim.keymap.set('n', '<leader>ff', [[<Cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>]])
    vim.keymap.set('n', '<leader>fg', [[<Cmd>lua require('vscode').call('workbench.action.findInFiles')<CR>]])

    vim.keymap.set('n', 'za', [[<Cmd>lua require('vscode').call('editor.toggleFold')<CR>]], {})
    vim.keymap.set('n', 'zo', [[<Cmd>lua require('vscode').call('editor.unfold')<CR>]], {})
    vim.keymap.set('n', 'zc', [[<Cmd>lua require('vscode').call('editor.fold')<CR>]], {})
    vim.keymap.set('n', 'zM', [[<Cmd>lua require('vscode').call('editor.foldAll')<CR>]], {})
    vim.keymap.set('n', 'zR', [[<Cmd>lua require('vscode').call('editor.unfoldAll')<CR>]], {})

    vim.api.nvim_create_user_command('W', function()
        require('vscode').call('workbench.action.files.save')
    end, {})

    vim.api.nvim_create_user_command('Q', function()
        require('vscode').call('workbench.action.closeActiveEditor')
    end, {})

    vim.api.nvim_create_user_command('Wq', function()
        require('vscode').call('workbench.action.files.save')
        require('vscode').call('workbench.action.closeActiveEditor')
    end, {})
end
