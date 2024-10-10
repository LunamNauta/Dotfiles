WVim = {}
WVim.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1

WVim.languages = {}
WVim.languages.treesitter = {"cpp", "c", "lua", "python", "rust"}
WVim.languages.mason_lsp = {"clangd", "lua_ls", "pylsp", "rust_analyzer"}
WVim.languages.mason_lsp_opts = {
    --If on windows, mason-lspconfig's clangd cannot find MSYS2 headers
    --This 'cmd' is needed in order to locate headers in my build system
    ["clangd"] = {cmd = {"C:\\msys64\\ucrt64\\bin\\clangd.exe"}},
    ["lua_ls"] = {settings = {Lua = {diagnostics = {globals = {"vim"}}}}},
    ["pylsp"] = {},
    ["rust_analyzer"] = {}
}
