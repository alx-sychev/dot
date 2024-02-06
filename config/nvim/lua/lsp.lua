local lsp_on_attach = function(client)
    kn("K", vim.lsp.buf.hover, {buffer=0})

    kn("gr", t("lsp_references"), {buffer=0})
    kn("gd", vim.lsp.buf.definition, {buffer=0})
    kn("gt", vim.lsp.buf.type_definition, {buffer=0})
    kn("gi", vim.lsp.buf.implementation, {buffer=0})

    kn("<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", {buffer=0})
    kn("<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", {buffer=0})

    kn("<leader>dn", vim.diagnostic.goto_next, {buffer=0})
    kn("<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
    kn("<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})

    kn("<leader>r", vim.lsp.buf.rename, {buffer=0})
    kn("<leader>a", vim.lsp.buf.code_action, {buffer=0})
end

local lua_ls_on_init = function(client)
    local path = client.workspace_folders[1].name

    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                    }
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        })

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end

    return true
end

local lspconfig = require 'lspconfig'

-- -- tailwindcss
-- lspconfig.tailwindcss.setup {
--     on_attach = lsp_on_attach
-- }
-- -- js, ts
-- lspconfig.tsserver.setup {
--     on_attach = lsp_on_attach
-- }
-- -- golang
-- lspconfig.gopls.setup {
--     on_attach = lsp_on_attach
-- }
-- -- php
-- lspconfig.phpactor.setup {
--     on_attach = lsp_on_attach,
--     init_options = {
--         ["language_server_phpstan.enabled"] = false,
--         ["language_server_psalm.enabled"] = false,
--     },
-- }
-- -- lua
-- lspconfig.lua_ls.setup {
--     on_init = lua_ls_on_init,
--     on_attach = on_attach,
-- }
